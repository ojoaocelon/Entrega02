package br.senac.pr;

import javax.swing.SwingUtilities;

import br.senac.pr.visao.TelaCmei;

public class Inicia {
    public static void main(String[] args) {
        SwingUtilities.invokeLater(()->{
            new TelaCmei();
        });
        
    }

}
