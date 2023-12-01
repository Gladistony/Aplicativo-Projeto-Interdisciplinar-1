CREATE TABLE accounts (
    id bigint not null auto_increment,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    data_nascimento DATE NOT NULL,
    ativo tinyint not null default 1,

    primary key(id)
);
