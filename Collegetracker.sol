// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Collegetracker{
    
    address public owner;

     struct college{
        string Cname;
        string Cid;
        address Cadd;
        string status;
        uint numstud;
    }

    struct student {
        string cname;
        string sname;
        uint phoneno;
        string course;
    }

    constructor() public {
        owner=msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender==owner);
        _;
    }
      
    mapping(string => student) public StudtoCollege;

    string _block = "This College is Blocked for registration";
    string _unblock = "unblock";

    mapping(address => college) public colleges;

    function AddCollege(string memory _Cname, string memory _Cid, address _Cadd,string memory _status,uint _numstud) public onlyOwner {

        _numstud = 0;
        colleges[_Cadd]= college(_Cname,_Cid,_Cadd,_status, _numstud);
        //C456
        //C559
    }

    function GetCollege(address _Id) external view returns(string memory,string memory,address,string memory, uint) { 
    
        return (colleges[_Id].Cname, colleges[_Id].Cid, colleges[_Id].Cadd, colleges[_Id].status, colleges[_Id].numstud);
    }

    function BlockCollege(address _Id) public {
        colleges[_Id].status = "blocked";
    }

    function UnblockCollege(address _Id) public {
        colleges[_Id].status = "unblocked";
    }

    function AddStudent(string memory _Cadd, address _Id, string memory _sname,uint _phoneno, string memory _course) public onlyOwner returns(string memory){
        if(keccak256(bytes(colleges[_Id].status)) == keccak256(bytes("blocked"))){
            return _block;
        }
        else{
            require(colleges[_Id].Cadd == msg.sender);
        StudtoCollege[_sname]=student(_Cadd,_sname, _phoneno, _course);
        colleges[_Id].numstud++;
        }
    }
    
    function ViewStudent(string memory _sname) external view returns(string memory,string memory, uint, string memory){
        return (StudtoCollege[_sname].cname, StudtoCollege[_sname].sname, StudtoCollege[_sname].phoneno, StudtoCollege[_sname].course);
    }

    function ChangeStudentCourse(string memory _sname, string memory _newcourse) public onlyOwner returns(string memory){
        StudtoCollege[_sname].course = _newcourse;
        return _newcourse;
    }

        
}
