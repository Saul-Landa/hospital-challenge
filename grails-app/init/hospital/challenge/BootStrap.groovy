package hospital.challenge

class BootStrap {

    def helperService

    def init = { servletContext ->
        createDoctors()
        createMedicalOffices()
    }

    def destroy = {
    }

    def createDoctors() {
        def doctors = helperService.buildDoctors()

        doctors.each {
            if (!Doctor.findByFirstNameAndFatherLastName(it?.firstName, it?.fatherLastName)) {
                it?.save()
            }
        }
    }

    def createMedicalOffices() {
        def medicalOffices = helperService.buildMedicalOffices()

        medicalOffices.each {
            if(!MedicalOffice.findByNumberAndFloor(it?.number, it?.floor)) {
                it?.save()
            }
        }
    }
}
