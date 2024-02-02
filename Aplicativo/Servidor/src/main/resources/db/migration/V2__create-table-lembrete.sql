CREATE TABLE lembretes (
    id bigint not null auto_increment,
    conta_id bigint not null, -- Assumindo que conta_id é um bigint
    nomeMedicamento VARCHAR(200) not null,
    horario TIME not null,
    dosagem FLOAT not null,
    intervaloHora INT null,
    dataInicio DATE,
    PRIMARY KEY (id),
    CONSTRAINT fk_lembretes_accounts_id FOREIGN KEY (conta_id) REFERENCES accounts(id)
);
