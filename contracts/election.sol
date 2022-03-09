// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Election{


  address public admin;
  uint id;
  uint public NBvote;
  uint256 private enddate;
  
  constructor(){
    admin=msg.sender;
    enddate = block.timestamp + 604800;

  }

   // struct condidat
       struct CANDIDAT{

          uint idcandidat;
          string nom;
          uint nbrVoix;
       }
      //struct electeur
       struct ELECTEUR{
        bool permit;
        bool djaVote;
        uint choix;
       }
     


      //mapping
       mapping(uint=>CANDIDAT) public candidats;
       mapping(address=>ELECTEUR) public electeurs;

      

    
      //evenment
       event save(address indexed admin,string nom);
       event permis(address indexed admin, address indexed electeur);
       event Vote(address indexed electeur,uint choix);


      //les fonction
       function savcandidat(string memory _nom) public{
         require (msg.sender==admin,"you are note admin");
          id++;
          candidats[id]=CANDIDAT(id,_nom,0);
          emit save(msg.sender, _nom);
     }
       
     
     function permission(address _electeur)public{

       require(msg.sender==admin,"you are note admin");
       electeurs[_electeur].permit=true;
       emit permis(msg.sender,_electeur);
       }
    
    function changeEnddate(uint256 _newEnddate) public {
      require(msg.sender == admin, "it's note your job");
      enddate = _newEnddate;
    }      
     

     function getEnddate()public view returns (uint256){
       return enddate;
     }
     


     function voter(uint _choix)public {
       require(msg.sender !=admin,"you are admin");
       require(electeurs[msg.sender].djaVote==false,"you have already voted");
       require(electeurs[msg.sender].permit==true,"you are not a voter");
        electeurs[msg.sender].choix=_choix;
        electeurs[msg.sender].djaVote==true;
        candidats[_choix].nbrVoix ++;
        NBvote+=1;
     
        emit Vote(msg.sender,_choix);
     }

}