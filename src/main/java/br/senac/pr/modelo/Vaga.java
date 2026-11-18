package br.senac.pr.modelo;

// Representa a tabela "Capacity" do banco edufila:
// quantidade de vagas que um CMEI oferece em um nível.
public class Vaga {
    private String id;
    private Cmei cmei;            // coluna cmeiId (FK para "Cmei")
    private NivelInfantil nivel;  // coluna infantil
    private int totalVagas;       // coluna totalSeats

    public Vaga() {
    }

    public Vaga(String id, Cmei cmei, NivelInfantil nivel, int totalVagas) {
        setId(id);
        setCmei(cmei);
        setNivel(nivel);
        setTotalVagas(totalVagas);
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

    public Cmei getCmei() {
        return cmei;
    }

    public void setCmei(Cmei cmei) {
        if (cmei == null) {
            throw new IllegalArgumentException("A vaga precisa pertencer a um CMEI");
        }
        this.cmei = cmei;
    }

    public NivelInfantil getNivel() {
        return nivel;
    }

    public void setNivel(NivelInfantil nivel) {
        if (nivel == null) {
            throw new IllegalArgumentException("Nível não pode ser vazio");
        }
        this.nivel = nivel;
    }

    public int getTotalVagas() {
        return totalVagas;
    }

    public void setTotalVagas(int totalVagas) {
        if (totalVagas < 0) {
            throw new IllegalArgumentException("Total de vagas não pode ser negativo");
        }
        this.totalVagas = totalVagas;
    }

    @Override
    public String toString() {
        return nivel.getDescricao() + ": " + totalVagas + " vagas";
    }
}
