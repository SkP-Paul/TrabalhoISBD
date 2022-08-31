<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);
$sql = "DELETE FROM pedido WHERE idPedido=".$_GET["idPedido"];
mysqli_query($con, $sql);
header("location: ./listar_pedido.php");
