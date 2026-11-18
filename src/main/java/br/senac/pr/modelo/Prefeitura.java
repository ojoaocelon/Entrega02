package br.senac.pr.modelo;

// Representa a tabela "Tenant" do banco edufila (prefeitura dona dos CMEIs)
public class Prefeitura {
    private String id;
    private String nome;    // coluna name
    private String cidade;  // coluna city
    private String estado;  // coluna state
    private String slug;    // identificador único usado no endereço do sistema
    private boolean ativo;  // coluna active

    public Prefeitura() {
        this.estado = "PR";
        this.ativo = true;
    }

    public Prefeitura(String id, String nome, String cidade, String slug) {
        this();
        setId(id);
        setNome(nome);
        this.cidade = cidade;
        setSlug(slug);
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

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        if (estado == null || estado.trim().length() != 2) {
            throw new IllegalArgumentException("Estado deve ter 2 letras (UF)");
        }
        this.estado = estado.trim().toUpperCase();
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        if (slug == null || slug.isBlank()) {
            throw new IllegalArgumentException("Slug não pode ser vazio");
        }
        this.slug = slug.trim();
    }

    public boolean isAtivo() {
        return ativo;
    }

    public void setAtivo(boolean ativo) {
        this.ativo = ativo;
    }

    @Override
    public String toString() {
        return nome + " (" + estado + ")";
    }
}
