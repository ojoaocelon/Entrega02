package br.senac.pr.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.senac.pr.modelo.Cmei;

public class CmeiDAO {
    public void inserir(Cmei cmei) throws SQLException {
        String sql = "INSERT INTO cmei (id, nome, cidade, bairro, endereco) VALUES (?,?,?,?,?)";
        Connection conexao = Conexao.conectar();
        PreparedStatement stmt = conexao.prepareStatement(sql);
        try {
            stmt.setInt(1, cmei.getId());
            stmt.setString(2, cmei.getNome());
            stmt.setString(3, cmei.getCidade());
            stmt.setString(4, cmei.getBairro());
            stmt.setString(5, cmei.getEndereco());
            stmt.executeUpdate();
            System.out.println("CMEI inserido com sucesso");
        } catch (SQLException e) {
            System.out.println("Erro ao inserir CMEI: " + e.getMessage());
        } finally {
            stmt.close();
            conexao.close();
        }
    }

    public Cmei buscarCmeiPorId(int id) throws SQLException {
        String sql = "SELECT * FROM cmei WHERE id=?";
        Connection conexao = Conexao.conectar();
        PreparedStatement stmt = conexao.prepareStatement(sql);
        try {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return montarCmei(rs);
            }
        } finally {
            stmt.close();
            conexao.close();
        }
        return null;
    }

    public boolean atualizar(Cmei cmei) throws SQLException {
        String sql = "UPDATE cmei SET nome=?, cidade=?, bairro=?, endereco=? WHERE id=?";
        Connection conexao = Conexao.conectar();
        PreparedStatement stmt = conexao.prepareStatement(sql);
        try {
            stmt.setString(1, cmei.getNome());
            stmt.setString(2, cmei.getCidade());
            stmt.setString(3, cmei.getBairro());
            stmt.setString(4, cmei.getEndereco());
            stmt.setInt(5, cmei.getId());
            int resp = stmt.executeUpdate();
            return resp > 0;
        } finally {
            stmt.close();
            conexao.close();
        }
    }

    public boolean deletar(int id) throws SQLException {
        String sql = "DELETE FROM cmei WHERE id=?";
        Connection conexao = Conexao.conectar();
        PreparedStatement stmt = conexao.prepareStatement(sql);
        try {
            stmt.setInt(1, id);
            int resp = stmt.executeUpdate();
            return resp > 0;
        } finally {
            stmt.close();
            conexao.close();
        }
    }

    public List<Cmei> listarCmeis() throws SQLException {
        String sql = "SELECT * FROM cmei ORDER BY id";
        List<Cmei> cmeis = new ArrayList<>();
        Connection conexao = Conexao.conectar();
        PreparedStatement stmt = conexao.prepareStatement(sql);
        try {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                cmeis.add(montarCmei(rs));
            }
        } finally {
            stmt.close();
            conexao.close();
        }
        return cmeis;
    }

    private Cmei montarCmei(ResultSet rs) throws SQLException {
        Cmei cmei = new Cmei();
        cmei.setId(rs.getInt("id"));
        cmei.setNome(rs.getString("nome"));
        cmei.setCidade(rs.getString("cidade"));
        cmei.setBairro(rs.getString("bairro"));
        cmei.setEndereco(rs.getString("endereco"));
        return cmei;
    }
}
