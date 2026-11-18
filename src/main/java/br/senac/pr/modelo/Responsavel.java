package br.senac.pr.modelo;

// Representa a tabela "Guardian" do banco edufila (responsável pela criança)
public class Responsavel {
    private String id;
    private String nome;      // coluna name
    private String cpf;       // somente os 11 números
    private String telefone;  // coluna phone
    private String email;

    public Responsavel() {
    }

    public Responsavel(String id, String nome, String cpf, String telefone, String email) {
        setId(id);
        setNome(nome);
        setCpf(cpf);
        setTelefone(telefone);
        setEmail(email);
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

    public String getCpf() {
        return cpf;
    }

    // O CPF é opcional; quando informado, guarda só os números
    public void setCpf(String cpf) {
        if (cpf == null || cpf.isBlank()) {
            this.cpf = null;
            return;
        }
        String numeros = cpf.replaceAll("[^0-9]", "");
        if (numeros.length() != 11) {
            throw new IllegalArgumentException("CPF deve ter 11 números");
        }
        this.cpf = numeros;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        if (telefone == null || telefone.isBlank()) {
            throw new IllegalArgumentException("Telefone não pode ser vazio");
        }
        this.telefone = telefone.trim();
    }

    public String getEmail() {
        return email;
    }

    // O e-mail é opcional
    public void setEmail(String email) {
        if (email == null || email.isBlank()) {
            this.email = null;
            return;
        }
        if (!email.contains("@")) {
            throw new IllegalArgumentException("E-mail inválido");
        }
        this.email = email.trim();
    }

    @Override
    public String toString() {
        return nome;
    }
}
