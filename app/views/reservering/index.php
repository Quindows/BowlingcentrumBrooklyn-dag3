<?= require(APPROOT . '/views/includes/Navbar.php');?>
<div>
    <div class="reserveringTitel">
        <p>Reservering van <?= $data['naam'] ?></p>
        <form action="<?= URLROOT; ?>reservering/index" method="post">
            <input type="date" name="datum" required>
            <button type="submit">Toon reserveringen</button>
        </form>
    </div>
    <table>
        <thead>
            <th>Naam</th>
            <th>Datum</th>
            <th>Aantal uren</th>
            <th>BeginTijd</th>
            <th>EindTijd</th>
            <th>Aantal Volwassenen</th>
            <th>Aantal Kinderen</th>
        </thead>
        <tbody>
            <?= $data['rows']; ?>
        </tbody>
    </table>
</div>

<?php require(APPROOT . '/views/includes/Footer.php');?>