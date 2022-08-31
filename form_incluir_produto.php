<?php
header("Content-Type: text/html; charset=iso-8859-1",true);
?>
<html>
<head><title>Incluir/Editar um produto.</title></head>
<body>
<form name="form1" method="POST" action="incluir_produto.php">
<?php
if(isset($_GET["idProduto"])){	
  include("./config.php");
  $con = mysqli_connect($host, $login, $senha, $bd);
?>
  <center><h3>Editar Produto</h3></center>
<?php
  $sql = "SELECT * FROM produto WHERE idProduto=".$_GET['idProduto'];
  $result = mysqli_query($con, $sql);
  $vetor = mysqli_fetch_array($result, MYSQLI_ASSOC);
  mysqli_close($con);
?>
  <input type="hidden" name="idProduto" value="<?php echo $_GET['idProduto']; ?>">
<?php
}else{
?>
  <center><h3>Cadastrar Novo Produto</h3></center>
<?php
}
?>
<table border="0" align="center" width="35%">
<tr><td width="20%">Descricao:</td>
    <td colspan="2" width="90%">
	  <input type="text" name="descricao" value="<?php echo @$vetor['descricao']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Titulo:</td>
    <td colspan="2" width="90%">
	  <input type="text" name="titulo" value="<?php echo @$vetor['titulo']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Preco:</td>
    <td colspan="2" width="90%">
	  <input type="number" name="preco" value="<?php echo @$vetor['preco']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Estoque:</td>
    <td colspan="2" width="90%">
	  <input type="number" name="estoque" value="<?php echo @$vetor['estoque']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Filial:</td>
    <td colspan="2" width="90%">
	  <input type="number" name="idFilial" value="<?php echo @$vetor['idFilial']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td colspan="3" align="center">
      <input type="button" value="Cancelar" onclick="location.href='listar_produto.php'">
      <input type="submit" value="Salvar">
    </td>
</tr>
</table>
</form>
</body>
</html>