<?php

class ReserveringModel{

    private $db;

    public function __construct(){
        $this->db = new Database();
    }

    public function getReserveringenByIdDate($id, $datum){
        // error catcher
        try{
            // Database query voor reservation overzicht
            $this->db->query('SELECT 
                            per.Voornaam as voornaam,
                            per.Tussenvoegsel as tussenvoegsel,
                            per.Achternaam as achternaam,
                            res.Datum as datum,
                            res.AantalUren as aantalUren,
                            res.BeginTijd as beginTijd,
                            res.EindTijd as eindTijd,
                            res.AantalVolwassen as volwassenen,
                            res.AantalKinderen as kinderen
                        from reservering res
                        inner join persoon per
                        on per.Id = res.PersoonId
                        where res.PersoonId = :Id
                        and res.Datum >= :Datum;');
            $this->db->bind(':Id', $id, PDO::PARAM_INT);
            $this->db->bind(':Datum', $datum, PDO::PARAM_STR);
            return $this->db->resultSet();
        } catch(PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }

    public function pakketoptieOverzicht($id){
        // error catcher
        try{
            $this->db->query('SELECT 
                                res.Id as id,
                                per.Voornaam as voornaam,
                                per.Tussenvoegsel as tussenvoegsel,
                                per.Achternaam as achternaam,
                                res.Datum as datum,
                                res.AantalVolwassen as volwassenen,
                                res.AantalKinderen as kinderen,
                                pak.Naam as pakket
                            from reservering res
                            inner join persoon per
                            on per.Id = res.PersoonId
                            left join pakketoptie pak
                            on pak.Id = pakketoptieId
                            where res.PersoonId = :Id;');
            $this->db->bind(':Id', $id, PDO::PARAM_INT);
            return $this->db->resultSet();
        } catch(PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }
    
    public function updatePakketOptie($data, $id){
        $this->db->query('UPDATE reservering
                        set PakketOptieId = :optie
                        where Id = :id;');
        $this->db->bind('id', $id, PDO::PARAM_INT);
        $this->db->bind(':optie', $data['optiepakket'], PDO::PARAM_INT);
        return $this->db->execute();
    }

    public function findKinderen($id){
        $this->db->query('SELECT AantalKinderen 
                        from reservering
                        where Id = :id;');
        $this->db->bind(':id', $id, PDO::PARAM_INT);
        return $this->db->single();
    }
}
