package br.senac.pr;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.senac.pr.jdbc.Conexao;

// Demonstração da conexão com o banco de dados por JDBC:
// abre a conexão, mostra os dados do banco, confere as tabelas do sistema,
// faz uma consulta simples e fecha a conexão.
public class TestaConexao {
    private static final String[] TABELAS = {
            "Tenant", "Cmei", "Capacity", "Guardian", "Child", "EnrollmentRequest" };

    public static void main(String[] args) {
        // try-with-resources: a conexão é fechada sozinha no final do bloco
        try (Connection conexao = Conexao.conectar()) {
            System.out.println("Conexao realizada com sucesso");

            DatabaseMetaData dados = conexao.getMetaData();
            System.out.println("Banco:   " + dados.getDatabaseProductName() + " "
                    + dados.getDatabaseProductVersion());
            System.out.println("Driver:  " + dados.getDriverName() + " " + dados.getDriverVersion());
            System.out.println("URL:     " + dados.getURL());
            System.out.println("Usuario: " + dados.getUserName());

            System.out.println();
            System.out.println("Tabelas do sistema:");
            for (String tabela : TABELAS) {
                if (tabelaExiste(dados, tabela)) {
                    System.out.println("  " + tabela + ": " + contarRegistros(conexao, tabela) + " registro(s)");
                } else {
                    System.out.println("  " + tabela + ": NAO ENCONTRADA (rode o scriptBanco.sql)");
                }
            }

            if (tabelaExiste(dados, "Cmei")) {
                System.out.println();
                System.out.println("CMEIs cadastrados:");
                listarCmeis(conexao);
            }
        } catch (SQLException e) {
            System.out.println("erro ao conectar no banco");
            System.out.println(e.getMessage());
        }
    }

    private static boolean tabelaExiste(DatabaseMetaData dados, String tabela) throws SQLException {
        try (ResultSet rs = dados.getTables(null, "public", tabela, new String[] { "TABLE" })) {
            return rs.next();
        }
    }

    // O nome da tabela vem só da lista fixa TABELAS, nunca do usuário
    private static int contarRegistros(Connection conexao, String tabela) throws SQLException {
        String sql = "SELECT COUNT(*) FROM \"" + tabela + "\"";
        try (PreparedStatement stmt = conexao.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            rs.next();
            return rs.getInt(1);
        }
    }

    private static void listarCmeis(Connection conexao) throws SQLException {
        String sql = "SELECT name, city, region FROM \"Cmei\" ORDER BY name";
        try (PreparedStatement stmt = conexao.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                System.out.println("  " + rs.getString("name") + " - " + rs.getString("region")
                        + ", " + rs.getString("city"));
            }
        }
    }
}
