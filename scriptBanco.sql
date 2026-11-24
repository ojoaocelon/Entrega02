create table cmei(
	id INTEGER PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	bairro VARCHAR(100),
	endereco VARCHAR(150)
);

create table vaga(
	id INTEGER PRIMARY KEY,
	cmei_id INTEGER NOT NULL,
	nivel VARCHAR(20) NOT NULL,
	quantidade INTEGER NOT NULL CHECK (quantidade >= 0),
	FOREIGN KEY (cmei_id) REFERENCES cmei(id)
);
