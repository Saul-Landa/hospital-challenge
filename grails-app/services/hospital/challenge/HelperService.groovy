package hospital.challenge

import grails.gorm.transactions.Transactional

@Transactional
class HelperService {

    def buildDoctors() {
        [
                new Doctor( firstName: 'Saúl', fatherLastName: 'Landa', motherLastName: 'García', specialty: 'Cardiología' ),
                new Doctor( firstName: 'Daniela', fatherLastName: 'Espinoza', motherLastName: 'García', specialty: 'Dermatología' ),
                new Doctor( firstName: 'Felipe', fatherLastName: 'Hernández', motherLastName: 'Morales', specialty: 'Gastroenterología' ),
                new Doctor( firstName: 'Gustavo', fatherLastName: 'Flores', motherLastName: 'Luna', specialty: 'Pediatría' ),
        ]
    }

    def buildMedicalOffices() {
        [
                new MedicalOffice( number: '2-A', floor: 'Nivel 1' ),
                new MedicalOffice( number: '3', floor: 'Nivel 2' ),
                new MedicalOffice( number: '5', floor: 'Nivel 3' ),
                new MedicalOffice( number: '6-A', floor: 'Nivel 1' ),
                new MedicalOffice( number: '12', floor: 'Nivel 2' ),
        ]
    }
}
