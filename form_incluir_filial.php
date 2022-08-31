<?php
header("Content-Type: text/html; charset=iso-8859-1", true);
?>
<html>

<head>
    <title>Incluir/Editar uma filial.</title>
</head>

<body>
    <form name="form1" method="POST" action="incluir_filial.php">
        <?php
        if (isset($_GET["idFilial"])) {
            include("./config.php");
            $con = mysqli_connect($host, $login, $senha, $bd);
        ?>
            <center>
                <h3>Editar Filial</h3>
            </center>
            <?php
            $sql = "SELECT * FROM filial WHERE idFilial=" . $_GET['idFilial'];
            $result = mysqli_query($con, $sql);
            $vetor = mysqli_fetch_array($result, MYSQLI_ASSOC);
            mysqli_close($con);
            ?>
            <input type="hidden" name="idFilial" value="<?php echo $_GET['idFilial']; ?>">
        <?php
        } else {
        ?>
            <center>
                <h3>Cadastrar Nova Filial</h3>
            </center>
        <?php
        }
        ?>
        <table border="0" align="center" width="35%">
            <tr>
                <td width="20%">Nome:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="nome" value="<?php echo @$vetor['nome']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">CNPJ:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="cnpj" value="<?php echo @$vetor['cnpj']; ?>" maxlength="50" size="31">
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
                <td width="20%">Gerente:</td>
                <td colspan="2" width="90%">
                    <input type="number" name="idGerente" value="<?php echo @$vetor['idGerente']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Data inicio gestao:</td>
                <td colspan="2" width="90%">
                    <input type="date" name="data_inicio_gestao" value="<?php echo @$vetor['data_inicio_gestao']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <input type="button" value="Cancelar" onclick="location.href='listar_filial.php'">
                    <input type="submit" value="Salvar">
                </td>
            </tr>
        </table>
    </form>
</body>

</html>