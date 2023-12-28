package hospital.challenge

class AppointmentController {

    def appointmentService

    def index() {
        def appointmentsList = appointmentService.list(params)
        [
                appointmentsList: appointmentsList,
                appointmentsListCount: appointmentsList?.getTotalCount(),
                doctors: Doctor.findAll(),
                medicalOffices: MedicalOffice.findAll()
        ]
    }

    def create() {
        [doctors: Doctor.findAll(), medicalOffices: MedicalOffice.findAll(), appointment: new Appointment()]
    }

    def save() {
        def response = appointmentService.save(params)
        if (response?.errors) {
            flash.errors = response?.errors
            redirect(action: 'create', model: [ appointment: response?.appointment])
            return
        }

        flash.message = "${message(code: 'default.created.message', args: [message(code: 'default.appointment.label'), response?.appointment?.id])}"
        redirect action:'edit', id: response?.appointment?.id
    }

    def edit(Long id) {
        def appointment = id ? appointmentService.getById(id) : null
        if (!appointment) {
            notFound()
            return
        }
        [doctors: Doctor.findAll(), medicalOffices: MedicalOffice.findAll(), appointment: appointment]
    }

    def update(Long id) {
        def response = appointmentService.update(id, params)
        if (response?.errors) {
            flash.errors = response?.errors
            redirect(action: 'edit', id: id)
            return
        }

        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'default.appointment.label'), response?.appointment?.id])}"
        redirect action: 'edit', id: response?.appointment?.id
    }

    def cancel(Long id) {
        def response = appointmentService.cancel(id)
        if (response?.errors) {
            flash.errors = response?.errors
            redirect(action: 'index')
            return
        }

        flash.message = response?.message
        redirect action:'index'

    }

    protected void notFound() {
        flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'default.appointment.label'), params?.id])}"
        redirect action: "index", method: "GET"
    }
}
