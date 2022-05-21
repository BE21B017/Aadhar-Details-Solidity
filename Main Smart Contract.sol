//MyInterface.sol
pragma solidity >=0.7.0 <0.9.0;

interface MyInterface {

    struct Person {
        uint aadharnumber;
        string name;
        address Address;
        address walletaddress;
        uint dateofbirth;
    }
}
//Registerperson.sol
pragma solidity >=0.7.0 <0.9.0;

import "./MyInterface.sol";

contract RegisterPerson is MyInterface {

    mapping (uint => Person) persons;

    Person myPersons;

    constructor (Person memory _myPersons) {
        myPersons = _myPersons;
    }

    function addPerson (
        uint _aadharnumber,
        string memory _name,
        address memory _Address,
        address memory _walletaddress,
        uint _dateofbirth
    ) public {

        Person storage newPerson = persons[_aadharnumber];

        newPerson.aadharnumber = _aadharnumber;
        newPerson.name = _name;
        newPerson.Address =_Address;
        newPerson.walletaddress =_walletaddress;
        newPerson.dateofbirth = _dateofbirth;
    }
}
//GetPerson.sol
pragma solidity >=0.7.0 <0.9.0;

import "./MyInterface.sol";

contract GetPerson is MyInterface {
    mapping (uint => Person) persons;

    Person myPersons;

    constructor (Person memory _myPersons) {
        myPersons = _myPersons;
    }

    function askPerson(uint _aadharnumber) public view
    returns (uint aadharnumber, string memory name, address memory Address, address memory walletaddress, uint dateofbirth) {
        
        Person storage returnPerson = persons[_aadharnumber];

        return (returnPerson.aadharnumber, returnPerson.name, returnPerson.Address, returnPerson.walletaddress, returnPerson.dateofbirth);

    }

}
//MainSmartContract.sol
pragma solidity >=0.7.0 <0.9.0;

import "./MyInterface.sol";
import "./RegisterPerson.sol";
import "./GetPerson.sol";

contract PCore is MyInterface{

    address regPersonA;
    address getPersonA;

    constructor(Person memory _myPersons) {
        RegisterPerson _registerPerson = new RegisterPerson(_myPersons);
        GetPerson _getPerson = new GetPerson(_myPersons);
        regPersonA = address(_registerPerson);
        getPersonA = address(_getPerson);
        super;
    }

    function registerPerson(
        uint _aadharnumber,
        string memory _name,
        address memory _Address,
        address memory _walletaddress,
        uint _dateofbirth
    ) public {
        RegisterPerson _registerPerson = RegisterPerson(regPersonA);

        _registerPerson.addPerson(_aadharnumber, _name, _Address, _walletaddress, _dateofbirth);
    }

    function getPerson(
        uint _aadharnumber
    ) public view
    returns (uint aadharnumber, string memory name, address memory Address, address memory walletaddress, uint dateofbirth) 
    {
        GetPerson _getPerson = GetPerson(getPersonA);

        (aadharnumber, name, Address, walletaddress, dateofbirth) = _getPerson.askPerson(_aadharnumber);
        return (aadharnumber, name, Address, walletaddres, dateofbirth);
    }

}
