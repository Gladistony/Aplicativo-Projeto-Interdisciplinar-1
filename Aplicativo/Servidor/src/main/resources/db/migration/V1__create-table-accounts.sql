CREATE TABLE accounts (
    id bigint not null auto_increment,
    nome VARCHAR(50) NOT NULL,
    login VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_nascimento DATE NULL,
    perfil_foto LONGBLOB NULL,
  
    primary key(id)
);