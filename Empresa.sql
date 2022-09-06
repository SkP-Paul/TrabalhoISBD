CREATE SCHEMA Empresa;

-- DROP SCHEMA Empresa;

USE Empresa;

CREATE TABLE Pessoa (
    idPessoa		INT				NOT NULL AUTO_INCREMENT,
    cpf  			VARCHAR(11)		NOT NULL,
    nome 			VARCHAR(100) 	NOT NULL,
    tipo			CHAR(1)			NOT NULL,
    cnh				CHAR(14)		NULL,
    idFilial		INT				NOT NULL,
    CONSTRAINT pk_pessoa PRIMARY KEY (idPessoa),
	CONSTRAINT uk_cpf UNIQUE (cpf),
    CONSTRAINT uk_cnh UNIQUE (cnh),
	CONSTRAINT ck_tipo CHECK (tipo='A' OR tipo='C' OR tipo='G' OR tipo='E' OR tipo='O')
);

CREATE TABLE Endereco (
	idEndereco		INT				NOT NULL AUTO_INCREMENT,
    idPessoa		INT				NOT NULL,
    logradouro		VARCHAR(50)		NOT NULL,
    bairro			VARCHAR(30)		NOT NULL,
    cep				CHAR(8)			NOT NULL,
    numero			INT				NOT NULL,
    CONSTRAINT pk_endereco PRIMARY KEY (idEndereco)
);

CREATE TABLE Telefone (
	numero			VARCHAR(11)		NOT NULL,
    idPessoa		INT 			NOT NULL,
    CONSTRAINT pk_numero_pessoa PRIMARY KEY (numero, idPessoa)
);

CREATE TABLE Pedido (
	idPedido			INT				NOT NULL AUTO_INCREMENT,
    observacao			VARCHAR(256)	NULL,
    data_emissao		DATE			NOT NULL,
    status_pagamento	TINYINT			NOT NULL,
    logradouro_entrega	VARCHAR(50)		NOT NULL,
    cep_entrega			VARCHAR(8)		NOT NULL,
    numero_entrega		INT 			NOT NULL,
    bairro_entrega		VARCHAR(30)		NOT NULL,
    data_entrega		DATE			NOT NULL,
    idFilial			INT				NOT NULL,
    idEntregador		INT				NOT NULL,
    idComprador			INT				NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (idPedido)
);

CREATE TABLE Filial (
	idFilial			INT				NOT NULL AUTO_INCREMENT,
    cnpj				VARCHAR(14)		NOT NULL,
    cep					VARCHAR(8)		NOT NULL,
    nome				VARCHAR(100)	NOT NULL,
    numero				INT				NOT NULL,
    bairro 				VARCHAR(30)		NOT NULL,
    logradouro			VARCHAR(50)		NOT NULL,
    idGerente			INT				NULL,
    data_inicio_gestao	DATE			NULL,
    CONSTRAINT pk_filial PRIMARY KEY (idFilial),
    CONSTRAINT uk_cnpj UNIQUE (cnpj)
);

CREATE TABLE Produto (
	idProduto		INT 			NOT NULL AUTO_INCREMENT,
	descricao		VARCHAR(256)	NOT NULL,
    estoque			INT(10)			NOT NULL,
    preco			REAL			NOT NULL,
    titulo			VARCHAR(50)		NOT NULL,
    idFilial		INT				NOT NULL,
    CONSTRAINT pk_produto PRIMARY KEY (idProduto)
);

CREATE TABLE Contem (
	idPedido 			INT 	NOT NULL,
    idProduto			INT 	NOT NULL,
    preco_venda			REAL	NOT NULL,
    quantidade_produto	INT		NOT NULL,
    CONSTRAINT pk_ped_prod PRIMARY KEY (idPedido, idProduto)
);

-- Adicionando as chaves estrangeiras das tabelas utilizando o ALTER TABLE para evitar referência cruzada

ALTER TABLE Pessoa
ADD CONSTRAINT fk_pes_filial FOREIGN KEY (idFilial)
        REFERENCES Filial (idFilial);

ALTER TABLE Endereco
ADD CONSTRAINT fk_end_pessoa FOREIGN KEY (idPessoa)
        REFERENCES Pessoa (idPessoa)
        ON DELETE CASCADE;

ALTER TABLE Telefone
ADD CONSTRAINT fk_tel_pessoa FOREIGN KEY (idPessoa)
        REFERENCES Pessoa (idPessoa)
        ON DELETE CASCADE;

ALTER TABLE Pedido
ADD CONSTRAINT fk_ped_filial FOREIGN KEY (idFilial)
		REFERENCES	Filial (idFilial),
ADD CONSTRAINT fk_ped_entregador FOREIGN KEY (idEntregador)
        REFERENCES Pessoa (idPessoa),
ADD CONSTRAINT fk_ped_comprador FOREIGN KEY (idComprador)
        REFERENCES Pessoa (idPessoa);

ALTER TABLE Filial
ADD CONSTRAINT fk_fil_gerente FOREIGN KEY (idGerente)
        REFERENCES Pessoa (idPessoa);
	
ALTER TABLE Produto
ADD CONSTRAINT fk_prod_filial FOREIGN KEY (idFilial)
		REFERENCES	Filial (idFilial);

ALTER TABLE Contem
ADD CONSTRAINT fk_con_pedido FOREIGN KEY (idPedido)
		REFERENCES	Pedido (idPedido)
        ON DELETE CASCADE,
ADD CONSTRAINT fk_con_produto FOREIGN KEY (idProduto)
		REFERENCES Produto (idProduto)
        ON DELETE CASCADE;


-- INSERÇÃO DAS FILIAIS

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('64045511000102', '35352971', 'Diego e Samuel Construcoes ME', 659, 'Jardim Record', 'Rua Ipaucu');

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('25408265000154', '07243270', 'Yuri e Paulo Telecomunicacoes ME', 656, 'Parque das Nacoes', 'Rua Lago Verde');

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('47581605000187', '01128080', 'Rayssa e Igor Comercio de Bebidas ME', 513, 'Bom Retiro', 'Rua Adoracao');

-- ###### INSERÇÃO DOS FUNCIONÁRIOS ###### --

-- ###### FILIAL 1 ###### --

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('59145566518', 'Thomas Ian Monteiro', 'A', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (1, 'Rua Governador Raimundo Artur de Vasconcelos', 'Marques de Paranagua', '64002508', 450);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (1, '86997285749');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('51468368419', 'Andreia Mariah Lopes', 'C', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (2, 'Rua Marcelo Pasquali Carlo Pirfo', 'Conjunto Manoel Mendes', '38082162', 957);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (2, '34998239025');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('20763488593', 'Jennifer Milena Drumond', 'G', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (3, 'Rua Mario Matiotte', 'Industrial', '49065415', 600);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (3, '79997366515');

-- ATUALIZANDO O GERENTE DA FILIAL 1

UPDATE Filial
SET idGerente = 3, data_inicio_gestao = '2019-01-01'
WHERE idFilial = 1;

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, cnh, nome, tipo, idFilial)
VALUES ('62111882267', '01294177148', 'Mariana Amanda Juliana Cavalcanti', 'E', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (4, 'Rua 15 A', 'Taquarussu', '77080066', 955);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (4, '63988536630');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('51072135108', 'Emanuelly Sophie Mendes', 'O', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (5, 'Rua Professora Vaneida Soares Bezerra', 'Cidade Universitaria', '63048120', 430);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (5, '88981490510');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('68903979672', 'Sebastiao Felipe dos Santos', 'O', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (6, 'Rua Cecilia Meireles', 'Tiradentes', '69103224', 423);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (6, '92999399937');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('95447891892', 'Catarina Alicia Barbara Viana', 'O', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (7, 'Rua Nova Corrente', 'Arruda', '52120311', 562);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (7, '81996166447');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('68125510311', 'Maya Isabel Tatiane da Rosa', 'O', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (8, 'Avenida das Acacias', 'Residencial Parque das Acacias', '77425650', 789);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (8, '63981710164');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('04396033230', 'Marcos Caleb Rodrigues', 'O', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (9, 'Rua Maria Povoa Braga', 'Vivendas do Parque', '79044070', 909);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (9, '67993663927');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('38212366391', 'Raimunda Elisa Lorena da Cunha', 'O', 1);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (10, 'Travessa Santa Lucia', 'Lamarao', '49088300', 548);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (10, '79987594285');

----------------------------------------------------------------------------------------------------

-- ###### FILIAL 2 ###### --

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('09562249034', 'Nair Josefa Martins', 'A', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (11, 'Travessa Mariz e Barros', 'Pedreira', '66080008', 783);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (11, '91998835462');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('52244826317', 'Regina Alessandra Baptista', 'C', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (12, 'Rua Veu de Noiva', 'Parque Sonhos Dourados', '77818814', 291);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (12, '63996648608');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('68947505803', 'Manoel Breno Ruan da Mota', 'G', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (13, 'Rua Duque de Caxias', 'Vilinha', '65915512', 803);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (13, '98989540534');

-- ATUALIZANDO O GERENTE DA FILIAL 2

UPDATE Filial
SET idGerente = 13, data_inicio_gestao = '2020-01-01'
WHERE idFilial = 2;

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, cnh, nome, tipo, idFilial)
VALUES ('59529529333', '18871158358', 'Emanuel Cesar Jose Santos', 'E', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (14, 'Quadra QNN 27 Modulo A', 'Ceilandia Norte Ceilandia', '72225271', 563);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (14, '61981508532');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('52984760743', 'Mario Henrique Arthur Porto', 'O', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (15, 'Rua Sao Sebastiao', 'Gilberto Mestrinho', '69086711', 177);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (15, '92998810721');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('46806387616', 'Eliane Natalia Moura', 'O', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (16, 'Rua F', 'Atalaia', '49038029', 337);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (16, '79982765342');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('58965060150', 'Elza Sophie Teresinha Farias', 'O', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (17, 'Quadra QR 503 Conjunto 13', 'Samambaia Sul Samambaia', '72311615', 398);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (17, '61988153819');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('08615545316', 'Erick Kaue Emanuel Ferreira', 'O', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (18, 'Rua Cataratas', 'Parque Poti', '64081380', 171);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (18, '86988735315');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('94573811907', 'Luzia Tania da Costa', 'O', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (19, 'Rua Fernando Correa da Costa', 'Setor Rodoviaria', '78750799', 851);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (19, '66987817280');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('06126894413', 'Thiago Kaique Fogaca', 'O', 2);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (20, 'Rua Marcelina Piccoli Zanrosso', 'Cruzeiro', '95074309', 503);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (20, '54999774554');

----------------------------------------------------------------------------------------------------


-- ###### FILIAL 3 ###### --

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('73043687809', 'Tatiane Valentina Barbosa', 'A', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (21, 'Alameda Cinquenta e Nove', 'Tapana Icoaraci', '66831059', 566);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (21, '91998036905');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('13199238289', 'Kaue Thomas Aragao', 'C', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (22, 'Alameda Barbados', 'Ponta Negra', '69037091', 945);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (22, '92982444775');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('27737832122', 'Luana Raimunda Isis Porto', 'G', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (23, 'Rua Y Dois', 'Distrito Industrial', '58082025', 456);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (23, '83993719831');

-- ATUALIZANDO O GERENTE DA FILIAL 3

UPDATE Filial
SET idGerente = 23, data_inicio_gestao = '2022-03-12'
WHERE idFilial = 3;

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, cnh, nome, tipo, idFilial)
VALUES ('60530592347', '24855707935', 'Jorge Joaquim Diogo Carvalho', 'E', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (24, 'Rua Chico Mendes', 'Mathias Velho', '92330085', 797);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (24, '51993759129');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('45164223791', 'Adriana Marcela da Luz', 'O', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (25, 'Rua Paes Leme', 'Itangua', '29149790', 298);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (25, '27992097631');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('05402755060', 'Enrico Claudio Teixeira', 'O', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (26, 'Rua Alemanha', 'Parque Bonfim', '87507375', 886);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (26, '44994596193');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('94882624869', 'Elza Simone Gomes', 'O', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (27, 'Rua 25 de Agosto', 'Eduardo Braga I', '69103444', 442);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (27, '92999473350');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('87618577501', 'Sergio Pietro Figueiredo', 'O', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (28, 'Rua dos Crisantemos', 'Setor Sonia Regina Taquaralto', '77060688', 871);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (28, '63992778153');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('90320321606', 'Cristiane Caroline Malu Pinto', 'O', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (29, 'Travessa Rosina Matos', 'Aeroporto', '49037653', 211);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (29, '79986996088');

----------------------------------------------------------------------------------------------------

-- FUNCIONÁRIO
INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('10719031877', 'Bianca Alessandra Maite Ferreira', 'O', 3);

-- ENDEREÇO
INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (30, 'Estrada do Aeroporto', 'Sao Jose', '69552610', 615);

-- TELEFONE
INSERT INTO Telefone (idPessoa, numero)
VALUES (30, '97992874058');

----------------------------------------------------------------------------------------------------

-- ###### INSERÇÃO DE PRODUTOS ###### --

-- ###### FILAIL 1 ###### --

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Flamengo Masculina 2020/2021', 10, 199.90, 'Camisa Flamengo Masculina 2020/2021', 1);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Corinthians Masculina 2020/2021', 10, 199.90, 'Camisa Corinthians Masculina 2020/2021', 1);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Palmeiras Masculina 2020/2021', 10, 199.90, 'Camisa Palmeiras Masculina 2020/2021', 1);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Santos Masculina 2020/2021', 10, 199.90, 'Camisa Santos Masculina 2020/2021', 1);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Bermuda Nike Masculina', 10, 99.90, 'Bermuda Nike Masculina', 1);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Preta Manga Curta', 10, 49.90, 'Camisa Preta Manga Curta', 1);


-- ###### FILAIL 2 ###### --

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Polo Masculina', 10, 99.90, 'Camisa Polo Masculina', 2);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Polo Feminina', 10, 99.90, 'Camisa Polo Feminina', 2);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Polo Infantil', 10, 99.90, 'Camisa Polo Infantil', 2);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Croped Masculina', 10, 99.90, 'Croped Masculina', 2);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Calça Jeans Masculina', 10, 99.90, 'Calça Jeans Masculina', 2);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Calça Jeans Feminina', 10, 99.90, 'Calça Jeans Feminina', 2);

-- ###### FILAIL 3 ###### --

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Nike Masculina', 10, 99.90, 'Camisa Nike Masculina', 3);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Nike Feminina', 10, 99.90, 'Camisa Nike Feminina', 3);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Nike Infantil', 10, 99.90, 'Camisa Nike Infantil', 3);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Adidas Masculina', 10, 99.90, 'Camisa Adidas Masculina', 3);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Adidas Feminina', 10, 99.90, 'Camisa Adidas Feminina', 3);

INSERT INTO Produto (descricao, estoque, preco, titulo, idFilial)
VALUES ('Camisa Adidas Infantil', 10, 99.90, 'Camisa Adidas Infantil', 3);


-- ###### INSERÇÃO DE PEDIDOS ###### --

-- ######## PEDIDO 1 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-03-12', 0, 'Rua dos Crisantemos', '77060688', 871, 'Setor Sonia Regina Taquaralto', '2021-03-12', 3, 4, 2);

-- ITEMS DO PEDIDO 1
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (1, 1, 233.00, 1);


-- ######## PEDIDO 2 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-06-12', 0, 'Avenida Joao Aureliano', '77060688', 855, 'Ceilandia', '2021-03-12', 2, 14, 12);

-- ITEMS DO PEDIDO 2
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (2, 2, 614.00, 3);


-- ######## PEDIDO 3 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-06-12', 0, 'Avenida Joao Aureliano', '77060688', 855, 'Ceilandia', '2021-03-12', 3, 24, 22);

-- ITEMS DO PEDIDO 3
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (3, 3, 500.00, 2);


-- ######## PEDIDO 4 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-06-12', 0, 'Avenida Joao Aureliano', '77060688', 855, 'Ceilandia', '2021-03-12', 3, 24, 22);

-- ITEMS DO PEDIDO 4
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (4, 13, 200.00, 2);


-- ######## PEDIDO 5 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-06-12', 0, 'Avenida Joao Aureliano', '77060688', 855, 'Ceilandia', '2021-03-12', 3, 24, 22);

-- ITEMS DO PEDIDO 5
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (5, 13, 190.00, 2);


-- ######## PEDIDO 6 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-06-12', 0, 'Avenida Joao Aureliano', '77060688', 855, 'Ceilandia', '2021-03-12', 3, 24, 22);

-- ITEMS DO PEDIDO 6
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (6, 13, 10.50, 2);


-- ######## PEDIDO 7 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-03-12', 0, 'Rua Marcelo Pasquali Carlo Pirfo', '38082162', 957, 'Conjunto Manoel Mendes', '2021-03-12', 3, 4, 2);

-- ITEMS DO PEDIDO 7 --
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (7, 1, 274.00, 1);

-- ######## PEDIDO 8 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-03-12', 0, 'Rua Mario Matiotte', '49065415', 600, 'Industrial', '2021-03-12', 3, 4, 3);

-- ITEMS DO PEDIDO 8 --
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (8, 1, 233.00, 1);

-- ######## PEDIDO 9 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-03-12', 0, 'Taquarussu', '77080066', 955, 'Rua 15 A', '2021-03-12', 3, 4, 4);

-- ITEMS DO PEDIDO 9 --
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (9, 4, 254.00, 1);

-- ######## PEDIDO 10 ######## --
INSERT INTO Pedido (observacao, data_emissao, status_pagamento, logradouro_entrega, cep_entrega, numero_entrega, bairro_entrega, data_entrega, idFilial, idEntregador, idComprador)
VALUES ('Pedido de teste', '2021-03-12', 0, 'Rua Professora Vaneida Soares Bezerra', '63048120', 430, 'Cidade Universitaria', '2021-03-12', 3, 4, 5);

-- ITEMS DO PEDIDO 10 --
INSERT INTO Contem (idPedido,idProduto, preco_venda, quantidade_produto)
VALUES (10, 4, 254.00, 4);

-- ###### PROCEDURES ###### --
-- CALCULA O LUCRO DA FILIAL INFORMADA POR PARAMETRO
DELIMITER //
CREATE PROCEDURE calcularLucroPorFilial(IN idFilial INT, OUT lucro FLOAT)
BEGIN
    SELECT ROUND(SUM(preco_venda/quantidade_produto - preco), 2) AS lucro 
    FROM Contem NATURAL JOIN Produto
    WHERE produto.idFilial = idFilial;
END //
DELIMITER ;

SELECT * FROM Contem NATURAL JOIN Produto;

-- CHAMA O PROCEDIMENTO
CALL calcularLucroPorFilial(1, @lucro);

SELECT * FROM Contem NATURAL JOIN Produto;

-- AJUSTA O PREÇO DO PRODUTO COM A MÉDIA DO PREÇO DE VENDA COM UMA MARGEM DE LUCRO DE 5% OU DE PREJUIZO DE 5%

DELIMITER // 
CREATE PROCEDURE AjustarPrecoProduto()
BEGIN
    DECLARE done INT DEFAULT FALSE;

    DECLARE vIdProduto INT;
    DECLARE vMediaPreco decimal(6,1);
    DECLARE vPrecoAtual decimal(6,1);

    DECLARE mediaDePreco CURSOR FOR 	
        SELECT idProduto, AVG(preco_venda/quantidade_produto) AS media, preco
        FROM Contem NATURAL JOIN Produto
        GROUP BY idProduto;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN mediaDePreco;

    read_loop: LOOP
        FETCH mediaDePreco INTO vIdProduto, vMediaPreco, vPrecoAtual;
        
        IF done THEN
        LEAVE read_loop;
        END IF;
        
        IF vMediaPreco >= vPrecoAtual * 1.005 THEN
            UPDATE Produto SET preco = preco * 1.005 where idProduto = vIdProduto;
        ELSEIF vMediaPreco < vPrecoAtual * 0.9 THEN
            UPDATE Produto set preco = preco * 0.95 where idProduto = vIdProduto;
        END IF;
    END LOOP;

    CLOSE mediaDePreco;

END // 
DELIMITER ; 

SELECT * FROM Contem NATURAL JOIN Produto GROUP BY idProduto;

-- CHAMA O PROCEDIMENTO
CALL AjustarPrecoProduto();

SELECT * FROM Contem NATURAL JOIN Produto GROUP BY idProduto;

-- RETORNA O NOME DO PRODUTO MAIS VENDIDO POR FILIAL
DELIMITER //
CREATE PROCEDURE produtoMaisVendidoPorFilial(IN idFilial INT, OUT nomeProduto VARCHAR(100))
BEGIN
    SELECT titulo
    FROM Contem NATURAL JOIN Produto
    WHERE produto.idFilial = idFilial
    GROUP BY titulo
    ORDER BY SUM(quantidade_produto) DESC
    LIMIT 1;
END //
DELIMITER ;

-- CHAMA O PROCEDIMENTO
CALL produtoMaisVendidoPorFilial(3, @nomeProduto);

-- ####### TRIGGERS ####### --

-- ATUALIZAR O ESTOQUE DE UM PRODUTO AO EXCLUIR UM PEDIDO
-- DROP TRIGGER atualizarEstoque;

DELIMITER //
CREATE TRIGGER atualizarEstoque
AFTER DELETE ON Contem
FOR EACH ROW
BEGIN
	UPDATE Produto
	SET estoque = estoque + OLD.quantidade_produto
	WHERE Produto.idProduto = OLD.idProduto;
END //
DELIMITER ;

-- VERIFICAR SE A QUANTIDADE DE TELEFONES DE UMA PESSOA EXCEDEU A 3

-- DROP TRIGGER before_insert_Telefone;

DELIMITER //
CREATE TRIGGER before_insert_Telefone
BEFORE INSERT ON Telefone FOR EACH ROW
BEGIN
    DECLARE vNumTel INT;

    SELECT COUNT(idPessoa) INTO vNumTel
    FROM Telefone
    WHERE idPessoa = new.idPessoa;	
	
    IF (vNumTel = 3) THEN
        SIGNAL SQLSTATE '45000' SET message_text = 'Funcionário excede o número máximo de telefones.';
    END IF;
END;
//
DELIMITER ;

-- VERIFICA SE O ENTREGADOR DO PEDIDO É DO TIPO 'E' AO ATUALIZAR

-- DROP TRIGGER verificarEntregador;

DELIMITER //
CREATE TRIGGER verificarEntregador
BEFORE UPDATE ON Pedido FOR EACH ROW
BEGIN
    DECLARE vTipoEntregador VARCHAR(1);

    SELECT tipo INTO vTipoEntregador
    FROM Pessoa
    WHERE idPessoa = new.idEntregador;	
    
    IF (vTipoEntregador != 'E') THEN
        SIGNAL SQLSTATE '45000' SET message_text = 'A pessoa designada como entregador não é do tipo Entregador.';
    END IF;
END;
//
DELIMITER ;


-- ###### EXEMPLOS DE GATILHOS DOS TRIGGERS ###### --
-- TRIGER PARA ATUALIZAR O ESTOQUE DE UM PRODUTO AO EXCLUIR UM PEDIDO
SELECT estoque FROM Produto
WHERE idProduto = 1;

DELETE FROM Contem
WHERE idProduto = 1 AND idPedido = 1;

SELECT estoque FROM Produto
WHERE idProduto = 1;

-- TRIGER PARA VERIFICAR SE A QUANTIDADE DE TELEFONES DE UMA PESSOA EXCEDEU A 3
INSERT INTO Telefone (idPessoa, numero)
VALUES (29, '79887121960');

INSERT INTO Telefone (idPessoa, numero)
VALUES (29, '79924680314');

INSERT INTO Telefone (idPessoa, numero)
VALUES (29, '79983170934');

-- TRIGER PARA VERIFICA SE O ENTREGADOR DO PEDIDO É DO TIPO 'E' AO ATUALIZAR
UPDATE Pedido
SET idEntregador = 1
WHERE idPedido = 1;

-- ####### CRIAÇÃO DE USUARIOS #######
CREATE USER 'gerente'@'localhost' IDENTIFIED BY '0000';
CREATE USER 'funcionario'@'localhost' IDENTIFIED BY '1111';

GRANT ALL ON Empresa TO 'gerente'@'localhost';
GRANT INSERT, DROP, SELECT ON Empresa.Pedido TO 'funcionario'@'localhost';

REVOKE ALL ON Empresa FROM 'gerente'@'localhost';
REVOKE ALL ON Empresa.Pedido FROM 'funcionario'@'localhost';

COMMIT;