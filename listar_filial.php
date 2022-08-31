<?php
header("Content-Type: text/html; charset=iso-8859-1", true);
?>
<html>

<head>
    <title>Filial.</title>
</head>

<body>
    <center>
        <h3>Filial</h3>
    </center>
    <form name="form1" method="POST" action="form_incluir_filial.php">
        <input type="button" value="Voltar" onclick="location.href='index.php'">
        <table border="0" align="center" width="60%">
            <?php
            include("./config.php");
            $con = mysqli_connect($host, $login, $senha, $bd);
            $sql = "SELECT * FROM filial ORDER BY cnpj";
            $tabela = mysqli_query($con, $sql);
            if (mysqli_num_rows($tabela) == 0) {
            ?>
                <tr>
                    <td align="center">Nao ha nenhuma filial cadastrada.</td>
                </tr>
                <tr>
                    <td align="center"><input type="submit" value="incluir Filial"></td>
                </tr>
            <?php
            } else {
            ?>
                <tr>
                    <td colspan="3" align="center"><input type="submit" value="Incluir Nova Filial"></td>
                </tr>
                <tr bgcolor="grey">
                    <td width="20%">Nome</td>
                    <td width="20%">CNPJ</td>
                    <td width="30%">Endereço</td>
                    <td width="10%">Gerente</td>
                    <td width="30%"></td>
                </tr>
                <?php
                while ($dados = mysqli_fetch_row($tabela)) {
                ?>
                    <tr>
                        <td><?php echo $dados[2]; ?></td>
                        <td align="center"><?php echo $dados[1]; ?></td>
                        <td align="center"><?php echo $dados[5] . ", " . $dados[6] . " n°" . $dados[4]; ?></td>
                        <td align="center"><?php echo $dados[7]; ?></td>
                        <td align="center">
                            <input type="button" value="Excluir" onclick="location.href='excluir_filial.php?idFilial=<?php echo $dados[0]; ?>'">
                            <input type="button" value="Editar" onclick="location.href='form_incluir_filial.php?idFilial=<?php echo $dados[0]; ?>'">
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
    </form>
</body>

</html>