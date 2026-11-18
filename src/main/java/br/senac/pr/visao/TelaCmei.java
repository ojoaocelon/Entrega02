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
    private JButton btnLimpar;
    private JButton btnBuscar;
    private JButton btnDeletar;
    private JButton btnListar;

    private JTable tabela;
    private DefaultTableModel modeloTabela;

    public TelaCmei() {
        setTitle("Cadastro de CMEIs - EduFila");
        setSize(900, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        txtId = new JTextField(15);
        txtNome = new JTextField(25);
        txtCidade = new JTextField(15);
        txtBairro = new JTextField(15);
        txtEndereco = new JTextField(25);

        btnSalvar = new JButton("Salvar");
        btnLimpar = new JButton("Limpar");
        btnBuscar = new JButton("Buscar");
        btnDeletar = new JButton("Deletar");
        btnListar = new JButton("Listar");

        // campos
        JPanel painelCampos = new JPanel(new GridLayout(5, 2, 5, 5));
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

        // botões
        JPanel painelBotoes = new JPanel();
        painelBotoes.add(btnSalvar);
        painelBotoes.add(btnLimpar);
        painelBotoes.add(btnBuscar);
        painelBotoes.add(btnDeletar);
        painelBotoes.add(btnListar);

        JPanel painel = new JPanel(new BorderLayout());
        painel.add(painelCampos, BorderLayout.CENTER);
        painel.add(painelBotoes, BorderLayout.SOUTH);

        String[] colunas = {"ID", "Nome", "Cidade", "Bairro", "Endereço", "Ativo"};
        modeloTabela = new DefaultTableModel(colunas, 0);
        tabela = new JTable(modeloTabela);
        JScrollPane scroll = new JScrollPane(tabela);

        add(painel, BorderLayout.NORTH);
        add(scroll, BorderLayout.CENTER);

        btnSalvar.addActionListener(e -> salvarCmei());
        btnLimpar.addActionListener(e -> limparCampos());
        btnBuscar.addActionListener(e -> buscarCmei(txtId.getText().trim()));
        btnDeletar.addActionListener(e -> deletarCmei());
        btnListar.addActionListener(e -> listarCmeis());

        listarCmeis();
        setVisible(true);
    }

    private void listarCmeis() {
        CmeiDAO dao = new CmeiDAO();
        modeloTabela.setRowCount(0);
        try {
            List<Cmei> cmeis = dao.listar();
            for (Cmei c : cmeis) {
                Object[] linha = {c.getId(), c.getNome(), c.getCidade(), c.getBairro(),
                        c.getEndereco(), c.isAtivo() ? "Sim" : "Não"};
                modeloTabela.addRow(linha);
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Erro ao listar: " + e.getMessage());
        }
    }

    private void deletarCmei() {
        String id = txtId.getText().trim();
        if (id.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Informe um id válido");
            return;
        }
        int resp = JOptionPane.showConfirmDialog(this, "Deseja confirmar a exclusão?",
                "Confirmar exclusão", JOptionPane.YES_NO_OPTION);
        if (resp != JOptionPane.YES_OPTION) {
            return;
        }
        try {
            boolean ok = new CmeiDAO().deletar(id);
            JOptionPane.showMessageDialog(this, ok ? "CMEI excluído" : "CMEI não encontrado");
            limparCampos();
            listarCmeis();
        } catch (SQLException e) {
            // ex.: CMEI ligado a vagas, inscrições ou usuários
            JOptionPane.showMessageDialog(this, "Não foi possível excluir: " + e.getMessage());
        }
    }

    private void buscarCmei(String id) {
        try {
            Cmei c = new CmeiDAO().buscarPorId(id);
            if (c == null) {
                JOptionPane.showMessageDialog(this, "CMEI não encontrado");
                return;
            }
            txtNome.setText(c.getNome());
            txtCidade.setText(c.getCidade());
            txtBairro.setText(c.getBairro());
            txtEndereco.setText(c.getEndereco());
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Erro ao buscar: " + e.getMessage());
        }
    }

    private void salvarCmei() {
        try {
            Cmei c = new Cmei();
            c.setId(txtId.getText());
            c.setNome(txtNome.getText());
            c.setCidade(txtCidade.getText().trim());
            c.setBairro(txtBairro.getText().trim());
            c.setEndereco(txtEndereco.getText().trim());

            new CmeiDAO().inserir(c);
            listarCmeis();
            JOptionPane.showMessageDialog(this, "CMEI salvo");
            limparCampos();
        } catch (IllegalArgumentException e) {
            JOptionPane.showMessageDialog(this, e.getMessage());
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Erro ao salvar: " + e.getMessage());
        }
    }

    private void limparCampos() {
        txtId.setText("");
        txtNome.setText("");
        txtCidade.setText("");
        txtBairro.setText("");
        txtEndereco.setText("");
        txtId.requestFocus();
    }
}
