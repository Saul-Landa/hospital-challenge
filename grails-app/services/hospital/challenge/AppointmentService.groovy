package hospital.challenge

import grails.gorm.services.Service

import java.text.SimpleDateFormat

@Service(Appointment)
class AppointmentService {

    String pattern = "MM/dd/yyyy hh:mm:ss a"
    def messageSource

    def list(params) {
        params.max = params?.max ?: 10
        params?.offset = params?.offset ? params?.offset as Integer : 0
        def dateRange = null
        if (params?.startDate) {
            SimpleDateFormat dateFormatStart = new SimpleDateFormat("MM/dd/yyyy")
            def date = dateFormatStart.parse(params?.startDate)
            dateRange = createRange(date)
        }

        def appointmentsList = Appointment.createCriteria().list(max: params?.max, offset: params?.offset) {
            if(params?.medicalOffice) {
                medicalOffice {
                    eq('id', params.long('medicalOffice'))
                }
            }
            if(params?.doctor) {
                doctor {
                    eq('id', params.long('doctor'))
                }
            }
            if (dateRange) {
                between('startDate', dateRange.startDate, dateRange.endDate)
            }
        }

        return appointmentsList
    }

    def validateOffice(Appointment appointment) {
        return Appointment.createCriteria().list() {
            medicalOffice {
                eq('id', appointment?.medicalOffice?.id)
            }
            or {
                between('startDate', appointment.startDate, appointment.endDate)
                between('endDate', appointment.startDate, appointment.endDate)
            }
        }
    }

    def validateDoctor(Appointment appointment) {
        return Appointment.createCriteria().list() {
            doctor {
                eq('id', appointment?.doctor?.id)
            }
            or {
                between('startDate', appointment.startDate, appointment.endDate)
                between('endDate', appointment.startDate, appointment.endDate)
            }
        }
    }

    def validateTotal(Appointment appointment) {
        def range = createRange(appointment.startDate)

        return Appointment.countByStartDateBetweenAndDoctor(range.startDate, range.endDate, appointment?.doctor)
    }

    def validatePatient(Appointment appointment) {
        Calendar calendarStart = Calendar.getInstance()
        calendarStart.time = appointment.startDate
        calendarStart.add(Calendar.HOUR_OF_DAY, -2)
        Calendar calendarEnd = Calendar.getInstance()
        calendarEnd.time = appointment.endDate
        calendarEnd.add(Calendar.HOUR_OF_DAY, 2)

        Appointment.createCriteria().list() {
            eq('patientName', appointment.patientName)
            or {
                between('startDate', calendarStart.time, calendarEnd.time)
                between('endDate', calendarStart.time, calendarEnd.time)
            }
        }
    }

    def save(params) {
        Appointment.withTransaction { status ->
            def appointment = buildAppointment(new Appointment(), params)

            if (validateOffice(appointment)) return [ errors: "Ya existe una cita es este consultario a esta hora", appointment: appointment ]
            if (validateDoctor(appointment)) return [ errors: "El doctor ya tiene una cita esta hora", appointment: appointment ]
            if (validateTotal(appointment) > 8) return [ errors: "El doctor ya tiene 8 citas para este día", appointment: appointment ]
            if (validatePatient(appointment)) return [ errors: "El paciente tiene una cita próxima (2 horas)", appointment: appointment ]

            if(!appointment.validate()){
                status.setRollbackOnly()
                def errors = ""
                appointment.errors.allErrors.each {error ->
                    errors += "${ messageSource.getMessage(error, null) }\n"
                }
                return [ errors: errors, appointment: appointment ]
            }

            appointment.save(flush:true)
            return [ appointment: appointment ]
        }
    }

    def update(appointmentId, params) {
        def appointment = getById(appointmentId)
        Appointment.withTransaction { status ->
            appointment = buildAppointment(appointment, params)

            if (validateOffice(appointment) && validateOffice(appointment)[0]?.id != appointment?.id) return [ errors: "Ya existe una cita es este consultario a esta hora"]
            if (validateDoctor(appointment) && validateDoctor(appointment)[0]?.id != appointment?.id) return [ errors: "El doctor ya tiene una cita esta hora"]
            if (validatePatient(appointment) && validatePatient(appointment)[0]?.id != appointment?.id) return [ errors: "El paciente tiene una cita próxima (2 horas)" ]

            if(!appointment.validate()){
                status.setRollbackOnly()
                def errors = ""
                appointment.errors.allErrors.each {error ->
                    errors += "${ messageSource.getMessage(error, null) }\n"
                }
                return [ errors: errors ]
            }

            appointment.save(flush:true)
            return [ appointment: appointment ]
        }
    }

    def getById(appointmentId) {
        return Appointment.get(appointmentId)
    }

    def buildAppointment(Appointment appointment, params) {
        appointment.startDate = convertStringToDate(params?.startDate)
        appointment.endDate = convertStringToDate(params?.endDate)
        appointment.doctor = Doctor.get(params?.doctor as Long)
        appointment.medicalOffice = MedicalOffice.get(params?.medicalOffice as Long)
        appointment.patientName = params?.patientName

        return appointment
    }

    def convertStringToDate(dateString) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern)
        return dateFormat.parse(dateString)
    }

    def createRange(date) {
        SimpleDateFormat dateFormatStart = new SimpleDateFormat("MM/dd/yyyy 00:00:00")
        Date startDay = dateFormatStart.parse(dateFormatStart.format(date))

        [ startDate: startDay, endDate: startDay + 1 ]
    }

    def cancel(appointmentId) {
        def appointment = getById(appointmentId)
        if (appointment.isCanceled) {
            return [ errors: "La cita ya estaba cancelada" ]
        }

        def currentDate = new Date()
        if (appointment.startDate < currentDate ) {
            return [ errors: "La cita ya se llevó acabo, no se puede cancelar" ]
        }

        Appointment.withTransaction { status ->
            appointment.isCanceled = true
            appointment.save(flush: true)

            return [ message: 'La cita ha sido cancelada' ]
        }
    }
}