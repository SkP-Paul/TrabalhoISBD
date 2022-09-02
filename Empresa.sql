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
		REFERENCES	Pedido (idFilial)
        ON DELETE CASCADE,
ADD CONSTRAINT fk_con_produto FOREIGN KEY (idProduto)
		REFERENCES Produto (idProduto)
        ON DELETE CASCADE;


-- INSERcaO DAS FILIAIS

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('64045511000102', '35352971', 'Diego e Samuel Construcoes ME', 659, 'Jardim Record', 'Rua Ipaucu');

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('25408265000154', '07243270', 'Yuri e Paulo Telecomunicacoes ME', 656, 'Parque das Nacoes', 'Rua Lago Verde');

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('47581605000187', '01128080', 'Rayssa e Igor Comercio de Bebidas ME', 513, 'Bom Retiro', 'Rua Adoracao');

-- INSERcaO DOS FUNCIONaRIOS

-- FILIAL 1

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('15803722600', 'Elisa Valentina Malu Lima', 'A', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('85243930334', 'Francisca Allana Olivia Martins', 'C', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('50717292886', 'Noah Luiz Davi Ramos', 'G', 1);

INSERT INTO Pessoa (cnh, cpf, nome, tipo, idFilial)
VALUES ('32077430133', '23457700583', 'Andre Cesar Peixoto', 'E', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('89169317380', 'Severino Caleb Baptista', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('85224998298', 'Francisco Luis Bruno Caldeira', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('08351243639', 'Sebastiao Matheus dos Santos', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('99181671571', 'Isabella Fernanda Andreia Goncalves', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('19640235059', 'Yuri Hugo Emanuel Ribeiro', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('54471283588', 'Debora Luana Flavia Campos', 'O', 1);



-- FILIAL 2

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('52944166700', 'Simone Isabelly Gomes', 'A', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('49602807946', 'Hugo Yago Bernardes', 'C', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('27375474079', 'Gael Carlos Eduardo Enzo Jesus', 'G', 2);

INSERT INTO Pessoa (cnh, cpf, nome, tipo, idFilial)
VALUES ('05967202760', '76207735250', 'Lúcia Lavinia Eliane Fernandes', 'E', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('54817165421', 'Sara Tereza Brito', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('05032940712', 'Liz Andreia Nascimento', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('69801542497', 'Rodrigo Bryan Miguel Assuncao', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('77298854097', 'Eduardo Nelson Samuel Silva', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('09249973705', 'Sophia Isabel Sara Caldeira', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('85402091447', 'Vitor Joao Barros', 'O', 2);



-- FILIAL 3

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('51460156005', 'Antonella Gabriela Gabrielly Pinto', 'A', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('78433800434', 'Sara Ana Raquel da Paz', 'C', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('86202312866', 'Teresinha Mariana Isabel Castro', 'G', 3);

INSERT INTO Pessoa (cnh, cpf, nome, tipo, idFilial)
VALUES ('20422482578', '76803987477', 'Raquel Eloa Nina Moura', 'E', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('32133594590', 'Isabela Luna Drumond', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('92872179470', 'Yago Filipe Oliver Ribeiro', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('78335636095', 'Nicole Elaine da Silva', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('33895259802', 'Andreia Daiane Ferreira', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('62398228339', 'Isabel Jaqueline Aparicio', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('73850194710', 'Alexandre Cauê Bruno da Rocha', 'O', 3);



-- INSERcaO DE ENDEREcOS

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (1, 'Passeio da Algaroba', 'Dendê', '60714650', 478);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (2, 'Rua D', 'Carumbe', '78050755', 390);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (3, 'Rua Comendador Pedro Alelaf', 'Pedra Mole', '64066560', 669);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (4, 'Beco Afonso Pena', 'Centro', '69020540', 569);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (5, 'Rua Acailandia', 'Parque Guajara (Icoaraci)', '66821105', 291);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (6, 'Rua Ecoporanga', 'Zumbi', '29302010', 197);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (7, 'Rua Fiscal Pedro Leitao', 'Sao Francisco', '57602420', 838);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (8, 'Estrada Amapa', 'Praia do Amapa', '69906642', 890);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (9, 'Rua das Camelias', 'Parque das Nacoes', '59159535', 806);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (10, 'Rua dos Crisantemos', 'Vila Esmeralda', '65911844', 299);

-- INSERcaO DE TELEFONES

INSERT INTO Telefone (idPessoa, numero)
VALUES (1, '98987490245');

INSERT INTO Telefone (idPessoa, numero)
VALUES (2, '85995953976');

INSERT INTO Telefone (idPessoa, numero)
VALUES (3, '65985591330');

INSERT INTO Telefone (idPessoa, numero)
VALUES (4, '86993300763');

INSERT INTO Telefone (idPessoa, numero)
VALUES (5, '92994113160');

INSERT INTO Telefone (idPessoa, numero)
VALUES (6, '91989320474');

INSERT INTO Telefone (idPessoa, numero)
VALUES (7, '28992358672');

INSERT INTO Telefone (idPessoa, numero)
VALUES (8, '82992531977');

INSERT INTO Telefone (idPessoa, numero)
VALUES (9, '68981443365');

INSERT INTO Telefone (idPessoa, numero)
VALUES (10, '84984908292');

COMMIT;