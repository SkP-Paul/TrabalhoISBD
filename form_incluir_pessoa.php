<?php
header("Content-Type: text/html; charset=iso-8859-1", true);
?>
<html>

<head>
    <title>Incluir/Editar uma pessoa.</title>
</head>

<body>
    <form name="form1" method="POST" action="incluir_pessoa.php">
        <?php
        if (isset($_GET["idPessoa"])) {
            include("./config.php");
            $con = mysqli_connect($host, $login, $senha, $bd);
        ?>
            <center>
                <h3>Editar Pessoa</h3>
            </center>
            <?php
            $sql = "SELECT * FROM pessoa WHERE idPessoa=" . $_GET['idPessoa'];
            $result = mysqli_query($con, $sql);
            $vetor = mysqli_fetch_array($result, MYSQLI_ASSOC);
            mysqli_close($con);
            ?>
            <input type="hidden" name="idPessoa" value="<?php echo $_GET['idPessoa']; ?>">
        <?php
        } else {
        ?>
            <center>
                <h3>Cadastrar Nova Pessoa</h3>
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
                <td width="20%">CPF:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="cpf" value="<?php echo @$vetor['cpf']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Tipo:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="tipo" value="<?php echo @$vetor['tipo']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">CNH:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="cnh" value="<?php echo @$vetor['cnh']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td width="20%">Filial:</td>
                <td colspan="2" width="90%">
                    <input type="text" name="idFilial" value="<?php echo @$vetor['idFilial']; ?>" maxlength="50" size="31">
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <input type="button" value="Cancelar" onclick="location.href='listar_pessoa.php'">
                    <input type="submit" value="Salvar">
                </td>
            </tr>
        </table>
    </form>
</body>

</html>