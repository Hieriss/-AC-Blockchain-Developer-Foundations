// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistryV2 {
    address public owner;

    struct Student {
        string name;
        uint age;
        bool isRegistered;
    }

    mapping(address => Student) private students;

    event StudentAdded(address indexed studentAddress, string name, uint age);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner!");
        _;
    }

    function registerStudent(address _studentAddress, string memory _name, uint _age) public onlyOwner {
        require(!students[_studentAddress].isRegistered, "Student is already registered!");
        
        students[_studentAddress] = Student({
            name: _name,
            age: _age,
            isRegistered: true
        });

        emit StudentAdded(_studentAddress, _name, _age);
    }

    function getStudent(address _studentAddress) public view returns (string memory name, uint age, bool isRegistered) {
        Student memory student = students[_studentAddress];
        return (student.name, student.age, student.isRegistered);
    }

    function isStudentRegistered(address _studentAddress) public view returns (bool) {
        return students[_studentAddress].isRegistered;
    }
}
