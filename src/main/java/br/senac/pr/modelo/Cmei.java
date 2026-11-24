package br.senac.pr.modelo;

public class Cmei {
    private int id;
    private String nome;
    private String cidade;
    private String bairro;
    private String endereco;

    public Cmei() {
    }

    public Cmei(int id, String nome, String cidade, String bairro, String endereco) {
        setId(id);
        setNome(nome);
        setCidade(cidade);
        this.bairro = bairro;
        this.endereco = endereco;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("O id deve ser um número maior que zero");
        }
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if (nome == null || nome.isBlank()) {
            throw new IllegalArgumentException("O nome do CMEI é obrigatório");
        }
        if (nome.length() > 100) {
            throw new IllegalArgumentException("O nome pode ter no máximo 100 caracteres");
        }
        this.nome = nome.trim();
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        if (cidade == null || cidade.isBlank()) {
            throw new IllegalArgumentException("A cidade é obrigatória");
        }
        this.cidade = cidade.trim();
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

    @Override
    public String toString() {
        return id + " - " + nome + " - " + bairro + ", " + cidade + " - " + endereco;
    }
}
