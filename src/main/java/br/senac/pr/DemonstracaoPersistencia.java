package br.senac.pr;

import java.sql.SQLException;
import java.util.List;

import br.senac.pr.jdbc.CmeiDAO;
import br.senac.pr.modelo.Cmei;

// Demonstra a conversao entre objeto Java, banco e resultado de consulta.
public class DemonstracaoPersistencia {
    public static void main(String[] args) {
        CmeiDAO dao = new CmeiDAO();

        Cmei cmeiTeste = new Cmei();
        cmeiTeste.setId("cmei-demo-persistencia");
        cmeiTeste.setNome("CMEI Persistencia Demonstracao");
        cmeiTeste.setCidade("Santa Tereza do Oeste");
        cmeiTeste.setBairro("Centro");
        cmeiTeste.setEndereco("Rua dos Testes, 123");

        try {
            dao.inserir(cmeiTeste);
            System.out.println("1. Inserido: " + cmeiTeste.getNome());

            Cmei encontrado = dao.buscarPorId(cmeiTeste.getId());
            if (encontrado == null) {
                System.out.println("2. Consulta falhou: registro nao encontrado");
                return;
            }
            System.out.println("2. Consultado: " + encontrado.getNome()
                    + " - " + encontrado.getBairro() + ", " + encontrado.getCidade());

            System.out.println("3. CMEIs cadastrados:");
            List<Cmei> cmeis = dao.listar();
            for (Cmei cmei : cmeis) {
                System.out.println("   " + cmei.getId() + " | " + cmei.getNome()
                        + " | " + cmei.getBairro() + " | " + cmei.getCidade());
            }
        } catch (IllegalArgumentException | SQLException e) {
            System.out.println("Erro na demonstracao: " + e.getMessage());
        }
    }
}
