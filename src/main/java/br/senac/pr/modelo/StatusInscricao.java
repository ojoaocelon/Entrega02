package br.senac.pr.modelo;

// Situação da inscrição na fila (coluna status da tabela "EnrollmentRequest").
// Os nomes são iguais aos valores gravados no banco.
public enum StatusInscricao {
    EM_ESPERA("Em espera"),
    CONVOCADO("Convocado"),
    MATRICULADO("Matriculado"),
    CANCELADO("Cancelado"),
    DESISTENTE("Desistente"),
    NAO_COMPARECEU("Não compareceu");

    private final String descricao;

    StatusInscricao(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }
}
