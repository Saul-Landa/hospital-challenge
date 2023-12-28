package hospital.challenge

class MedicalOffice {

    String number
    String floor
    String room

    static mapping = {
        room formula: "CONCAT( IFNULL(number,''),' - ', IFNULL(floor,''))"
    }

    static constraints = {
        number nullable: false, blank: false
        floor nullable: false, blank: false
    }
}
