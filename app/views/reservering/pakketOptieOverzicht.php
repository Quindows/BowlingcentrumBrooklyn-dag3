<?= require(APPROOT . '/views/includes/Navbar.php');?>
<div>
    <table>
        <caption>Overzicht reserveringen</caption>
        <thead>
            <th>Voornaam</th>
            <th>Tussenvoegsel</th>
            <th>Achternaam</th>
            <th>Datum</th>
            <th>Aantal Volwassenen</th>
            <th>Aantal Kinderen</th>
        </thead>
        <tbody>
            <?= $data['rows']; ?>
        </tbody>
    </table>
</div>

<?php require(APPROOT . '/views/includes/Footer.php');?>