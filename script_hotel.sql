/*Alunas: Sophia e Ariele*/
CREATE DATABASE hotel;

USE hotel;

CREATE TABLE hospedagem (
codigo integer PRIMARY KEY,
data_entra datetime not null,
data_saida datetime not null,
data_prev_said datetime not null );

CREATE TABLE cliente (
codigo integer PRIMARY KEY,
cod_hospedagem integer not null, 
    CONSTRAINT fk_cli_hospedagem FOREIGN KEY (cod_hospedagem) REFERENCES hospedagem(codigo),
nome varchar (30) not null,
telefone integer not null,
endereco varchar (50) not null,
cpf varchar (14) UNIQUE not null );

CREATE TABLE cidade (
codigo integer PRIMARY KEY,
cod_cliente integer not null,
    CONSTRAINT fk_cid_cliente FOREIGN KEY (cod_cliente) REFERENCES cliente(codigo),
nome varchar (30) not null,
uf char(2) not null );

CREATE TABLE funcionário (
codigo integer PRIMARY KEY,
cod_hospedagem integer not null,
    CONSTRAINT fk_fun_hospedagem FOREIGN KEY (cod_hospedagem) REFERENCES hospedagem(codigo),
nome varchar (30) not null );

CREATE TABLE diaria (
cod_hospedagem integer not null, 
    CONSTRAINT fk_dia_hospedagem FOREIGN KEY (cod_hospedagem) REFERENCES hospedagem(codigo),
valor numeric(15,2) not null,
data date not null,
data_pag datetime not null,
PRIMARY KEY (cod_hospedagem, data) );

CREATE TABLE quarto (
codigo integer PRIMARY KEY, 
cod_hospedagem integer not null,
    CONSTRAINT fk_quar_hospedagem FOREIGN KEY (cod_hospedagem) REFERENCES hospedagem(codigo),
numero integer not null,
estado char(2) not null,
valor numeric(15,2) not null );
  
CREATE TABLE categoria (
codigo integer PRIMARY KEY,
cod_quarto integer not null,
    CONSTRAINT fk_cat_quarto FOREIGN KEY (cod_quarto) REFERENCES quarto(codigo),
nome varchar (30) not null );

CREATE TABLE servicos (
codigo integer PRIMARY KEY,
descricao varchar(50) not null, 
valor numeric(15,2) not null );

CREATE TABLE servi_soli (
data_solici datetime not null,
cod_hospedagem integer not null, 
    CONSTRAINT fk_servi_so_hospedagem FOREIGN KEY (cod_hospedagem) REFERENCES hospedagem(codigo),
cod_servicos integer not null, 
    CONSTRAINT fk_servi_so_servicos FOREIGN KEY (cod_servicos) REFERENCES servicos(codigo),
valor_total numeric(15,2) not null,
data_pag datetime not null,
PRIMARY KEY (cod_hospedagem, cod_servicos, data_solici) );

CREATE TABLE produtos (
codigo integer PRIMARY KEY,
nome varchar(30) not null,
qtd integer not null, 
valor numeric(15,2) not null );

CREATE TABLE prod_consu (
data_venda date not null,
cod_hospedagem integer not null, 
    CONSTRAINT fk_prod_c_hospedagem FOREIGN KEY (cod_hospedagem) REFERENCES hospedagem(codigo),
cod_produtos integer not null, 
    CONSTRAINT fk_prod_c_produtos FOREIGN KEY (cod_produtos) REFERENCES produtos(codigo),
qtd integer not null, 
valor numeric(15,2) not null,
data_pag datetime not null,
PRIMARY KEY (cod_hospedagem, cod_produtos, data_venda));

/*3. Desenvolva uma visão (View) que retorne o nome de todos hóspedes 
cadastrados e a quantidade de locações de quartos de cada um.*/

CREATE OR REPLACE VIEW vw_e3 
AS
SELECT cliente.nome, COUNT(cliente.cod_hospedagem) AS locacoes_quartos
FROM cliente LEFT JOIN hospedagem ON (hospedagem.codigo = cliente.cod_hospedagem)
GROUP BY cliente.nome;

/*4. Desenvolva uma visão (View) que retorne todos os produtos oferecidos pelo hotel 
com seus respectivos valores.*/

CREATE OR REPLACE VIEW vw_e4
AS
SELECT produtos.nome, produtos.valor
FROM produtos
GROUP BY produtos.nome;

/*5. Desenvolva uma visão (View) que retorne todos os serviços oferecidos pelo hotel 
com seus respectivos valores.*/

CREATE OR REPLACE VIEW vw_e5
AS
SELECT servicos.descricao, servicos.valor
FROM servicos
GROUP BY servicos.descricao;

/*6. Desenvolva uma visão (View) que retorne o nome do hóspede, o código da 
hospedagem, o número do quarto, a data de entrada (check-in) e a data de saída
(check-out) de todas as hospedagens realizadas no ano de 2021 (considerar a 
data de entrada).*/

CREATE OR REPLACE VIEW vw_e6
AS
SELECT cliente.nome, hospedagem.codigo, quarto.numero, hospedagem.data_entra, hospedagem.data_saida
FROM cliente JOIN hospedagem ON (hospedagem.codigo = cliente.cod_hospedagem) JOIN quarto ON (hospedagem.codigo = quarto.cod_hospedagem)
WHERE hospedagem.data_entra BETWEEN "2021-01-01" AND "2021-12-31"
GROUP BY cliente.nome;

/*7. Desenvolva Procedimento Armazenado (Stored Procedure) para INSERIR dados 
em uma das tabela do banco de dados e mostrar o registro inserido.*/

DELIMITER $$
CREATE PROCEDURE sp_e7 (IN cod_produt integer, IN nome_produt varchar(30), IN qtd_produt integer, IN valor_produt decimal(5,2))
BEGIN
INSERT INTO produtos VALUES (cod_produt, nome_produt, qtd_produt, valor_produt);
SELECT * FROM produtos WHERE codigo = cod_produt;
END $$
DELIMITER ;

/*8. Desenvolva Procedimento Armazenado (Stored Procedure) para ATUALIZAR os 
dados de um determinado registro em uma das tabelas do banco de dados e 
mostrar o registro atualizado. O usuário deverá informar qual o registro da tabela 
que será atualizado.*/

DELIMITER $$
CREATE PROCEDURE sp_e8 (IN cod_info integer, IN nome_info varchar(30))
BEGIN
UPDATE categoria SET nome = nome_info, codigo = cod_info WHERE codigo = cod_info;
SELECT * FROM categoria WHERE codigo = cod_info;
END $$
DELIMITER ;

/*9. Desenvolva Procedimento Armazenado (Stored Procedure) para EXCLUIR um 
determinado registro em uma das tabela do banco de dados e mostrar todos os 
registros restantes na tabela. O usuário deverá informar qual o registro que será 
excluído.*/

DELIMITER $$
CREATE PROCEDURE sp_e9 (IN cod_info integer)
BEGIN
DELETE FROM funcionario WHERE codigo = cod_info;
SELECT * FROM funcionario;
END $$
DELIMITER ;

/*10.Desenvolva um Procedimento Armazenado (Stored Procedure) que retorne a 
data da venda, o valor e a descrição dos serviços solicitados em um determinado 
período de uma determinada hospedagem. O usuário deve informar o período e 
o código da hospedagem.*/

DELIMITER $$
CREATE PROCEDURE sp_e10 (IN data_info_1 date, IN data_info2 date, IN cod_info integer)
BEGIN
SELECT servi_soli.data_solici, servicos.valor, servicos.descricao
FROM servicos JOIN servi_soli ON (servicos.codigo = servi_soli.cod_servicos) JOIN hospedagem ON (hospedagem.codigo = servi_soli.cod_hospedagem)
WHERE hospedagem.codigo = cod_info AND hospedagem.data_entra BETWEEN data_info1 AND data_info2 AND hospedagem.data_saida BETWEEN data_info1 AND data_info2;
END $$
DELIMITER ;

/*11.Desenvolva um Procedimento Armazenado (Stored Procedure) que retorne a 
data da venda, a quantidade, o valor unitário, o valor total e a descrição dos
produtos consumidos em um determinado período de uma determinada 
hospedagem. O usuário deve informar o período e o código da hospedagem.*/

DELIMITER $$
CREATE PROCEDURE sp_e11 (IN cod_info integer, IN data_info1 date, IN data_info2 date)
BEGIN
SELECT prod_consu.data_venda, prod_consu.qtd, produtos.valor, prod_consu.valor, prod_consu.descricao
FROM produtos JOIN prod_consu ON (produtos.codigo = prod_consu.cod_produtos) JOIN hospedagem ON (hospedagem.codigo = prod_consu.cod_hospedagem)
WHERE hospedagem.codigo = cod_info AND prod_consu.data_venda BETWEEN data_info1 AND data_info2;
END $$
DELIMITER ;

/*12. Desenvolva um gatilho para a que na hora de realizar uma hospedagem, 
verifique se a data prevista para saída for igual ou menor que a data de entrada, 
atribua à data prevista de saída, a data de entrada mais 1 dia.*/

DELIMITER &&
CREATE TRIGGER trg_e12
BEFORE INSERT ON hospedagem FOR EACH ROW
BEGIN
IF NEW.data_prev_said <= NEW.data_entra THEN
SET NEW.data_prev_said = NEW.data_entra + 1;
END IF;
END &&
DELIMITER ;

/*13. Desenvolva um gatilho para a que na hora de inserir um novo produto verifique 
se a quantidade for menor que zero, atribua o valor zero.*/

DELIMITER &&
CREATE TRIGGER trg_e13
BEFORE INSERT ON produtos FOR EACH ROW
BEGIN
IF NEW.qtd < 0 THEN
SET NEW.qtd = 0;
END IF;
END &&
DELIMITER ;

/*14.Desenvolva um gatilho para a que na hora de vender um produto verifique se o 
valor vendido for menor que o valor do cadastro do produto, atribua o mesmo 
valor do cadastro.*/

DELIMITER &&
CREATE TRIGGER trg_e14
BEFORE INSERT ON prod_consu FOR EACH ROW
BEGIN
IF NEW.valor < (SELECT valor FROM produtos WHERE codigo = NEW.cod_produtos) THEN
SET NEW.valor = (SELECT valor FROM produtos WHERE codigo = NEW.cod_produtos);
END IF;
END &&
DELIMITER ;

