insert into cmei (id, nome, cidade, bairro, endereco) values
(1, 'CMEI Criança Feliz', 'Santa Tereza do Oeste', 'Santa Maria', 'Av. Manoel José de Carvalho, s/n'),
(2, 'CMEI Mariano Otto', 'Santa Tereza do Oeste', 'Centro', 'Av. Brasil, 1101'),
(3, 'CMEI Vercidilio Soares de Oliveira', 'Santa Tereza do Oeste', 'Vila Malucelli', 'Rua Amambaí, s/n'),
(4, 'CMEI Natalino Redivo', 'Santa Tereza do Oeste', 'Centro', 'Rua Buenos Aires, 454');

insert into vaga (id, cmei_id, nivel, quantidade) values
(1, 1, 'Infantil 1', 20),
(2, 1, 'Infantil 2', 25),
(3, 2, 'Infantil 3', 18),
(4, 3, 'Infantil 4', 22),
(5, 4, 'Infantil 5', 15);
