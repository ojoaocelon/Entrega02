package br.senac.pr.modelo;

public class Vaga {
    private int id;
    private Cmei cmei;
    private String nivel;
    private int quantidade;

    public Vaga() {
    }

    public Vaga(int id, Cmei cmei, String nivel, int quantidade) {
        this.id = id;
        this.cmei = cmei;
        this.nivel = nivel;
        setQuantidade(quantidade);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Cmei getCmei() {
        return cmei;
    }

    public void setCmei(Cmei cmei) {
        this.cmei = cmei;
    }

    public String getNivel() {
        return nivel;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        if (quantidade < 0) {
            throw new IllegalArgumentException("A quantidade de vagas não pode ser negativa");
        }
        this.quantidade = quantidade;
    }
}
