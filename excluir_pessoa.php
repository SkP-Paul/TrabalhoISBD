<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);
$sql = "DELETE FROM pessoa WHERE idPessoa=".$_GET["idPessoa"];
mysqli_query($con, $sql);
header("location: ./listar_pessoa.php");
