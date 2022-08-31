<?php
header("Content-Type: text/html; charset=iso-8859-1",true);
?>
<html>
<head><title>Pessoa.</title></head>
<body>
<center><h3>Pessoa</h3></center>
<form name="form1" method="POST" action="form_incluir_pessoa.php">
<input type="button" value="Voltar" onclick="location.href='index.php'">
<table border="0" align="center" width="60%">
<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);
$sql = "SELECT * FROM pessoa ORDER BY nome";
$tabela = mysqli_query($con, $sql);
if(mysqli_num_rows($tabela)==0){
?>
  <tr><td align="center">Nao ha nenhuma pessoa cadastrada.</td></tr>
  <tr><td align="center"><input type="submit" value="incluir Pessoa"></td></tr>
<?php
}else{
?>
<tr><td colspan="3" align="center"><input type="submit" value="Incluir Nova Pessoa"></td></tr>
	<tr bgcolor="grey"><td width="30%">Nome</td><td width="20%">CPF</td><td width="10%">Tipo</td><td width="20%">Filial</td><td width="30%"></td></tr>
<?php
  while($dados = mysqli_fetch_row($tabela)){
?>
  <tr><td><?php echo $dados[2]; ?></td>
      <td align="center"><?php echo $dados[1]; ?></td>
      <td align="center"><?php echo $dados[3]; ?></td>
      <td align="center"><?php echo $dados[5]; ?></td>
	  <td align="center">
	    <input type="button" value="Excluir" onclick="location.href='excluir_pessoa.php?idPessoa=<?php echo $dados[0]; ?>'">
	    <input type="button" value="Editar" onclick="location.href='form_incluir_pessoa.php?idPessoa=<?php echo $dados[0]; ?>'">
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
