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
}