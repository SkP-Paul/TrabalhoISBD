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


-- INSERÇÃO DAS FILIAIS

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('64.045.511/0001-02', '35352-971', 'Diego e Samuel Construções ME', 659, 'Jardim Record', 'Rua Ipauçu');

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('25.408.265/0001-54', '07243-270', 'Yuri e Paulo Telecomunicações ME', 656, 'Parque das Nações', 'Rua Lago Verde');

INSERT INTO Filial (cnpj, cep, nome, numero, bairro, logradouro)
VALUES ('47.581.605/0001-87', '01128-080', 'Rayssa e Igor Comercio de Bebidas ME', 513, 'Bom Retiro', 'Rua Adoração');

-- INSERÇÃO DOS FUNCIONÁRIOS

-- FILIAL 1

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('158.037.226-00', 'Elisa Valentina Malu Lima', 'A', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('852.439.303-34', 'Francisca Allana Olivia Martins', 'C', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('507.172.928-86', 'Noah Luiz Davi Ramos', 'G', 1);

INSERT INTO Pessoa (cnh, cpf, nome, tipo, idFilial)
VALUES ('32077430133', '234.577.005-83', 'André César Peixoto', 'E', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('891.693.173-80', 'Severino Caleb Baptista', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('852.249.982-98', 'Francisco Luís Bruno Caldeira', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('083.512.436-39', 'Sebastião Matheus dos Santos', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('991.816.715-71', 'Isabella Fernanda Andreia Gonçalves', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('196.402.350-59', 'Yuri Hugo Emanuel Ribeiro', 'O', 1);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('544.712.835-88', 'Débora Luana Flávia Campos', 'O', 1);



-- FILIAL 2

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('529.441.667-00', 'Simone Isabelly Gomes', 'A', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('496.028.079-46', 'Hugo Yago Bernardes', 'C', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('273.754.740-79', 'Gael Carlos Eduardo Enzo Jesus', 'G', 2);

INSERT INTO Pessoa (cnh, cpf, nome, tipo, idFilial)
VALUES ('05967202760', '762.077.352-50', 'Lúcia Lavínia Eliane Fernandes', 'E', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('548.171.654-21', 'Sara Tereza Brito', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('05032940712', 'Liz Andreia Nascimento', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('69801542497', 'Rodrigo Bryan Miguel Assunção', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('77298854097', 'Eduardo Nelson Samuel Silva', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('09249973705', 'Sophia Isabel Sara Caldeira', 'O', 2);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('85402091447', 'Vitor João Barros', 'O', 2);



-- FILIAL 3

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('51460156005', 'Antonella Gabriela Gabrielly Pinto', 'A', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('78433800434', 'Sara Ana Raquel da Paz', 'C', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('86202312866', 'Teresinha Mariana Isabel Castro', 'G', 3);

INSERT INTO Pessoa (cnh, cpf, nome, tipo, idFilial)
VALUES ('20422482578', '76803987477', 'Raquel Eloá Nina Moura', 'E', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('32133594590', 'Isabela Luna Drumond', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('92872179470', 'Yago Filipe Oliver Ribeiro', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('78335636095', 'Nicole Elaine da Silva', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('33895259802', 'Andreia Daiane Ferreira', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('62398228339', 'Isabel Jaqueline Aparício', 'O', 3);

INSERT INTO Pessoa (cpf, nome, tipo, idFilial)
VALUES ('73850194710', 'Alexandre Cauê Bruno da Rocha', 'O', 3);



-- INSERÇÃO DE ENDEREÇOS

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (1, 'Passeio da Algaroba', 'Dendê', '60714-650', 478);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (2, 'Rua D', 'Carumbé', '78050-755', 390);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (3, 'Rua Comendador Pedro Alelaf', 'Pedra Mole', '64066-560', 669);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (4, 'Beco Afonso Pena', 'Centro', '69020-540', 569);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (5, 'Rua Açailândia', 'Parque Guajará (Icoaraci)', '66821-105', 291);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (6, 'Rua Ecoporanga', 'Zumbi', '29302-010', 197);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (7, 'Rua Fiscal Pedro Leitão', 'São Francisco', '57602-420', 838);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (8, 'Estrada Amapá', 'Praia do Amapá', '69906-642', 890);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (9, 'Rua das Camélias', 'Parque das Nações', '59159-535', 806);

INSERT INTO Endereco (idPessoa, logradouro, bairro, cep, numero)
VALUES (10, 'Rua dos Crisântemos', 'Vila Esmeralda', '65911-844', 299);

-- INSERÇÃO DE TELEFONES

INSERT INTO Telefone (idPessoa, celular)
VALUES (1, '(98) 98749-0245');

INSERT INTO Telefone (idPessoa, celular)
VALUES (2, '(85) 99595-3976');

INSERT INTO Telefone (idPessoa, celular)
VALUES (3, '(65) 98559-1330');

INSERT INTO Telefone (idPessoa, celular)
VALUES (4, '(86) 99330-0763');

INSERT INTO Telefone (idPessoa, celular)
VALUES (5, '(92) 99411-3160');

INSERT INTO Telefone (idPessoa, celular)
VALUES (6, '(91) 98932-0474');

INSERT INTO Telefone (idPessoa, celular)
VALUES (7, '(28) 99235-8672');

INSERT INTO Telefone (idPessoa, celular)
VALUES (8, '(82) 99253-1977');

INSERT INTO Telefone (idPessoa, celular)
VALUES (9, '(68) 98144-3365');

INSERT INTO Telefone (idPessoa, celular)
VALUES (10, '(84) 98490-8292');

COMMIT;