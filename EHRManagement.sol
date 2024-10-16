// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EHRManagement {
    struct Patient {
        uint256 patientId;
        string name;
        string diagnosis;
    }

    mapping(address => Patient) public patients;

    // Functions for adding patients
    function addPatient(uint256 patientId, string memory name, string memory diagnosis) public {
        // 1. Using require to validate the patientId
        require(patientId > 0, "Patient ID should be above 0");

        // Adding the patient record
        Patient memory patient = Patient(patientId, name, diagnosis);
        patients[msg.sender] = patient;
    }

    // Function for updating records
    function updateMedicalRecord(uint256 patientId, string memory newDiagnosis) public {
        // 2. Using require to ensure the patient exists
        require(patients[msg.sender].patientId == patientId, "Patient ID entered is wrong");

        // Updating diagnosis
        patients[msg.sender].diagnosis = newDiagnosis;
    }

    // Functions for retrieving records
    function getPatient() public view returns (uint256 pid, string memory name, string memory diagnosis) {
        // Retrieving patient details
        Patient memory patient = patients[msg.sender];

        // 3. Using assert to check an invariant (internal error checking)
        assert(patient.patientId > 0); // This checks that patientId should never be 0 for a valid patient

        return (patient.patientId, patient.name, patient.diagnosis);
    }

    // Function for deleting a patient record
    function deletePatient(uint256 patientId) public {
        Patient memory patient = patients[msg.sender];

        // 4. Using revert to abort if certain conditions are not met
        if (patient.patientId != patientId) {
            revert("Patient ID does not match for deletion");
        }

        // Resetting the patient record to default (essentially deleting it)
        delete patients[msg.sender];
    }
}
