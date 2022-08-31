<?php
header("Content-Type: text/html; charset=iso-8859-1",true);
?>
<html>
<head><title>Pedido.</title></head>
<body>
<center><h3>Pedido</h3></center>
<form name="form1" method="POST" action="form_incluir_pedido.php">
<input type="button" value="Voltar" onclick="location.href='index.php'">
<table border="0" align="center" width="60%">
<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);
$sql = "SELECT * FROM pedido ORDER BY data_emissao";
$tabela = mysqli_query($con, $sql);
if(mysqli_num_rows($tabela)==0){
?>
  <tr><td align="center">Nao ha nenhum pedido cadastrado.</td></tr>
  <tr><td align="center"><input type="submit" value="Incluir Pedido"></td></tr>
<?php
}else{
?>
<tr><td colspan="3" align="center"><input type="submit" value="Incluir Novo Pedido"></td></tr>
	<tr bgcolor="grey"><td width="30%">Data Emissao</td><td width="20%">Observacao</td><td width="10%">Status</td><td width="20%">Endereco</td><td width="30%"></td></tr>
<?php
  while($dados = mysqli_fetch_row($tabela)){
?>
  <tr><td><?php echo $dados[2]; ?></td>
      <td align="center"><?php echo $dados[1]; ?></td>
      <td align="center"><?php echo $dados[3]; ?></td>
      <td align="center"><?php echo $dados[10] . ", " . $dados[9] . " n°" . $dados[11]; ?></td>
	  <td align="center">
	    <input type="button" value="Excluir" onclick="location.href='excluir_pedido.php?idPedido=<?php echo $dados[0]; ?>'">
	    <input type="button" value="Editar" onclick="location.href='form_incluir_pedido.php?idPedido=<?php echo $dados[0]; ?>'">
	  </td>
  </tr>
<?php
  }
?>
<tr bgcolor="grey"><td colspan="5" height="5"></td></tr>
<?php
mysqli_close($con);
?>
<?php
}
?>
</table>
</form>
</body>
</html>
