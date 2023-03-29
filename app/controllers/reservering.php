<?php

class Reservering extends controller{
    public function __construct(){
        $this->model = $this->model('ReserveringModel');
    }

    public function index(){
        if($_SERVER['REQUEST_METHOD'] == 'POST'){
            $records = $this->model->getReserveringenByIdDate(1, $_POST['datum']);  
        } else {
            $records = $this->model->getReserveringenByIdDate(1, '2022-01-01');
        }

        $rows = '';
        $naam = '';
        // checkt of er reserveringen zijn
        if($records == null){
            $rows .= '<h2>Geen informatie over deze periode</h2>';
        } else {
            foreach($records as $value){
                if($value->tussenvoegsel){
                    $naam = $value->voornaam . ' ' . $value->tussenvoegsel . ' ' . $value->achternaam; 
                } else {
                    $naam = $value->voornaam . ' ' . $value->achternaam;
                }

                // bouwt de tabel inhoud
                $rows .= "
                <tr>
                    <td>$value->voornaam</td>
                    <td>$value->datum</td>
                    <td>$value->aantalUren</td>
                    <td>$value->beginTijd</td>
                    <td>$value->eindTijd</td>
                    <td>$value->volwassenen</td>
                    <td>$value->kinderen</td>
                </tr>";
            }
        }

        // array voor alle data om mee te sturen naar de view
        $data = [
            'naam' => $naam,
            'rows' => $rows
        ];

        // redirect naar de view
        $this->view('reservering/index', $data);

   }   

    public function pakketOptieOverzicht(){
        $records = $this->model->pakketoptieOverzicht(1);

        $rows = '';
        // checkt of er reservaties zijn
        if($records == null){
            $rows .= "<h2>Geen reserveringen</h2>";
        } else {
            foreach($records as $value){
                // zorgt dat wanneer tussenvoegsel leeg is, er geen error komt
                if($value->tussenvoegsel == null){
                    $value->tussenvoegsel = ' ';
                }

                // zorgt dat wanneer kinderen leeg is, er geen error komt
                if($value->kinderen == null){
                    $value->kinderen = 'geen';
                }

                $rows .= "
                <tr>
                    <td>$value->voornaam</td>
                    <td>$value->tussenvoegsel</td>
                    <td>$value->achternaam</td>
                    <td>$value->datum</td>
                    <td>$value->volwassenen</td>
                    <td>$value->kinderen</td>
                </tr>";
            }
        }

        // array voor alle data om mee te sturen naar de view
        $data = [
            'rows' => $rows
        ];

        // redirect naar de view
        $this->view('reservering/pakketOptieOverzicht', $data);
   }
}