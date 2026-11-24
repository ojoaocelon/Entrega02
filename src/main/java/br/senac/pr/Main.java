package br.senac.pr;

import java.sql.SQLException;

import br.senac.pr.jdbc.CmeiDAO;
import br.senac.pr.modelo.Cmei;

public class Main {
    public static void main(String[] args) {
        CmeiDAO dao = new CmeiDAO();
        try {
            Cmei cmei = new Cmei(10, "CMEI Teste", "Santa Tereza do Oeste", "Centro", "Rua Teste, 100");
            dao.inserir(cmei);

            System.out.println("Busca pelo id 10:");
            System.out.println(dao.buscarCmeiPorId(10));

            System.out.println("Lista de CMEIs:");
            for (Cmei c : dao.listarCmeis()) {
                System.out.println(c);
            }

            dao.deletar(10);
            System.out.println("CMEI de teste removido");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
