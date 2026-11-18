CREATE TABLE IF NOT EXISTS "Tenant" (
    id          TEXT         NOT NULL,
    name        TEXT         NOT NULL,
    city        TEXT,
    state       CHAR(2)      NOT NULL DEFAULT 'PR',
    slug        TEXT         NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Tenant_pkey"       PRIMARY KEY (id),
    CONSTRAINT "Tenant_slug_key"   UNIQUE (slug),
    CONSTRAINT "Tenant_name_check" CHECK (TRIM(name) <> '')
);

CREATE TABLE IF NOT EXISTS "Cmei" (
    id          TEXT         NOT NULL,
    "tenantId"  TEXT         NOT NULL,
    name        TEXT         NOT NULL,
    city        TEXT         NOT NULL,
    region      TEXT         NOT NULL,   -- bairro
    address     TEXT         NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    "inepCode"  TEXT,
    "zipCode"   TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Cmei_pkey"          PRIMARY KEY (id),
    CONSTRAINT "Cmei_inepCode_key"  UNIQUE ("inepCode"),
    CONSTRAINT "Cmei_name_check"    CHECK (TRIM(name) <> ''),
    CONSTRAINT "Cmei_tenantId_fkey" FOREIGN KEY ("tenantId")
        REFERENCES "Tenant" (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "Capacity" (
    id           TEXT         NOT NULL,
    "tenantId"   TEXT         NOT NULL,
    "cmeiId"     TEXT         NOT NULL,
    infantil     TEXT         NOT NULL,
    "totalSeats" INTEGER      NOT NULL DEFAULT 0,
    "createdAt"  TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt"  TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Capacity_pkey"              PRIMARY KEY (id),
    -- um CMEI só pode ter um registro de vagas por nível
    CONSTRAINT "Capacity_cmeiId_infantil_key" UNIQUE ("cmeiId", infantil),
    CONSTRAINT "Capacity_infantil_check"    CHECK (infantil IN
        ('INFANTIL_0', 'INFANTIL_1', 'INFANTIL_2', 'INFANTIL_3', 'INFANTIL_4', 'INFANTIL_5')),
    CONSTRAINT "Capacity_totalSeats_check"  CHECK ("totalSeats" >= 0),
    CONSTRAINT "Capacity_tenantId_fkey"     FOREIGN KEY ("tenantId")
        REFERENCES "Tenant" (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT "Capacity_cmeiId_fkey"       FOREIGN KEY ("cmeiId")
        REFERENCES "Cmei" (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "Guardian" (
    id          TEXT         NOT NULL,
    "tenantId"  TEXT         NOT NULL,
    name        TEXT         NOT NULL,
    cpf         CHAR(11),
    phone       TEXT         NOT NULL,
    email       TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Guardian_pkey"             PRIMARY KEY (id),
    -- o mesmo CPF não pode ser cadastrado duas vezes na mesma prefeitura
    CONSTRAINT "Guardian_tenantId_cpf_key" UNIQUE ("tenantId", cpf),
    CONSTRAINT "Guardian_cpf_check"        CHECK (cpf ~ '^[0-9]{11}$'),
    CONSTRAINT "Guardian_email_check"      CHECK (email LIKE '%_@_%'),
    CONSTRAINT "Guardian_tenantId_fkey"    FOREIGN KEY ("tenantId")
        REFERENCES "Tenant" (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "Child" (
    id                 TEXT         NOT NULL,
    "tenantId"         TEXT         NOT NULL,
    "fullName"         TEXT         NOT NULL,
    cpf                CHAR(11),
    "birthDate"        DATE         NOT NULL,
    "birthCertificate" TEXT         NOT NULL,   -- nº da certidão de nascimento
    observations       TEXT,
    "guardianId"       TEXT         NOT NULL,
    "createdAt"        TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt"        TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Child_pkey"             PRIMARY KEY (id),
    CONSTRAINT "Child_tenantId_cpf_key" UNIQUE ("tenantId", cpf),
    CONSTRAINT "Child_cpf_check"        CHECK (cpf ~ '^[0-9]{11}$'),
    CONSTRAINT "Child_birthDate_check"  CHECK ("birthDate" <= CURRENT_DATE),
    CONSTRAINT "Child_tenantId_fkey"    FOREIGN KEY ("tenantId")
        REFERENCES "Tenant" (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT "Child_guardianId_fkey"  FOREIGN KEY ("guardianId")
        REFERENCES "Guardian" (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "EnrollmentRequest" (
    id              TEXT         NOT NULL,
    "tenantId"      TEXT         NOT NULL,
    protocol        TEXT         NOT NULL,
    status          TEXT         NOT NULL DEFAULT 'EM_ESPERA',
    infantil        TEXT         NOT NULL,
    "schoolYear"    INTEGER      NOT NULL,
    "priorityScore" INTEGER      NOT NULL DEFAULT 0,
    "childId"       TEXT         NOT NULL,
    "cmeiId"        TEXT         NOT NULL,
    "requestedAt"   TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "enrolledAt"    TIMESTAMP(3),
    "createdAt"     TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt"     TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EnrollmentRequest_pkey"           PRIMARY KEY (id),
    CONSTRAINT "EnrollmentRequest_protocol_key"   UNIQUE (protocol),
    CONSTRAINT "EnrollmentRequest_status_check"   CHECK (status IN
        ('EM_ESPERA', 'CONVOCADO', 'MATRICULADO', 'CANCELADO', 'DESISTENTE', 'NAO_COMPARECEU')),
    CONSTRAINT "EnrollmentRequest_infantil_check" CHECK (infantil IN
        ('INFANTIL_0', 'INFANTIL_1', 'INFANTIL_2', 'INFANTIL_3', 'INFANTIL_4', 'INFANTIL_5')),
    CONSTRAINT "EnrollmentRequest_schoolYear_check"    CHECK ("schoolYear" BETWEEN 2000 AND 2100),
    CONSTRAINT "EnrollmentRequest_priorityScore_check" CHECK ("priorityScore" >= 0),
    CONSTRAINT "EnrollmentRequest_tenantId_fkey"  FOREIGN KEY ("tenantId")
        REFERENCES "Tenant" (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT "EnrollmentRequest_childId_fkey"   FOREIGN KEY ("childId")
        REFERENCES "Child" (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT "EnrollmentRequest_cmeiId_fkey"    FOREIGN KEY ("cmeiId")
        REFERENCES "Cmei" (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS "Cmei_tenantId_active_idx"      ON "Cmei" ("tenantId", active);
CREATE INDEX IF NOT EXISTS "Capacity_tenantId_idx"         ON "Capacity" ("tenantId");
CREATE INDEX IF NOT EXISTS "Child_guardianId_idx"          ON "Child" ("guardianId");
CREATE INDEX IF NOT EXISTS "EnrollmentRequest_childId_idx" ON "EnrollmentRequest" ("childId");
CREATE INDEX IF NOT EXISTS "EnrollmentRequest_cmeiId_idx"  ON "EnrollmentRequest" ("cmeiId");
