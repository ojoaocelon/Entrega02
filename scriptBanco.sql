-- ============================================================
-- EDUFILA - CRIACAO DO BANCO (SCHEMA) E DADOS PARA SIMULACAO
-- PostgreSQL 13+
-- Execute em um banco ja criado, conectado ao banco edufila.
-- IDs e dados pessoais abaixo sao ficticios, apenas para teste.
-- ============================================================

BEGIN;

-- ============================================================
-- 1. TIPOS ENUMERADOS
-- ============================================================

CREATE TYPE "UserRole" AS ENUM (
    'SUPERADMIN', 'ADMIN', 'SECRETARIA', 'CMEI', 'RESPONSAVEL'
);

CREATE TYPE "EnrollmentStatus" AS ENUM (
    'EM_ESPERA', 'CONVOCADO', 'MATRICULADO', 'CANCELADO',
    'DESISTENTE', 'NAO_COMPARECEU'
);

CREATE TYPE "InfantilLevel" AS ENUM (
    'INFANTIL_0', 'INFANTIL_1', 'INFANTIL_2',
    'INFANTIL_3', 'INFANTIL_4', 'INFANTIL_5'
);

CREATE TYPE "RuleType" AS ENUM ('ADDRESS', 'AGE');
CREATE TYPE "NotificationChannel" AS ENUM ('EMAIL', 'SMS', 'WHATSAPP');
CREATE TYPE "NotificationStatus" AS ENUM ('PENDING', 'SENT', 'FAILED', 'SIMULATED');
CREATE TYPE "PreEnrollmentStatus" AS ENUM ('PENDENTE', 'APROVADO', 'REJEITADO');
CREATE TYPE "GuardianRelationship" AS ENUM ('MAE', 'PAI', 'RESPONSAVEL_LEGAL');
CREATE TYPE "ConvocationResponse" AS ENUM ('CONFIRMADO', 'DESISTIU');

-- ============================================================
-- 2. TABELAS
-- ============================================================

CREATE TABLE "Tenant" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "city" TEXT,
    "state" TEXT NOT NULL DEFAULT 'PR',
    "slug" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT TRUE,
    "logoUrl" TEXT,
    "primaryColor" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Tenant_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Cmei" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT TRUE,
    "inepCode" TEXT,
    "zipCode" TEXT,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "offeredLevels" "InfantilLevel"[] NOT NULL DEFAULT ARRAY[
        'INFANTIL_0', 'INFANTIL_1', 'INFANTIL_2',
        'INFANTIL_3', 'INFANTIL_4', 'INFANTIL_5'
    ]::"InfantilLevel"[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Cmei_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "Cmei_offeredLevels_non_empty" CHECK (cardinality("offeredLevels") > 0)
);

CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT TRUE,
    "tenantId" TEXT,
    "cmeiId" TEXT,
    "mustChangePassword" BOOLEAN NOT NULL DEFAULT FALSE,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Address" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "street" TEXT NOT NULL,
    "neighborhood" TEXT NOT NULL,
    "fullAddress" TEXT NOT NULL,
    "number" TEXT,
    "complement" TEXT,
    "city" TEXT NOT NULL,
    "zipCode" TEXT,
    "proofOfResidenceUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Guardian" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "cpf" TEXT,
    "phone" TEXT NOT NULL,
    "email" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Guardian_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Child" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "cpf" TEXT,
    "birthDate" TIMESTAMP(3) NOT NULL,
    "birthCertificate" TEXT NOT NULL,
    "observations" TEXT,
    "guardianId" TEXT NOT NULL,
    "addressId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Child_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "EnrollmentRequest" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "protocol" TEXT NOT NULL,
    "status" "EnrollmentStatus" NOT NULL DEFAULT 'EM_ESPERA',
    "infantil" "InfantilLevel" NOT NULL,
    "childId" TEXT NOT NULL,
    "cmeiId" TEXT NOT NULL,
    "requestedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "enrolledAt" TIMESTAMP(3),
    "convokedAt" TIMESTAMP(3),
    "canceledAt" TIMESTAMP(3),
    "priorityKeys" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "priorityScore" INTEGER NOT NULL DEFAULT 0,
    "convocationDeadline" TIMESTAMP(3),
    "overrideReason" TEXT,
    "schoolYear" INTEGER NOT NULL,
    "statusReason" TEXT,
    "convocationRespondedAt" TIMESTAMP(3),
    "convocationResponse" "ConvocationResponse",
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "EnrollmentRequest_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PriorityCriterion" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "weight" INTEGER NOT NULL DEFAULT 0,
    "active" BOOLEAN NOT NULL DEFAULT TRUE,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "PriorityCriterion_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Capacity" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "cmeiId" TEXT NOT NULL,
    "infantil" "InfantilLevel" NOT NULL,
    "totalSeats" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Capacity_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "QueueRule" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "type" "RuleType" NOT NULL,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "active" BOOLEAN NOT NULL DEFAULT TRUE,
    "matchKeywords" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "zipCodes" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "street" TEXT,
    "numberMin" INTEGER,
    "numberMax" INTEGER,
    "cmeiId" TEXT,
    "minAgeMonths" INTEGER,
    "maxAgeMonths" INTEGER,
    "infantil" "InfantilLevel",
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "QueueRule_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "AuditLog" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT,
    "metadata" JSONB,
    "userId" TEXT,
    "ip" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Setting" (
    "tenantId" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Setting_pkey" PRIMARY KEY ("tenantId", "key")
);

CREATE TABLE "Notification" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "channel" "NotificationChannel" NOT NULL,
    "recipient" TEXT NOT NULL,
    "subject" TEXT,
    "body" TEXT NOT NULL,
    "status" "NotificationStatus" NOT NULL DEFAULT 'PENDING',
    "error" TEXT,
    "enrollmentRequestId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sentAt" TIMESTAMP(3),
    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PasswordResetToken" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "usedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "PasswordResetToken_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "PreEnrollment" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "protocol" TEXT NOT NULL,
    "status" "PreEnrollmentStatus" NOT NULL DEFAULT 'PENDENTE',
    "childName" TEXT NOT NULL,
    "childCpf" TEXT NOT NULL,
    "childBirthDate" TIMESTAMP(3) NOT NULL,
    "birthCertificate" TEXT NOT NULL,
    "observations" TEXT,
    "guardianName" TEXT NOT NULL,
    "guardianCpf" TEXT NOT NULL,
    "guardianBirthDate" TIMESTAMP(3) NOT NULL,
    "guardianPhone" TEXT NOT NULL,
    "guardianEmail" TEXT NOT NULL,
    "relationship" "GuardianRelationship" NOT NULL,
    "street" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "complement" TEXT,
    "neighborhood" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "zipCode" TEXT NOT NULL,
    "birthCertificateUrl" TEXT NOT NULL,
    "guardianIdUrl" TEXT NOT NULL,
    "proofOfResidenceUrl" TEXT NOT NULL,
    "custodyDocumentUrl" TEXT,
    "priorityDocumentUrl" TEXT,
    "priorityKeys" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "flags" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "consentAcceptedAt" TIMESTAMP(3) NOT NULL,
    "submittedIp" TEXT,
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reviewedAt" TIMESTAMP(3),
    "reviewedById" TEXT,
    "reviewNote" TEXT,
    "enrollmentRequestId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "PreEnrollment_pkey" PRIMARY KEY ("id")
);

-- ============================================================
-- 3. INDICES
-- ============================================================

CREATE UNIQUE INDEX "Tenant_slug_key" ON "Tenant" ("slug");
CREATE INDEX "Tenant_active_idx" ON "Tenant" ("active");
CREATE UNIQUE INDEX "User_email_key" ON "User" ("email");
CREATE INDEX "User_role_idx" ON "User" ("role");
CREATE INDEX "User_tenantId_idx" ON "User" ("tenantId");
CREATE UNIQUE INDEX "Cmei_inepCode_key" ON "Cmei" ("inepCode");
CREATE INDEX "Cmei_tenantId_active_idx" ON "Cmei" ("tenantId", "active");
CREATE UNIQUE INDEX "Guardian_tenantId_cpf_key" ON "Guardian" ("tenantId", "cpf");
CREATE UNIQUE INDEX "Child_addressId_key" ON "Child" ("addressId");
CREATE INDEX "Child_cpf_idx" ON "Child" ("cpf");
CREATE UNIQUE INDEX "Child_tenantId_cpf_key" ON "Child" ("tenantId", "cpf");
CREATE UNIQUE INDEX "EnrollmentRequest_protocol_key" ON "EnrollmentRequest" ("protocol");
CREATE INDEX "EnrollmentRequest_tenantId_cmeiId_infantil_status_priorityS_idx"
    ON "EnrollmentRequest" ("tenantId", "cmeiId", "infantil", "status", "priorityScore", "requestedAt");
CREATE INDEX "EnrollmentRequest_requestedAt_idx" ON "EnrollmentRequest" ("requestedAt");
CREATE INDEX "EnrollmentRequest_childId_idx" ON "EnrollmentRequest" ("childId");
CREATE INDEX "PriorityCriterion_tenantId_active_idx" ON "PriorityCriterion" ("tenantId", "active");
CREATE UNIQUE INDEX "PriorityCriterion_tenantId_key_key" ON "PriorityCriterion" ("tenantId", "key");
CREATE INDEX "Capacity_tenantId_idx" ON "Capacity" ("tenantId");
CREATE UNIQUE INDEX "Capacity_cmeiId_infantil_key" ON "Capacity" ("cmeiId", "infantil");
CREATE INDEX "QueueRule_tenantId_type_active_priority_idx"
    ON "QueueRule" ("tenantId", "type", "active", "priority");
CREATE INDEX "AuditLog_entity_idx" ON "AuditLog" ("entity");
CREATE INDEX "AuditLog_userId_idx" ON "AuditLog" ("userId");
CREATE INDEX "AuditLog_tenantId_createdAt_idx" ON "AuditLog" ("tenantId", "createdAt");
CREATE INDEX "Notification_enrollmentRequestId_idx" ON "Notification" ("enrollmentRequestId");
CREATE INDEX "Notification_tenantId_status_idx" ON "Notification" ("tenantId", "status");
CREATE UNIQUE INDEX "PasswordResetToken_token_key" ON "PasswordResetToken" ("token");
CREATE INDEX "PasswordResetToken_userId_idx" ON "PasswordResetToken" ("userId");
CREATE UNIQUE INDEX "PreEnrollment_protocol_key" ON "PreEnrollment" ("protocol");
CREATE UNIQUE INDEX "PreEnrollment_enrollmentRequestId_key" ON "PreEnrollment" ("enrollmentRequestId");
CREATE INDEX "PreEnrollment_tenantId_status_submittedAt_idx"
    ON "PreEnrollment" ("tenantId", "status", "submittedAt");
CREATE INDEX "PreEnrollment_tenantId_childCpf_status_idx"
    ON "PreEnrollment" ("tenantId", "childCpf", "status");
CREATE INDEX "PreEnrollment_tenantId_guardianCpf_idx"
    ON "PreEnrollment" ("tenantId", "guardianCpf");

-- ============================================================
-- 4. CHAVES ESTRANGEIRAS
-- ============================================================

ALTER TABLE "User"
    ADD CONSTRAINT "User_cmeiId_fkey"
    FOREIGN KEY ("cmeiId") REFERENCES "Cmei" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "Child"
    ADD CONSTRAINT "Child_guardianId_fkey"
    FOREIGN KEY ("guardianId") REFERENCES "Guardian" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Child"
    ADD CONSTRAINT "Child_addressId_fkey"
    FOREIGN KEY ("addressId") REFERENCES "Address" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "EnrollmentRequest"
    ADD CONSTRAINT "EnrollmentRequest_childId_fkey"
    FOREIGN KEY ("childId") REFERENCES "Child" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "EnrollmentRequest"
    ADD CONSTRAINT "EnrollmentRequest_cmeiId_fkey"
    FOREIGN KEY ("cmeiId") REFERENCES "Cmei" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Capacity"
    ADD CONSTRAINT "Capacity_cmeiId_fkey"
    FOREIGN KEY ("cmeiId") REFERENCES "Cmei" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "QueueRule"
    ADD CONSTRAINT "QueueRule_cmeiId_fkey"
    FOREIGN KEY ("cmeiId") REFERENCES "Cmei" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "AuditLog"
    ADD CONSTRAINT "AuditLog_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "PasswordResetToken"
    ADD CONSTRAINT "PasswordResetToken_userId_fkey"
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;