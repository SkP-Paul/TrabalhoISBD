<?php
  include("./config.php");
  $con = mysqli_connect($host, $login, $senha, $bd);
  if(isset($_POST["idPessoa"])){
    $sql = "SELECT idPessoa FROM pessoa WHERE idPessoa=".$_POST["idPessoa"];
    $result = mysqli_query($con, $sql);
    if(mysqli_num_rows($result)!=0){
      $sql = "UPDATE pessoa SET cpf='".$_POST["cpf"]."',nome=".$_POST["nome"].",tipo=".$_POST["tipo"].",cnh=".$_POST["cnh"].",idFilial=".$_POST["idFilial"]." WHERE idPessoa=".$_POST["idPessoa"];
    }
  }else{
    $sql = "INSERT INTO pessoa VALUES (null,".$_POST["cpf"].",'".$_POST["nome"]."','".$_POST["tipo"]."','".$_POST["cnh"]."','".$_POST["idFilial"]."')";
  }
  mysqli_query($con, $sql);
  mysqli_close($con);
  header("location: ./listar_pessoa.php");
