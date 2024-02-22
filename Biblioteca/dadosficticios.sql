-- Nota: Os dados abaixo são fictícios e destinados apenas para fins de demonstração.

INSERT INTO curso (nome)
VALUE ('Química'); 
INSERT INTO curso (nome)
VALUE ('Física'); 

INSERT INTO estudantes (nome, data_nasc, email, endereco, id)
VALUES ('João da Silva', '1985-05-15', 'joao@email.com', 'Rua Sdsfe Cidade Aafea', 1);
INSERT INTO estudantes (nome, data_nasc, email, endereco, id)
VALUES ('Maria Oliveira', '1986-09-07', 'maria@email.com', 'Rua Jniefse Cidade Ijkrne', 1);
INSERT INTO estudantes (nome, data_nasc, email, endereco, id)
VALUES ('Carlos Santos', '1978-01-21', 'carlos@email.com', 'Rua Awaewe Cidade Atgrtr', 2);
INSERT INTO estudantes (nome, data_nasc, email, endereco, id)
VALUES ('Ana Rodrigues', '2000-10-19', 'anar@email.com', 'Rua Bietf Cidade Ijwnfe', 2);

INSERT INTO telefone_estudantes (id_matricula, numero_telefone)
VALUES (6, '613989844');
INSERT INTO telefone_estudantes (id_matricula, numero_telefone)
VALUES (7, '498495653');
INSERT INTO telefone_estudantes (id_matricula, numero_telefone)
VALUES (8, '584532515');
INSERT INTO telefone_estudantes (id_matricula, numero_telefone)
VALUES (9, '453221655');

INSERT INTO cargo (nome)
VALUE ('Bibliotecário');  

INSERT INTO funcionarios (nome, email, id_cargo)
VALUES ('Pedro Almeida','pedro@email.com', 1);
INSERT INTO funcionarios (nome, email, id_cargo)
VALUES ('Luísa Fernandes', 'luisa@email.com', 1);

INSERT INTO telefone_f (id_funcionario, numero_telefone)
VALUES (4, '89453221655');
INSERT INTO telefone_f (id_funcionario, numero_telefone)
VALUES (5, '89453221655');

INSERT INTO categoria (nome)
VALUE ('Fantasia'); 
INSERT INTO categoria (nome)
VALUE ('Terror'); 

INSERT INTO autores (nome)
VALUE ('Rodrigo Santos'); 
INSERT INTO autores (nome)
VALUE ('Gabriela Alves'); 

INSERT INTO livros (nome, sinopse, id_categoria)
VALUES ('Mundo Magico', 'O protagonista acabou parando em outro mundo', 1);
INSERT INTO livros (nome, sinopse, id_categoria)
VALUES ('Mundo Imaginario', 'O protagonista viajou para outro mundo', 1);
INSERT INTO livros (nome, sinopse, id_categoria)
VALUES ('O Horror', 'Coisas ruins acontecem em um lugar', 2);
INSERT INTO livros (nome, sinopse, id_categoria)
VALUES ('Casa mal-assombrada', 'Uma casa que tem assonbrações', 2);

INSERT INTO exemplar (status_livr, id_livro)
VALUE ('Disponivel', 5); 
INSERT INTO exemplar (status_livr, id_livro)
VALUE ('Disponivel', 5); 
INSERT INTO exemplar (status_livr, id_livro)
VALUE ('Disponivel', 6); 
INSERT INTO exemplar (status_livr, id_livro)
VALUE ('Disponivel', 6); 
INSERT INTO exemplar (status_livr, id_livro)
VALUE ('Emprestado', 7); 
INSERT INTO exemplar (status_livr, id_livro)
VALUE ('Emprestado', 7); 
INSERT INTO exemplar (status_livr, id_livro)
VALUE ('Disponivel', 8); 

INSERT INTO livr_autr (id_autor, id_livro)
VALUE (1, 5); 
INSERT INTO livr_autr (id_autor, id_livro)
VALUE (1, 6);
INSERT INTO livr_autr (id_autor, id_livro)
VALUE (2, 7); 
INSERT INTO livr_autr (id_autor, id_livro)
VALUE (2, 8);

INSERT INTO emprestimo (data_dev_prev, data_empres, data_dev_real, id_funcionario, id_matricula)
VALUES ('2023-05-15', '2023-05-09', '2023-05-15', 4, 6);
INSERT INTO emprestimo (data_dev_prev, data_empres, data_dev_real, id_funcionario, id_matricula)
VALUES ('2023-05-17', '2023-05-11', NULL , 5, 8);
INSERT INTO emprestimo (data_dev_prev, data_empres, data_dev_real, id_funcionario, id_matricula)
VALUES ('2023-05-18', '2023-05-12', NULL , 5, 9);

INSERT INTO empre_livro (status_empr, id_emprestimo, id_exemplar)
VALUES ('Devolvido', 1, 10);
INSERT INTO empre_livro (status_empr, id_emprestimo, id_exemplar)
VALUES ('Ativo', 2, 13);
INSERT INTO empre_livro (status_empr, id_emprestimo, id_exemplar)
VALUES ('Ativo', 3, 14);

INSERT INTO reserva (status_reser, data_reserv, id_livro)
VALUES ('Esperando', '2023-05-14', 7);

INSERT INTO reserv_estud (id_reserva, id_matricula)
VALUES (1, 7);
