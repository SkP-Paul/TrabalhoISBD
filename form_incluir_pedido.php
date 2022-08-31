<?php
header("Content-Type: text/html; charset=iso-8859-1", true);
?>
<html>

<head>
    <title>Incluir/Editar um pedido.</title>
</head>

<body>
    <form name="form1" method="POST" action="incluir_pedido.php">
        <?php
        if (isset($_GET["idPedido"])) {
            include("./config.php");
            $con = mysqli_connect($host, $login, $senha, $bd);
        ?>
            <center>
                <h3>Editar Pedido</h3>
            </center>
            <?php
            $sql = "SELECT * FROM pedido WHERE idPedido=" . $_GET['idPedido'];
            $result = mysqli_query($con, $sql);
            $vetor = mysqli_fetch_array($result, MYSQLI_ASSOC);
            mysqli_close($con);
            ?>
            <input type="hidden" name="idPedido" value="<?php echo $_GET['idPedido']; ?>">
        <?php
        } else {
        ?>
            <center>
                <h3>Cadastrar Novo Pedido</h3>
            </center>
        <?php
        }
        ?>
        <table border="0" align="center" width="35%">
            <tr>
                <td width="20%">Observacao:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="observacao" value="<?php echo @$vetor['observacao']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Data emissao:</td>
                <td colspan="2" width="90%">
                    <input type="date" name="data_emissao" value="<?php echo @$vetor['data_emissao']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Status:</td>
                <td colspan="2" width="90%">
                    <input type="number" name="status_pagamento" value="<?php echo @$vetor['status_pagamento']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Data Entrega:</td>
                <td colspan="2" width="90%">
                    <input type="date" name="data_entrega" value="<?php echo @$vetor['data_entrega']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Filial:</td>
                <td colspan="2" width="90%">
                    <input type="number" name="idFilial" value="<?php echo @$vetor['idFilial']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Entregador:</td>
                <td colspan="2" width="90%">
                    <input type="number" name="idEntregador" value="<?php echo @$vetor['idEntregador']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Comprador:</td>
                <td colspan="2" width="90%">
                    <input type="number" name="idComprador" value="<?php echo @$vetor['idComprador']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">CEP:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="cep" value="<?php echo @$vetor['cep']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Bairro:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="bairro" value="<?php echo @$vetor['bairro']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Logradouro:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="logradouro" value="<?php echo @$vetor['logradouro']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Numero:</td>
                <td colspan="2" width="90%">
                    <input type="number" name="numero" value="<?php echo @$vetor['numero']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <input type="button" value="Cancelar" onclick="location.href='listar_produto.php'">
                    <input type="submit" value="Salvar">
                </td>
            </tr>
        </table>
    </form>
    <?php
    if (isset($_GET["idPedido"])) {
    ?>
    <center>
        <h4>Produtos</h4>
    </center>
    <table border="0" align="center" width="60%">
        <?php
        include("./config.php");
        $con = mysqli_connect($host, $login, $senha, $bd);
        $sql = "SELECT produto.*, contem.preco_venda, contem.quantidade_produto FROM contem INNER JOIN produto on contem.idProduto = produto.idProduto where idPedido = " . $_GET["idPedido"]  . "ORDER BY descricao";
        $tabela = mysqli_query($con, $sql);
        if (mysqli_num_rows($tabela) == 0) {
        ?>
            <tr>
                <td align="center">Nao ha nenhum produto cadastrado.</td>
            </tr>
            <tr>
                <td align="center"><input type="submit" value="Incluir Produto"></td>
            </tr>
        <?php
        } else {
        ?>
            <tr>
                <td colspan="3" align="center"><input type="submit" value="Incluir Novo Produto"></td>
            </tr>
            <tr bgcolor="grey">
                <td width="30%">Descricao</td>
                <td width="20%">Titulo</td>
                <td width="20%">Preco Venda</td>
                <td width="10%">Quantidade</td>
                <td width="30%"></td>
            </tr>
            <?php
            while ($dados = mysqli_fetch_row($tabela)) {
            ?>
                <tr>
                    <td><?php echo $dados[1]; ?></td>
                    <td align="center"><?php echo $dados[4]; ?></td>
                    <td align="center"><?php echo $dados[6]; ?></td>
                    <td align="center"><?php echo $dados[7]; ?></td>
                    <td align="center">
                        <input type="button" value="Excluir" onclick="location.href='excluir_produto_pedido.php?idProduto=<?php echo $dados[0]; ?>&idPedido=<?php echo $_GET['idPedido']; ?>'">
                    </td>
                </tr>
            <?php
            }
            ?>
            <tr bgcolor="grey">
                <td colspan="5" height="5"></td>
            </tr>
            <?php
            mysqli_close($con);
            ?>
        <?php
        }
        ?>
    </table>
    <?php
    }
    ?>
</body>

</html>