CREATE DATABASE biblioteca;

CREATE TABLE cargo (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    email VARCHAR(50),
	id_cargo INT,
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
);

CREATE TABLE telefone_f (
    id_telefone INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT,
    numero_telefone VARCHAR(20),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE
);

CREATE TABLE estudantes (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    email VARCHAR(50),
    data_nasc DATE,
    endereco VARCHAR(80),
	id INT,
    FOREIGN KEY (id) REFERENCES curso(id)
);

CREATE TABLE telefone_estudantes (
    id_telefone INT AUTO_INCREMENT PRIMARY KEY,
    numero_telefone VARCHAR(20),
	id_matricula INT,
    FOREIGN KEY (id_matricula) REFERENCES estudantes(id_matricula)
);

CREATE TABLE emprestimo (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_dev_prev DATE,
    data_empres DATE,
    data_dev_real DATE,
	id_funcionario INT,
    id_matricula INT,
	FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
 	FOREIGN KEY (id_matricula) REFERENCES Estudantes(id_matricula)   
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE
);

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE
);
 
CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30),
    sinopse VARCHAR(255),
    qtd_exemplares INT,
    id_categoria INT,
 	FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)     
);    

CREATE TABLE livr_autr (
    id_livr_autr INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT,
    id_livro INT,
 	FOREIGN KEY (id_autor) REFERENCES autores(id_autor),     
 	FOREIGN KEY (id_livro) REFERENCES livros(id_livro)     
);

CREATE TABLE exemplar (
	id_exemplar INT AUTO_INCREMENT PRIMARY KEY,
	status_livr ENUM ('Disponivel', 'Emprestado'),
	id_livro INT,
 	FOREIGN KEY (id_livro) REFERENCES livros(id_livro)  
);

CREATE TABLE empre_livro (
    id_empre_livro INT AUTO_INCREMENT PRIMARY KEY,
    status_empr ENUM ('Atrasado', 'Devolvido', 'Ativo', 'Renovado'),
    id_emprestimo INT,
    id_exemplar INT,
 	FOREIGN KEY (id_emprestimo) REFERENCES emprestimo(id_emprestimo),     
 	FOREIGN KEY (id_exemplar) REFERENCES exemplar(id_exemplar)     
);

CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    status_reser ENUM ('Esperando', 'Aprovado'),
    data_reserv DATE,
    id_livro INT,
 	FOREIGN KEY (id_livro) REFERENCES livros(id_livro)     
);

CREATE TABLE reserv_estud (
    id_reserv_estud INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT,
    id_reserva INT,
 	FOREIGN KEY (id_matricula) REFERENCES estudantes(id_matricula),     
 	FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)     
);