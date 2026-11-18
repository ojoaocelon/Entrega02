package br.senac.pr.modelo;

import java.time.LocalDateTime;

// Representa a tabela "EnrollmentRequest" do banco edufila:
// inscrição de uma criança na fila de espera de um CMEI.
public class Inscricao {
    private String id;
    private String protocolo;             // coluna protocol (único)
    private StatusInscricao status;
    private NivelInfantil nivel;          // coluna infantil
    private int anoLetivo;                // coluna schoolYear
    private int pontuacaoPrioridade;      // coluna priorityScore
    private LocalDateTime dataInscricao;  // coluna requestedAt
    private LocalDateTime dataMatricula;  // coluna enrolledAt
    private Crianca crianca;              // coluna childId (FK para "Child")
    private Cmei cmei;                    // coluna cmeiId (FK para "Cmei")

    public Inscricao() {
        this.status = StatusInscricao.EM_ESPERA;
        this.dataInscricao = LocalDateTime.now();
    }

    public Inscricao(String id, String protocolo, NivelInfantil nivel, int anoLetivo,
            Crianca crianca, Cmei cmei) {
        this();
        setId(id);
        setProtocolo(protocolo);
        setNivel(nivel);
        setAnoLetivo(anoLetivo);
        setCrianca(crianca);
        setCmei(cmei);
    }

    // Marca a inscrição como matriculada e registra a data
    public void matricular() {
        this.status = StatusInscricao.MATRICULADO;
        this.dataMatricula = LocalDateTime.now();
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

    public String getProtocolo() {
        return protocolo;
    }

    public void setProtocolo(String protocolo) {
        if (protocolo == null || protocolo.isBlank()) {
            throw new IllegalArgumentException("Protocolo não pode ser vazio");
        }
        this.protocolo = protocolo.trim();
    }

    public StatusInscricao getStatus() {
        return status;
    }

    public void setStatus(StatusInscricao status) {
        if (status == null) {
            throw new IllegalArgumentException("Status não pode ser vazio");
        }
        this.status = status;
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

    public int getAnoLetivo() {
        return anoLetivo;
    }

    public void setAnoLetivo(int anoLetivo) {
        if (anoLetivo < 2000 || anoLetivo > 2100) {
            throw new IllegalArgumentException("Ano letivo inválido");
        }
        this.anoLetivo = anoLetivo;
    }

    public int getPontuacaoPrioridade() {
        return pontuacaoPrioridade;
    }

    public void setPontuacaoPrioridade(int pontuacaoPrioridade) {
        if (pontuacaoPrioridade < 0) {
            throw new IllegalArgumentException("Pontuação não pode ser negativa");
        }
        this.pontuacaoPrioridade = pontuacaoPrioridade;
    }

    public LocalDateTime getDataInscricao() {
        return dataInscricao;
    }

    public void setDataInscricao(LocalDateTime dataInscricao) {
        this.dataInscricao = dataInscricao;
    }

    public LocalDateTime getDataMatricula() {
        return dataMatricula;
    }

    public void setDataMatricula(LocalDateTime dataMatricula) {
        this.dataMatricula = dataMatricula;
    }

    public Crianca getCrianca() {
        return crianca;
    }

    public void setCrianca(Crianca crianca) {
        if (crianca == null) {
            throw new IllegalArgumentException("A inscrição precisa de uma criança");
        }
        this.crianca = crianca;
    }

    public Cmei getCmei() {
        return cmei;
    }

    public void setCmei(Cmei cmei) {
        if (cmei == null) {
            throw new IllegalArgumentException("A inscrição precisa de um CMEI");
        }
        this.cmei = cmei;
    }

    @Override
    public String toString() {
        return protocolo + " - " + status.getDescricao();
    }
}
