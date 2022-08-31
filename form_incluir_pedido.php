<?php
header("Content-Type: text/html; charset=iso-8859-1",true);
?>
<html>
<head><title>Incluir/Editar um pedido.</title></head>
<body>
<form name="form1" method="POST" action="incluir_pedido.php">
<?php
if(isset($_GET["idPedido"])){	
  include("./config.php");
  $con = mysqli_connect($host, $login, $senha, $bd);
?>
  <center><h3>Editar Pedido</h3></center>
<?php
  $sql = "SELECT * FROM pedido WHERE idPedido=".$_GET['idPedido'];
  $result = mysqli_query($con, $sql);
  $vetor = mysqli_fetch_array($result, MYSQLI_ASSOC);
  mysqli_close($con);
?>
  <input type="hidden" name="idPedido" value="<?php echo $_GET['idPedido']; ?>">
<?php
}else{
?>
  <center><h3>Cadastrar Novo Pedido</h3></center>
<?php
}
?>
<table border="0" align="center" width="35%">
<tr><td width="20%">Observacao:</td>
    <td colspan="2" width="90%">
	  <input type="text" name="observacao" value="<?php echo @$vetor['observacao']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Data emissao:</td>
    <td colspan="2" width="90%">
	  <input type="date" name="data_emissao" value="<?php echo @$vetor['data_emissao']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Status:</td>
    <td colspan="2" width="90%">
	  <input type="number" name="status_pagamento" value="<?php echo @$vetor['status_pagamento']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Data Entrega:</td>
    <td colspan="2" width="90%">
	  <input type="date" name="data_entrega" value="<?php echo @$vetor['data_entrega']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Filial:</td>
    <td colspan="2" width="90%">
	  <input type="number" name="idFilial" value="<?php echo @$vetor['idFilial']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Entregador:</td>
    <td colspan="2" width="90%">
	  <input type="number" name="idEntregador" value="<?php echo @$vetor['idEntregador']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Comprador:</td>
    <td colspan="2" width="90%">
	  <input type="number" name="idComprador" value="<?php echo @$vetor['idComprador']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">CEP:</td>
    <td colspan="2" width="90%">
	  <input type="text" name="cep" value="<?php echo @$vetor['cep']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Bairro:</td>
    <td colspan="2" width="90%">
	  <input type="text" name="bairro" value="<?php echo @$vetor['bairro']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Logradouro:</td>
    <td colspan="2" width="90%">
	  <input type="text" name="logradouro" value="<?php echo @$vetor['logradouro']; ?>" maxlength="50" size="31">
	</td>
</tr>
<tr><td width="20%">Numero:</td>
    <td colspan="2" width="90%">
	  <input type="number" name="numero" value="<?php echo @$vetor['numero']; ?>" maxlength="50" size="31">
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