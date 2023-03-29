<?= require(APPROOT . '/views/includes/Navbar.php');?>

<div class="card">
    <h2>Details optiepakket</h2>
    <div class="row">
        <h3>Optiepakket:</h3>
        <form action="<?= URLROOT; ?>reservering/pakketOptieWijzigen/<?= $data['id'] ?>" method="post" class="formcolumn">
            <select name="optiepakket">
                <option value="1">Snackpakket basis</option>
                <option value="2">Snackpakket luxe</option>
                <option value="3">Kinderpartij</option>
                <option value="4">vrijgezellenfeest</option>
            </select>
            <button type="sumbit">Wijzigen</button>
        </form>
    </div>
    <p><?= $data['notification'] ?></p>
</div>








<?php require(APPROOT . '/views/includes/Footer.php');?>