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
        $info = [];
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
                    <td>$value->pakket</td>
                    <td>
                        <a href='../reservering/pakketOptieWijzigen/$value->id'>
                            <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'>
                                <path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/>
                                <path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z'/>
                            </svg>   
                        </a>
                    </td>
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

   public function pakketOptieWijzigen($id = null){
       $data = ["notification" => "",
       "id" => $id]; 
       
       if($_SERVER['REQUEST_METHOD'] == 'POST'){
            try{
                // filtert voor sql injecties
                $_POST = filter_input_array(INPUT_POST, FILTER_SANITIZE_FULL_SPECIAL_CHARS); 

                // VALIDATIE VAN DE INPUT
                $data = $this->validatiePakketOptie($data, $id, $_POST);

                if (strlen($data["notification"]) < 1) {
                    // VOERT DE UPDATE UIT
                    $result = $this->model->updatePakketOptie($_POST, intval($id));

                    // CHECKT OF HET IS GELUKT
                    if ($result) {
						$data['notification'] = "Pakket aangepast!";
						header("Refresh: 3; url=" . URLROOT . "reservering/pakketOptieOverzicht");
					} else {
                         
						$data['notification'] = "er is iets mis gegaan, probeer opnieuw.";
					}
                }
            } catch (PDOException $e) {
                 
				echo $e;
				$data['notification'] = "er is iets mis gegaan, probeer opnieuw.";
			}
        }
        else {
            $data['notification'] = ' ';
        }
        $this->view('reservering/pakketOptieWijzigen', $data);
    }

       // VALIDATIE METHOD VOOR CREATE EN UPDATE
       public function validatiePakketOptie($data, $id, $post){
        // checkt in het database of er kinderen aanwezig zijn
        $checkKind = $this->model->findKinderen($id);
        if ($checkKind->AantalKinderen > 0 && $post['optiepakket'] == 4)
            $data['notification'] = "Het pakket vrijgezellenfeest is niet bedoelt voor kinderen";
        return($data);
    }
}