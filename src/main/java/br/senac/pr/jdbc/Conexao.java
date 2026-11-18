package br.senac.pr.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Configuração da conexão com o banco de dados por JDBC (PostgreSQL).
// O driver vem da dependência org.postgresql:postgresql declarada no pom.xml.
public class Conexao {
    // driver:sgbd://ip da maquina do servidor do banco:porta do banco/base de dados
    private static final String URL_PADRAO = "jdbc:postgresql://localhost:5432/edufila";
    private static final String USER_PADRAO = "postgres";
    private static final String PASSWORD_PADRAO = "";

    // Para usar outro banco sem mexer no código, basta definir as variáveis de
    // ambiente DB_URL, DB_USER e DB_PASSWORD antes de executar o programa.
    private static final String url = lerConfiguracao("DB_URL", URL_PADRAO);
    private static final String user = lerConfiguracao("DB_USER", USER_PADRAO);
    private static final String password = lerConfiguracao("DB_PASSWORD", PASSWORD_PADRAO);

    public static Connection conectar() throws SQLException {
        if (password.isBlank()) {
            throw new SQLException("Senha do PostgreSQL nao configurada. "
                    + "Defina a variavel de ambiente DB_PASSWORD.");
        }
        Connection conexao = DriverManager.getConnection(url, user, password);
        return conexao;
    }

    private static String lerConfiguracao(String variavel, String padrao) {
        String valor = System.getenv(variavel);
        if (valor == null || valor.isBlank()) {
            return padrao;
        }
        return valor;
    }
}
