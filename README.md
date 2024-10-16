# EHRManagement Smart Contract - Module 1 Functions and Errors Project

## Introduction

The **EHRManagement** smart contract is designed to manage Electronic Health Records (EHR) on the Ethereum blockchain. It allows patients to securely store, update, retrieve, and delete their medical records. Each record is associated with an Ethereum address and includes a patient ID, name, and diagnosis.

## Features

- **Add Patient Record**: Patients can add their records, including a unique `patientId`, `name`, and `diagnosis`.
- **Update Diagnosis**: Patients can update their diagnosis based on their `patientId`.
- **Retrieve Patient Record**: Patients can retrieve their stored records.
- **Delete Patient Record**: Patients can delete their records based on their `patientId`.

## Prerequisites

- Solidity ^0.8.26
- Ethereum wallet (such as MetaMask)
- A testnet environment (like Ropsten, Rinkeby, or local Ethereum environment)

## Installation

1. Clone the repository.
   ```bash
   git clone <repository-url>
   cd EHRManagement
   ```
2. Deploy the `EHRManagement` contract using Remix IDE or Hardhat.

## Contract Details

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EHRManagement {
    struct Patient {
        uint256 patientId;
        string name;
        string diagnosis;
    }

    mapping(address => Patient) public patients;

    function addPatient(uint256 patientId, string memory name, string memory diagnosis) public {
        require(patientId > 0, "Patient ID should be above 0");
        Patient memory patient = Patient(patientId, name, diagnosis);
        patients[msg.sender] = patient;
    }

    function updateMedicalRecord(uint256 patientId, string memory newDiagnosis) public {
        require(patients[msg.sender].patientId == patientId, "Patient ID entered is wrong");
        patients[msg.sender].diagnosis = newDiagnosis;
    }

    function getPatient() public view returns (uint256 pid, string memory name, string memory diagnosis) {
        Patient memory patient = patients[msg.sender];
        assert(patient.patientId > 0); // This checks that patientId should never be 0 for a valid patient
        return (patient.patientId, patient.name, patient.diagnosis);
    }

    function deletePatient(uint256 patientId) public {
        Patient memory patient = patients[msg.sender];
        if (patient.patientId != patientId) {
            revert("Patient ID does not match for deletion");
        }
        delete patients[msg.sender];
    }
}
```

## Usage

1. **Adding a Patient Record**:
   - Call the `addPatient` function with the parameters:
     - `patientId`: Unique identifier for the patient.
     - `name`: Patient's full name.
     - `diagnosis`: Initial diagnosis details.

2. **Updating a Diagnosis**:
   - Call the `updateMedicalRecord` function with the parameters:
     - `patientId`: ID of the patient.
     - `newDiagnosis`: Updated diagnosis information.

3. **Retrieving a Patient Record**:
   - Call the `getPatient` function. This will return:
     - `patientId`: The ID of the patient.
     - `name`: The name of the patient.
     - `diagnosis`: The current diagnosis of the patient.

4. **Deleting a Patient Record**:
   - Call the `deletePatient` function with the parameter:
     - `patientId`: ID of the patient to be deleted.

## Error Handling

- **require**:
  - Used for input validation, ensuring that certain conditions are met before proceeding.
  - Example: `require(patientId > 0, "Patient ID should be above 0");` ensures that the patient ID is greater than zero when adding a record.
  
- **assert**:
  - Used for internal consistency checks.
  - Example: `assert(patient.patientId > 0);` ensures that a patient record exists when retrieving it.
  
- **revert**:
  - Used to abort the function execution if conditions are not met.
  - Example: `revert("Patient ID does not match for deletion");` is triggered if the patient ID does not match when attempting to delete a record.
