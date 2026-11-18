package br.senac.pr.modelo;

import java.time.LocalDate;
import java.time.Period;

// Representa a tabela "Child" do banco edufila (criança que aguarda vaga)
public class Crianca {
    private String id;
    private String nomeCompleto;        // coluna fullName
    private String cpf;                 // somente os 11 números
    private LocalDate dataNascimento;   // coluna birthDate
    private String certidaoNascimento;  // coluna birthCertificate
    private String observacoes;         // coluna observations
    private Responsavel responsavel;    // coluna guardianId (FK para "Guardian")

    public Crianca() {
    }

    public Crianca(String id, String nomeCompleto, LocalDate dataNascimento,
            String certidaoNascimento, Responsavel responsavel) {
        setId(id);
        setNomeCompleto(nomeCompleto);
        setDataNascimento(dataNascimento);
        setCertidaoNascimento(certidaoNascimento);
        setResponsavel(responsavel);
    }

    // Idade em anos completos na data de hoje
    public int getIdade() {
        return Period.between(dataNascimento, LocalDate.now()).getYears();
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

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public void setNomeCompleto(String nomeCompleto) {
        if (nomeCompleto == null || nomeCompleto.isBlank()) {
            throw new IllegalArgumentException("Nome não pode ser vazio");
        }
        this.nomeCompleto = nomeCompleto.trim();
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

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        if (dataNascimento == null) {
            throw new IllegalArgumentException("Data de nascimento não pode ser vazia");
        }
        if (dataNascimento.isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("Data de nascimento não pode ser no futuro");
        }
        this.dataNascimento = dataNascimento;
    }

    public String getCertidaoNascimento() {
        return certidaoNascimento;
    }

    public void setCertidaoNascimento(String certidaoNascimento) {
        if (certidaoNascimento == null || certidaoNascimento.isBlank()) {
            throw new IllegalArgumentException("Certidão de nascimento não pode ser vazia");
        }
        this.certidaoNascimento = certidaoNascimento.trim();
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public Responsavel getResponsavel() {
        return responsavel;
    }

    public void setResponsavel(Responsavel responsavel) {
        if (responsavel == null) {
            throw new IllegalArgumentException("A criança precisa ter um responsável");
        }
        this.responsavel = responsavel;
    }

    @Override
    public String toString() {
        return nomeCompleto;
    }
}
