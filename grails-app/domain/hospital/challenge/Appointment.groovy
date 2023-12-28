package hospital.challenge

class Appointment {

    Date startDate
    Date endDate
    String patientName
    Doctor doctor
    MedicalOffice medicalOffice
    Boolean isCanceled = 0

    static belongsTo = [ Doctor, MedicalOffice ]

    static constraints = {
        startDate nullable: false
        endDate nullable: false
        patientName nullable: false
        doctor nullable: false
        medicalOffice nullable: false
    }
}
