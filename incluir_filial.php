<?php
  include("./config.php");
  $con = mysqli_connect($host, $login, $senha, $bd);
  if(isset($_POST["idFilial"])){
    $sql = "SELECT idFilial FROM filial WHERE idFilial=".$_POST["idFilial"];
    $result = mysqli_query($con, $sql);
    if(mysqli_num_rows($result)!=0){
      $sql = "UPDATE filial SET cnpj='".$_POST["cnpj"]."',nome=".$_POST["nome"].",cep=".$_POST["cep"].",bairro=".$_POST["bairro"].",logradouro=".$_POST["logradouro"].",numero=".$_POST["numero"].",idGerente=".$_POST["idGerente"].",data_inicio_gestao=".$_POST["data_inicio_gestao"]." WHERE idFilial=".$_POST["idFilial"];
    }
  }else{
    $sql = "INSERT INTO filial VALUES (null,".$_POST["cnpj"].",'".$_POST["nome"]."','".$_POST["cep"]."','".$_POST["bairro"]."','".$_POST["logradouro"]."','".$_POST["numero"]."','".$_POST["idGerente"]."','".$_POST["data_inicio_gestao"]."')";
  }
  mysqli_query($con, $sql);
  mysqli_close($con);
  header("location: ./listar_filial.php");
?>