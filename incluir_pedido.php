<?php
  include("./config.php");
  $con = mysqli_connect($host, $login, $senha, $bd);
  if(isset($_POST["idPedido"])){
    $sql = "SELECT idPedido FROM pedido WHERE idPedido=".$_POST["idPedido"];
    $result = mysqli_query($con, $sql);
    if(mysqli_num_rows($result)!=0){
      $sql = "UPDATE pedido SET observacao='".$_POST["observacao"]."',data_emissao=".$_POST["data_emissao"].",status_pagamento=".$_POST["status_pagamento"].",data_entrega=".$_POST["data_entrega"].",idFilial=".$_POST["idFilial"].",idEntregador=".$_POST["idEntregador"].",idComprador=".$_POST["idComprador"].",cep=".$_POST["cep"].",logradouro=".$_POST["logradouro"].",bairro=".$_POST["bairro"].",numero=".$_POST["numero"]." WHERE idPedido=".$_POST["idPedido"];
    }
  }else{
    $sql = "INSERT INTO pedido VALUES (null,".$_POST["observacao"].",'".$_POST["data_emissao"]."','".$_POST["status_pagamento"]."','".$_POST["data_entrega"]."','".$_POST["idFilial"]."','".$_POST["idEntregador"]."','".$_POST["idComprador"]."','".$_POST["cep"]."','".$_POST["logradouro"]."','".$_POST["bairro"]."','".$_POST["numero"]."')";
  }
  mysqli_query($con, $sql);
  mysqli_close($con);
  header("location: ./listar_pedido.php");
?>