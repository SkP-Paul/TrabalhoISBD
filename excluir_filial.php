<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);
$sql = "DELETE FROM filial WHERE idFilial=".$_GET["idFilial"];
mysqli_query($con, $sql);
header("location: ./listar_filial.php");
