<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);
if (isset($_POST["idProduto"])) {
	$sql = "SELECT idProduto FROM produto WHERE idProduto=" . $_POST["idProduto"];
	$result = mysqli_query($con, $sql);
	if (mysqli_num_rows($result) != 0) {
		$sql = "UPDATE produto SET descricao='" . $_POST["descricao"] . "',titulo=" . $_POST["titulo"] . ",preco=" . $_POST["preco"] . ",estoque=" . $_POST["estoque"] . ",idFilial=" . $_POST["idFilial"] . " WHERE idProduto=" . $_POST["idProduto"];
	}
} else {
	$sql = "INSERT INTO produto VALUES (null," . $_POST["descricao"] . ",'" . $_POST["titulo"] . "','" . $_POST["preco"] . "','" . $_POST["estoque"] . "','" . $_POST["idFilial"] . "')";
}
mysqli_query($con, $sql);
mysqli_close($con);
header("location: ./listar_produto.php");
