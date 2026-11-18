package br.senac.pr.modelo;

// Níveis da educação infantil (coluna infantil das tabelas "Capacity" e "EnrollmentRequest").
// Os nomes são iguais aos valores gravados no banco.
public enum NivelInfantil {
    INFANTIL_0("Infantil 0"),
    INFANTIL_1("Infantil 1"),
    INFANTIL_2("Infantil 2"),
    INFANTIL_3("Infantil 3"),
    INFANTIL_4("Infantil 4"),
    INFANTIL_5("Infantil 5");

    private final String descricao;

    NivelInfantil(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }
}
