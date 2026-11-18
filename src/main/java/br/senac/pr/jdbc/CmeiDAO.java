package br.senac.pr.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.senac.pr.modelo.Cmei;

// No banco edufila (criado pelo Prisma) os nomes de tabela/colunas usam
// letras maiúsculas, por isso ficam entre aspas duplas no SQL.
public class CmeiDAO {
    // Todo CMEI pertence a uma prefeitura (tabela "Tenant")
    private static final String TENANT_PADRAO = "tenant-santa-tereza";

    public void inserir(Cmei cmei) throws SQLException {
        String sql = "INSERT INTO \"Cmei\" (id, \"tenantId\", name, city, region, address, active, \"updatedAt\") "
                + "VALUES (?,?,?,?,?,?,?, CURRENT_TIMESTAMP)";
        try (Connection conexao = Conexao.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, cmei.getId());
            stmt.setString(2, TENANT_PADRAO);
            stmt.setString(3, cmei.getNome());
            stmt.setString(4, cmei.getCidade());
            stmt.setString(5, cmei.getBairro());
            stmt.setString(6, cmei.getEndereco());
            stmt.setBoolean(7, cmei.isAtivo());
            stmt.executeUpdate();
            System.out.println("CMEI inserido com sucesso");
        }
    }

    public Cmei buscarPorId(String id) throws SQLException {
        String sql = "SELECT * FROM \"Cmei\" WHERE id=?";
        try (Connection conexao = Conexao.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return montar(rs);
                }
            }
        }
        return null;
    }

    public boolean deletar(String id) throws SQLException {
        String sql = "DELETE FROM \"Cmei\" WHERE id=?";
        try (Connection conexao = Conexao.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Cmei> listar() throws SQLException {
        String sql = "SELECT * FROM \"Cmei\" ORDER BY name";
        List<Cmei> lista = new ArrayList<>();
        try (Connection conexao = Conexao.conectar();
             PreparedStatement stmt = conexao.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                lista.add(montar(rs));
            }
        }
        return lista;
    }

    private Cmei montar(ResultSet rs) throws SQLException {
        Cmei cmei = new Cmei();
        cmei.setId(rs.getString("id"));
        cmei.setNome(rs.getString("name"));
        cmei.setCidade(rs.getString("city"));
        cmei.setBairro(rs.getString("region"));
        cmei.setEndereco(rs.getString("address"));
        cmei.setAtivo(rs.getBoolean("active"));
        return cmei;
    }
}
