package br.senac.pr.visao;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.sql.SQLException;
import java.util.List;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import br.senac.pr.jdbc.CmeiDAO;
import br.senac.pr.modelo.Cmei;

public class TelaCmei extends JFrame {
    private JTextField txtId;
    private JTextField txtNome;
    private JTextField txtCidade;
    private JTextField txtBairro;
    private JTextField txtEndereco;

    private JButton btnSalvar;
    private JButton btnAlterar;
    private JButton btnLimpar;
    private JButton btnBuscar;
    private JButton btnDeletar;
    private JButton btnListar;

    private JTable tabela;
    private DefaultTableModel modeloTabela;

    public TelaCmei() {
        setTitle("Cadastro de CMEIs");
        setSize(800, 450);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        txtId = new JTextField(10);
        txtNome = new JTextField(20);
        txtCidade = new JTextField(15);
        txtBairro = new JTextField(15);
        txtEndereco = new JTextField(20);

        btnSalvar = new JButton("Salvar");
        btnAlterar = new JButton("Alterar");
        btnLimpar = new JButton("Limpar");
        btnBuscar = new JButton("Buscar");
        btnDeletar = new JButton("Deletar");
        btnListar = new JButton("Listar");

        JPanel painelCampos = new JPanel(new GridLayout(5, 2));
        painelCampos.add(new JLabel("Id"));
        painelCampos.add(txtId);
        painelCampos.add(new JLabel("Nome"));
        painelCampos.add(txtNome);
        painelCampos.add(new JLabel("Cidade"));
        painelCampos.add(txtCidade);
        painelCampos.add(new JLabel("Bairro"));
        painelCampos.add(txtBairro);
        painelCampos.add(new JLabel("Endereço"));
        painelCampos.add(txtEndereco);

        JPanel painelBotoes = new JPanel();
        painelBotoes.add(btnSalvar);
        painelBotoes.add(btnAlterar);
        painelBotoes.add(btnLimpar);
        painelBotoes.add(btnBuscar);
        painelBotoes.add(btnDeletar);
        painelBotoes.add(btnListar);

        JPanel painel = new JPanel(new BorderLayout());
        painel.add(painelCampos, BorderLayout.CENTER);
        painel.add(painelBotoes, BorderLayout.SOUTH);

        String[] colunas = {"ID", "Nome", "Cidade", "Bairro", "Endereço"};
        modeloTabela = new DefaultTableModel(colunas, 0) {
            @Override
            public boolean isCellEditable(int linha, int coluna) {
                return false;
            }
        };
        tabela = new JTable(modeloTabela);
        JScrollPane scroll = new JScrollPane(tabela);

        add(painel, BorderLayout.NORTH);
        add(scroll, BorderLayout.CENTER);

        btnSalvar.addActionListener(e -> salvarCmei());
        btnAlterar.addActionListener(e -> alterarCmei());
        tabela.getSelectionModel().addListSelectionListener(e -> preencherCampos());
        btnLimpar.addActionListener(e -> limparCampos());
        btnBuscar.addActionListener(e -> buscarCmei());
        btnDeletar.addActionListener(e -> deletarCmei());
        btnListar.addActionListener(e -> listarCmeis());
        listarCmeis();
        setVisible(true);
    }

    private void listarCmeis() {
        CmeiDAO dao = new CmeiDAO();
        modeloTabela.setRowCount(0);
        try {
            List<Cmei> cmeis = dao.listarCmeis();
            for (Cmei cmei : cmeis) {
                Object[] linha = {cmei.getId(), cmei.getNome(), cmei.getCidade(), cmei.getBairro(), cmei.getEndereco()};
                modeloTabela.addRow(linha);
            }
        } catch (SQLException e) {
            mostrarErroBanco(e);
        }
    }

    private void preencherCampos() {
        int linha = tabela.getSelectedRow();
        if (linha == -1) {
            return;
        }
        txtId.setText(modeloTabela.getValueAt(linha, 0).toString());
        txtNome.setText(String.valueOf(modeloTabela.getValueAt(linha, 1)));
        txtCidade.setText(String.valueOf(modeloTabela.getValueAt(linha, 2)));
        txtBairro.setText(textoOuVazio(modeloTabela.getValueAt(linha, 3)));
        txtEndereco.setText(textoOuVazio(modeloTabela.getValueAt(linha, 4)));
    }

    private String textoOuVazio(Object valor) {
        if (valor == null) {
            return "";
        }
        return valor.toString();
    }

    private void deletarCmei() {
        CmeiDAO dao = new CmeiDAO();
        try {
            int id = lerId();
            Cmei cmei = dao.buscarCmeiPorId(id);
            if (cmei == null) {
                JOptionPane.showMessageDialog(this, "Nenhum CMEI encontrado com o id " + id);
                return;
            }
            int resp = JOptionPane.showConfirmDialog(this, "Deseja excluir o " + cmei.getNome() + "?",
                    "Confirmar exclusão", JOptionPane.YES_NO_OPTION);
            if (resp == JOptionPane.YES_OPTION) {
                dao.deletar(id);
                JOptionPane.showMessageDialog(this, "CMEI excluído com sucesso");
                limparCampos();
                listarCmeis();
            }
        } catch (IllegalArgumentException e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        } catch (SQLException e) {
            if ("23503".equals(e.getSQLState())) {
                JOptionPane.showMessageDialog(this, "Não é possível excluir este CMEI porque ele possui vagas cadastradas.");
            } else {
                mostrarErroBanco(e);
            }
        }
    }

    private void buscarCmei() {
        CmeiDAO dao = new CmeiDAO();
        try {
            int id = lerId();
            Cmei cmei = dao.buscarCmeiPorId(id);
            if (cmei == null) {
                JOptionPane.showMessageDialog(this, "Nenhum CMEI encontrado com o id " + id);
                return;
            }
            txtNome.setText(cmei.getNome());
            txtCidade.setText(cmei.getCidade());
            txtBairro.setText(cmei.getBairro());
            txtEndereco.setText(cmei.getEndereco());
        } catch (IllegalArgumentException e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        } catch (SQLException e) {
            mostrarErroBanco(e);
        }
    }

    private void salvarCmei() {
        try {
            Cmei cmei = lerCampos();
            CmeiDAO dao = new CmeiDAO();
            if (dao.buscarCmeiPorId(cmei.getId()) != null) {
                JOptionPane.showMessageDialog(this, "Já existe um CMEI com o id " + cmei.getId()
                        + ". Use outro id ou clique em Alterar.");
                return;
            }
            dao.inserir(cmei);
            listarCmeis();
            JOptionPane.showMessageDialog(this, "CMEI salvo com sucesso");
            limparCampos();
        } catch (IllegalArgumentException e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        } catch (SQLException e) {
            mostrarErroBanco(e);
        }
    }

    private void alterarCmei() {
        try {
            Cmei cmei = lerCampos();
            CmeiDAO dao = new CmeiDAO();
            if (dao.atualizar(cmei)) {
                listarCmeis();
                JOptionPane.showMessageDialog(this, "CMEI alterado com sucesso");
                limparCampos();
            } else {
                JOptionPane.showMessageDialog(this, "Nenhum CMEI encontrado com o id " + cmei.getId());
            }
        } catch (IllegalArgumentException e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        } catch (SQLException e) {
            mostrarErroBanco(e);
        }
    }

    private Cmei lerCampos() {
        Cmei cmei = new Cmei();
        cmei.setId(lerId());
        cmei.setNome(txtNome.getText());
        cmei.setCidade(txtCidade.getText());
        cmei.setBairro(txtBairro.getText().trim());
        cmei.setEndereco(txtEndereco.getText().trim());
        return cmei;
    }

    private int lerId() {
        String texto = txtId.getText().trim();
        if (texto.isEmpty()) {
            throw new IllegalArgumentException("Informe o id do CMEI");
        }
        try {
            return Integer.parseInt(texto);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("O id deve ser um número inteiro (ex.: 1, 2, 3)");
        }
    }

    private void mostrarErroBanco(SQLException e) {
        JOptionPane.showMessageDialog(this, "Erro ao acessar o banco de dados.\n"
                + "Verifique se o PostgreSQL está rodando.\n\nDetalhe: " + e.getMessage(),
                "Erro", JOptionPane.ERROR_MESSAGE);
    }

    private void limparCampos() {
        txtId.setText("");
        txtNome.setText("");
        txtCidade.setText("");
        txtBairro.setText("");
        txtEndereco.setText("");
        tabela.clearSelection();
        txtId.requestFocus();
    }
}
