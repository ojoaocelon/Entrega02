# Cadastro CMEI - Persistencia Inicial

Projeto Java com Maven que demonstra persistencia em PostgreSQL por JDBC.

## Requisitos atendidos

- Insercao e consulta de registros com `Connection` e `PreparedStatement`.
- Conversao de objetos `Cmei` para parametros SQL e de `ResultSet` para objetos Java.
- Dados de exemplo para testar insercao e consulta.
- Interface Swing integrada ao DAO para salvar, buscar, listar e excluir CMEIs.
- Configuracao por variaveis de ambiente sem alterar o codigo.

## Preparacao do banco

1. Crie o banco PostgreSQL `edufila`.
2. Execute `scriptBanco.sql` para criar as tabelas.
3. Execute `dadosExemplo.sql` para cadastrar o tenant e os registros de teste.

Configuracao padrao:

```text
URL: jdbc:postgresql://localhost:5432/edufila
Usuario: postgres
Senha: definida pela variavel DB_PASSWORD
```

Para usar outra conexao:

```powershell
$env:DB_URL="jdbc:postgresql://localhost:5432/edufila"
$env:DB_USER="postgres"
$env:DB_PASSWORD=Read-Host "Digite a senha do PostgreSQL"
```

## Compilar

```powershell
mvn clean compile
```

## Demonstrar a persistencia
digite o comando a seguir no terminal, no lugar de SUA_SENHA_AQUI, coloque sua senha do postgre:



$env:DB_PASSWORD="SUA_SENHA_AQUI"
mvn -q exec:java '-Dexec.mainClass=br.senac.pr.DemonstracaoPersistencia'



Com o banco configurado e os scripts executados:

```powershell
mvn -q exec:java '-Dexec.mainClass=br.senac.pr.DemonstracaoPersistencia'
```

A demonstracao cria ou atualiza um CMEI de teste, busca o registro pelo ID e lista
os CMEIs cadastrados. Ela usa `PreparedStatement` em todas as operacoes SQL.# Entrega03
