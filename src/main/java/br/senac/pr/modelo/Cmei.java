package br.senac.pr.modelo;

// Representa a tabela "Cmei" do banco edufila
public class Cmei {
    private String id;
    private String nome;     // coluna name
    private String cidade;   // coluna city
    private String bairro;   // coluna region
    private String endereco; // coluna address
    private boolean ativo;   // coluna active

    public Cmei() {
        this.ativo = true;
    }

    public Cmei(String id, String nome, String cidade, String bairro, String endereco) {
        setId(id);
        setNome(nome);
        this.cidade = cidade;
        this.bairro = bairro;
        this.endereco = endereco;
        this.ativo = true;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        if (id == null || id.isBlank()) {
            throw new IllegalArgumentException("Id não pode ser vazio");
        }
        this.id = id.trim();
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if (nome == null || nome.isBlank()) {
            throw new IllegalArgumentException("Nome não pode ser vazio");
        }
        this.nome = nome.trim();
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public boolean isAtivo() {
        return ativo;
    }

    public void setAtivo(boolean ativo) {
        this.ativo = ativo;
    }
}
