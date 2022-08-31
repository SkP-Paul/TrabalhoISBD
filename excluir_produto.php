<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);
$sql = "DELETE FROM produto WHERE idProduto=".$_GET["idProduto"];
mysqli_query($con, $sql);
header("location: ./listar_produto.php");
?>