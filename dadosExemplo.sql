-- INSERTS DE SIMULAÇÃO --

-- Tenant
INSERT INTO "Tenant" ("id", "name", "city", "state", "slug", "active", "primaryColor", "createdAt", "updatedAt") VALUES
('ten-001', 'Secretaria Municipal de Educacao', 'Santa Tereza do Oeste', 'PR', 'santa-tereza-oeste', TRUE, '#2457A7', NOW(), NOW());

-- CMEIs
INSERT INTO "Cmei" ("id", "tenantId", "name", "city", "region", "address", "active", "inepCode", "zipCode", "latitude", "longitude", "offeredLevels", "createdAt", "updatedAt") VALUES
('cmei-001', 'ten-001', 'CMEI Pequeno Principe', 'Santa Tereza do Oeste', 'Centro', 'Rua das Flores, 120', TRUE, '41000001', '85825-000', -25.0541, -53.6270, ARRAY['INFANTIL_0','INFANTIL_1','INFANTIL_2','INFANTIL_3','INFANTIL_4','INFANTIL_5']::"InfantilLevel"[], NOW(), NOW()),
('cmei-002', 'ten-001', 'CMEI Sementinha', 'Santa Tereza do Oeste', 'Jardim Primavera', 'Rua Primavera, 450', TRUE, '41000002', '85825-000', -25.0502, -53.6211, ARRAY['INFANTIL_0','INFANTIL_1','INFANTIL_2','INFANTIL_3','INFANTIL_4']::"InfantilLevel"[], NOW(), NOW()),
('cmei-003', 'ten-001', 'CMEI Mundo Feliz', 'Santa Tereza do Oeste', 'Vila Nova', 'Avenida Brasil, 800', TRUE, '41000003', '85825-000', -25.0600, -53.6330, ARRAY['INFANTIL_1','INFANTIL_2','INFANTIL_3','INFANTIL_4','INFANTIL_5']::"InfantilLevel"[], NOW(), NOW());

-- Usuarios (hashes ilustrativos; nao utilizar como credenciais reais)
INSERT INTO "User" ("id", "name", "email", "passwordHash", "role", "active", "tenantId", "cmeiId", "mustChangePassword", "createdAt", "updatedAt") VALUES
('usr-001', 'Administrador Geral', 'admin@edufila.test', 'HASH_FICTICIO_ADMIN', 'SUPERADMIN', TRUE, 'ten-001', NULL, TRUE, NOW(), NOW()),
('usr-002', 'Maria Secretaria', 'secretaria@edufila.test', 'HASH_FICTICIO_SECRETARIA', 'SECRETARIA', TRUE, 'ten-001', NULL, TRUE, NOW(), NOW()),
('usr-003', 'Ana Coordenadora', 'cmei1@edufila.test', 'HASH_FICTICIO_CMEI', 'CMEI', TRUE, 'ten-001', 'cmei-001', TRUE, NOW(), NOW()),
('usr-004', 'Paulo Coordenador', 'cmei2@edufila.test', 'HASH_FICTICIO_CMEI', 'CMEI', TRUE, 'ten-001', 'cmei-002', TRUE, NOW(), NOW()),
('usr-005', 'Responsavel de Teste', 'responsavel@edufila.test', 'HASH_FICTICIO_RESPONSAVEL', 'RESPONSAVEL', TRUE, 'ten-001', NULL, TRUE, NOW(), NOW());

-- Enderecos
INSERT INTO "Address" ("id", "tenantId", "street", "neighborhood", "fullAddress", "number", "complement", "city", "zipCode", "proofOfResidenceUrl", "createdAt", "updatedAt") VALUES
('addr-001', 'ten-001', 'Rua das Acacias', 'Centro', 'Rua das Acacias, 101 - Centro', '101', 'Casa', 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-002', 'ten-001', 'Rua das Palmeiras', 'Jardim Primavera', 'Rua das Palmeiras, 202 - Jardim Primavera', '202', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-003', 'ten-001', 'Avenida Brasil', 'Vila Nova', 'Avenida Brasil, 303 - Vila Nova', '303', 'Apto 02', 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-004', 'ten-001', 'Rua Parana', 'Centro', 'Rua Parana, 404 - Centro', '404', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-005', 'ten-001', 'Rua das Flores', 'Jardim Europa', 'Rua das Flores, 505 - Jardim Europa', '505', 'Casa fundos', 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-006', 'ten-001', 'Rua Pioneiros', 'Vila Nova', 'Rua Pioneiros, 606 - Vila Nova', '606', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-007', 'ten-001', 'Rua Curitiba', 'Centro', 'Rua Curitiba, 707 - Centro', '707', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-008', 'ten-001', 'Rua Cascavel', 'Jardim Primavera', 'Rua Cascavel, 808 - Jardim Primavera', '808', 'Casa 1', 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-009', 'ten-001', 'Rua Brasilia', 'Vila Nova', 'Rua Brasilia, 909 - Vila Nova', '909', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-010', 'ten-001', 'Rua Toledo', 'Centro', 'Rua Toledo, 110 - Centro', '110', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-011', 'ten-001', 'Rua Guarani', 'Jardim Europa', 'Rua Guarani, 211 - Jardim Europa', '211', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-012', 'ten-001', 'Rua Ipe', 'Vila Nova', 'Rua Ipe, 312 - Vila Nova', '312', 'Fundos', 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-013', 'ten-001', 'Rua Jequitiba', 'Centro', 'Rua Jequitiba, 413 - Centro', '413', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-014', 'ten-001', 'Rua Cedro', 'Jardim Primavera', 'Rua Cedro, 514 - Jardim Primavera', '514', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW()),
('addr-015', 'ten-001', 'Rua Araucaria', 'Jardim Europa', 'Rua Araucaria, 615 - Jardim Europa', '615', NULL, 'Santa Tereza do Oeste', '85825-000', NULL, NOW(), NOW());

-- Responsaveis
INSERT INTO "Guardian" ("id", "tenantId", "name", "cpf", "phone", "email", "createdAt", "updatedAt") VALUES
('gua-001', 'ten-001', 'Carla Mendes', '90000000001', '(45) 99900-0001', 'carla.mendes@test.com', NOW(), NOW()),
('gua-002', 'ten-001', 'Roberto Almeida', '90000000002', '(45) 99900-0002', 'roberto.almeida@test.com', NOW(), NOW()),
('gua-003', 'ten-001', 'Juliana Ferreira', '90000000003', '(45) 99900-0003', 'juliana.ferreira@test.com', NOW(), NOW()),
('gua-004', 'ten-001', 'Marcos Oliveira', '90000000004', '(45) 99900-0004', 'marcos.oliveira@test.com', NOW(), NOW()),
('gua-005', 'ten-001', 'Fernanda Costa', '90000000005', '(45) 99900-0005', 'fernanda.costa@test.com', NOW(), NOW()),
('gua-006', 'ten-001', 'Patricia Santos', '90000000006', '(45) 99900-0006', 'patricia.santos@test.com', NOW(), NOW()),
('gua-007', 'ten-001', 'Ricardo Lima', '90000000007', '(45) 99900-0007', 'ricardo.lima@test.com', NOW(), NOW()),
('gua-008', 'ten-001', 'Camila Ribeiro', '90000000008', '(45) 99900-0008', 'camila.ribeiro@test.com', NOW(), NOW()),
('gua-009', 'ten-001', 'Eduardo Gomes', '90000000009', '(45) 99900-0009', 'eduardo.gomes@test.com', NOW(), NOW()),
('gua-010', 'ten-001', 'Aline Martins', '90000000010', '(45) 99900-0010', 'aline.martins@test.com', NOW(), NOW()),
('gua-011', 'ten-001', 'Bruno Carvalho', '90000000011', '(45) 99900-0011', 'bruno.carvalho@test.com', NOW(), NOW()),
('gua-012', 'ten-001', 'Vanessa Rocha', '90000000012', '(45) 99900-0012', 'vanessa.rocha@test.com', NOW(), NOW()),
('gua-013', 'ten-001', 'Diego Pereira', '90000000013', '(45) 99900-0013', 'diego.pereira@test.com', NOW(), NOW()),
('gua-014', 'ten-001', 'Leticia Araujo', '90000000014', '(45) 99900-0014', 'leticia.araujo@test.com', NOW(), NOW()),
('gua-015', 'ten-001', 'Felipe Barbosa', '90000000015', '(45) 99900-0015', 'felipe.barbosa@test.com', NOW(), NOW());

-- Criancas
INSERT INTO "Child" ("id", "tenantId", "fullName", "cpf", "birthDate", "birthCertificate", "observations", "guardianId", "addressId", "createdAt", "updatedAt") VALUES
('chi-001', 'ten-001', 'Lucas Mendes', '80000000001', '2023-02-14', 'CERT-2023-0001', 'Sem observacoes', 'gua-001', 'addr-001', NOW(), NOW()),
('chi-002', 'ten-001', 'Sofia Almeida', '80000000002', '2022-07-21', 'CERT-2022-0002', NULL, 'gua-002', 'addr-002', NOW(), NOW()),
('chi-003', 'ten-001', 'Miguel Ferreira', '80000000003', '2021-11-03', 'CERT-2021-0003', 'Alergia alimentar informada', 'gua-003', 'addr-003', NOW(), NOW()),
('chi-004', 'ten-001', 'Helena Oliveira', '80000000004', '2020-05-18', 'CERT-2020-0004', NULL, 'gua-004', 'addr-004', NOW(), NOW()),
('chi-005', 'ten-001', 'Arthur Costa', '80000000005', '2019-09-09', 'CERT-2019-0005', NULL, 'gua-005', 'addr-005', NOW(), NOW()),
('chi-006', 'ten-001', 'Alice Santos', '80000000006', '2023-04-27', 'CERT-2023-0006', NULL, 'gua-006', 'addr-006', NOW(), NOW()),
('chi-007', 'ten-001', 'Bernardo Lima', '80000000007', '2022-01-12', 'CERT-2022-0007', 'Necessita acompanhamento', 'gua-007', 'addr-007', NOW(), NOW()),
('chi-008', 'ten-001', 'Laura Ribeiro', '80000000008', '2021-08-30', 'CERT-2021-0008', NULL, 'gua-008', 'addr-008', NOW(), NOW()),
('chi-009', 'ten-001', 'Heitor Gomes', '80000000009', '2020-12-05', 'CERT-2020-0009', NULL, 'gua-009', 'addr-009', NOW(), NOW()),
('chi-010', 'ten-001', 'Manuela Martins', '80000000010', '2019-03-16', 'CERT-2019-0010', NULL, 'gua-010', 'addr-010', NOW(), NOW()),
('chi-011', 'ten-001', 'Davi Carvalho', '80000000011', '2023-06-08', 'CERT-2023-0011', NULL, 'gua-011', 'addr-011', NOW(), NOW()),
('chi-012', 'ten-001', 'Valentina Rocha', '80000000012', '2022-10-24', 'CERT-2022-0012', NULL, 'gua-012', 'addr-012', NOW(), NOW()),
('chi-013', 'ten-001', 'Enzo Pereira', '80000000013', '2021-03-11', 'CERT-2021-0013', NULL, 'gua-013', 'addr-013', NOW(), NOW()),
('chi-014', 'ten-001', 'Isabella Araujo', '80000000014', '2020-07-02', 'CERT-2020-0014', NULL, 'gua-014', 'addr-014', NOW(), NOW()),
('chi-015', 'ten-001', 'Theo Barbosa', '80000000015', '2019-11-19', 'CERT-2019-0015', NULL, 'gua-015', 'addr-015', NOW(), NOW());

-- Criterios de prioridade
INSERT INTO "PriorityCriterion" ("id", "tenantId", "key", "label", "weight", "active", "description", "createdAt", "updatedAt") VALUES
('pri-001', 'ten-001', 'SOCIAL_VULNERABILITY', 'Vulnerabilidade social', 100, TRUE, 'Familia em situacao de vulnerabilidade social', NOW(), NOW()),
('pri-002', 'ten-001', 'SINGLE_PARENT', 'Responsavel unico', 60, TRUE, 'Crianca sob responsabilidade de apenas um responsavel', NOW(), NOW()),
('pri-003', 'ten-001', 'SIBLING', 'Irmao matriculado', 40, TRUE, 'Possui irmao matriculado na unidade', NOW(), NOW()),
('pri-004', 'ten-001', 'WORKING_GUARDIAN', 'Responsavel trabalhador', 30, TRUE, 'Responsavel comprova atividade profissional', NOW(), NOW());

-- Capacidade por CMEI e nivel
INSERT INTO "Capacity" ("id", "tenantId", "cmeiId", "infantil", "totalSeats", "createdAt", "updatedAt") VALUES
('cap-001', 'ten-001', 'cmei-001', 'INFANTIL_0', 12, NOW(), NOW()),
('cap-002', 'ten-001', 'cmei-001', 'INFANTIL_1', 18, NOW(), NOW()),
('cap-003', 'ten-001', 'cmei-001', 'INFANTIL_2', 20, NOW(), NOW()),
('cap-004', 'ten-001', 'cmei-001', 'INFANTIL_3', 22, NOW(), NOW()),
('cap-005', 'ten-001', 'cmei-001', 'INFANTIL_4', 24, NOW(), NOW()),
('cap-006', 'ten-001', 'cmei-001', 'INFANTIL_5', 25, NOW(), NOW()),
('cap-007', 'ten-001', 'cmei-002', 'INFANTIL_0', 10, NOW(), NOW()),
('cap-008', 'ten-001', 'cmei-002', 'INFANTIL_1', 15, NOW(), NOW()),
('cap-009', 'ten-001', 'cmei-002', 'INFANTIL_2', 18, NOW(), NOW()),
('cap-010', 'ten-001', 'cmei-002', 'INFANTIL_3', 20, NOW(), NOW()),
('cap-011', 'ten-001', 'cmei-002', 'INFANTIL_4', 22, NOW(), NOW()),
('cap-012', 'ten-001', 'cmei-003', 'INFANTIL_1', 14, NOW(), NOW()),
('cap-013', 'ten-001', 'cmei-003', 'INFANTIL_2', 18, NOW(), NOW()),
('cap-014', 'ten-001', 'cmei-003', 'INFANTIL_3', 20, NOW(), NOW()),
('cap-015', 'ten-001', 'cmei-003', 'INFANTIL_4', 22, NOW(), NOW()),
('cap-016', 'ten-001', 'cmei-003', 'INFANTIL_5', 24, NOW(), NOW());

-- Regras de fila
INSERT INTO "QueueRule" ("id", "tenantId", "type", "priority", "active", "matchKeywords", "zipCodes", "street", "numberMin", "numberMax", "cmeiId", "minAgeMonths", "maxAgeMonths", "infantil", "description", "createdAt", "updatedAt") VALUES
('rule-001', 'ten-001', 'ADDRESS', 1, TRUE, ARRAY['Centro','Rua das Acacias'], ARRAY['85825-000'], NULL, NULL, NULL, 'cmei-001', NULL, NULL, NULL, 'Prioridade para residentes da regiao central', NOW(), NOW()),
('rule-002', 'ten-001', 'AGE', 2, TRUE, ARRAY[]::TEXT[], ARRAY[]::TEXT[], NULL, NULL, NULL, 'cmei-002', 0, 24, 'INFANTIL_1', 'Faixa etaria de 0 a 24 meses', NOW(), NOW()),
('rule-003', 'ten-001', 'ADDRESS', 3, TRUE, ARRAY['Jardim Primavera'], ARRAY['85825-000'], 'Rua das Palmeiras', 1, 999, 'cmei-002', NULL, NULL, NULL, 'Regra territorial do Jardim Primavera', NOW(), NOW());

-- Solicitacoes de matricula
INSERT INTO "EnrollmentRequest" ("id", "tenantId", "protocol", "status", "infantil", "childId", "cmeiId", "requestedAt", "enrolledAt", "convokedAt", "canceledAt", "priorityKeys", "priorityScore", "convocationDeadline", "overrideReason", "schoolYear", "statusReason", "convocationRespondedAt", "convocationResponse", "createdAt", "updatedAt") VALUES
('enr-001', 'ten-001', '2026-000001', 'EM_ESPERA', 'INFANTIL_1', 'chi-001', 'cmei-001', NOW() - INTERVAL '20 days', NULL, NULL, NULL, ARRAY['WORKING_GUARDIAN'], 30, NULL, NULL, 2027, NULL, NULL, NULL, NOW(), NOW()),
('enr-002', 'ten-001', '2026-000002', 'CONVOCADO', 'INFANTIL_2', 'chi-002', 'cmei-001', NOW() - INTERVAL '18 days', NULL, NOW() - INTERVAL '2 days', NULL, ARRAY['SIBLING'], 40, NOW() + INTERVAL '5 days', NULL, 2027, 'Aguardando resposta da familia', NULL, NULL, NOW(), NOW()),
('enr-003', 'ten-001', '2026-000003', 'MATRICULADO', 'INFANTIL_3', 'chi-003', 'cmei-002', NOW() - INTERVAL '40 days', NOW() - INTERVAL '10 days', NOW() - INTERVAL '15 days', NULL, ARRAY['SOCIAL_VULNERABILITY'], 100, NULL, NULL, 2027, NULL, NOW() - INTERVAL '12 days', 'CONFIRMADO', NOW(), NOW()),
('enr-004', 'ten-001', '2026-000004', 'EM_ESPERA', 'INFANTIL_4', 'chi-004', 'cmei-003', NOW() - INTERVAL '12 days', NULL, NULL, NULL, ARRAY[]::TEXT[], 0, NULL, NULL, 2027, NULL, NULL, NULL, NOW(), NOW()),
('enr-005', 'ten-001', '2026-000005', 'DESISTENTE', 'INFANTIL_5', 'chi-005', 'cmei-001', NOW() - INTERVAL '35 days', NULL, NOW() - INTERVAL '20 days', NULL, ARRAY['SINGLE_PARENT'], 60, NULL, NULL, 2027, 'Familia informou desistencia', NOW() - INTERVAL '19 days', 'DESISTIU', NOW(), NOW()),
('enr-006', 'ten-001', '2026-000006', 'EM_ESPERA', 'INFANTIL_0', 'chi-006', 'cmei-002', NOW() - INTERVAL '8 days', NULL, NULL, NULL, ARRAY['WORKING_GUARDIAN'], 30, NULL, NULL, 2027, NULL, NULL, NULL, NOW(), NOW()),
('enr-007', 'ten-001', '2026-000007', 'NAO_COMPARECEU', 'INFANTIL_1', 'chi-007', 'cmei-003', NOW() - INTERVAL '28 days', NULL, NOW() - INTERVAL '8 days', NULL, ARRAY['SIBLING','WORKING_GUARDIAN'], 70, NULL, NULL, 2027, 'Nao compareceu no prazo', NOW() - INTERVAL '7 days', NULL, NOW(), NOW()),
('enr-008', 'ten-001', '2026-000008', 'EM_ESPERA', 'INFANTIL_2', 'chi-008', 'cmei-001', NOW() - INTERVAL '6 days', NULL, NULL, NULL, ARRAY[]::TEXT[], 0, NULL, NULL, 2027, NULL, NULL, NULL, NOW(), NOW()),
('enr-009', 'ten-001', '2026-000009', 'CONVOCADO', 'INFANTIL_3', 'chi-009', 'cmei-002', NOW() - INTERVAL '15 days', NULL, NOW() - INTERVAL '1 day', NULL, ARRAY['SOCIAL_VULNERABILITY','SINGLE_PARENT'], 160, NOW() + INTERVAL '4 days', NULL, 2027, NULL, NULL, NULL, NOW(), NOW()),
('enr-010', 'ten-001', '2026-000010', 'CANCELADO', 'INFANTIL_4', 'chi-010', 'cmei-003', NOW() - INTERVAL '50 days', NULL, NULL, NOW() - INTERVAL '30 days', ARRAY[]::TEXT[], 0, NULL, NULL, 2027, 'Solicitacao cancelada pela familia', NULL, NULL, NOW(), NOW()),
('enr-011', 'ten-001', '2026-000011', 'EM_ESPERA', 'INFANTIL_0', 'chi-011', 'cmei-001', NOW() - INTERVAL '4 days', NULL, NULL, NULL, ARRAY['WORKING_GUARDIAN'], 30, NULL, NULL, 2027, NULL, NULL, NULL, NOW(), NOW()),
('enr-012', 'ten-001', '2026-000012', 'MATRICULADO', 'INFANTIL_2', 'chi-012', 'cmei-002', NOW() - INTERVAL '60 days', NOW() - INTERVAL '25 days', NOW() - INTERVAL '30 days', NULL, ARRAY['SINGLE_PARENT','SIBLING'], 100, NULL, NULL, 2027, NULL, NOW() - INTERVAL '27 days', 'CONFIRMADO', NOW(), NOW()),
('enr-013', 'ten-001', '2026-000013', 'EM_ESPERA', 'INFANTIL_3', 'chi-013', 'cmei-003', NOW() - INTERVAL '3 days', NULL, NULL, NULL, ARRAY[]::TEXT[], 0, NULL, NULL, 2027, NULL, NULL, NULL, NOW(), NOW()),
('enr-014', 'ten-001', '2026-000014', 'CONVOCADO', 'INFANTIL_4', 'chi-014', 'cmei-001', NOW() - INTERVAL '10 days', NULL, NOW(), NULL, ARRAY['SOCIAL_VULNERABILITY'], 100, NOW() + INTERVAL '7 days', NULL, 2027, NULL, NULL, NULL, NOW(), NOW()),
('enr-015', 'ten-001', '2026-000015', 'EM_ESPERA', 'INFANTIL_5', 'chi-015', 'cmei-003', NOW() - INTERVAL '2 days', NULL, NULL, NULL, ARRAY['WORKING_GUARDIAN'], 30, NULL, NULL, 2027, NULL, NULL, NULL, NOW(), NOW());

-- Configuracoes
INSERT INTO "Setting" ("tenantId", "key", "value", "updatedAt") VALUES
('ten-001', 'schoolYear', '2027', NOW()),
('ten-001', 'queueEnabled', 'true', NOW()),
('ten-001', 'defaultCity', 'Santa Tereza do Oeste', NOW()),
('ten-001', 'notificationChannel', 'WHATSAPP', NOW());

-- Notificacoes
INSERT INTO "Notification" ("id", "tenantId", "channel", "recipient", "subject", "body", "status", "error", "enrollmentRequestId", "createdAt", "sentAt") VALUES
('not-001', 'ten-001', 'WHATSAPP', '(45) 99900-0001', 'Solicitacao recebida', 'Sua solicitacao 2026-000001 foi recebida e esta na fila.', 'SIMULATED', NULL, 'enr-001', NOW() - INTERVAL '20 days', NULL),
('not-002', 'ten-001', 'EMAIL', 'roberto.almeida@test.com', 'Convocacao para matricula', 'Existe uma convocacao referente ao protocolo 2026-000002.', 'SENT', NULL, 'enr-002', NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days'),
('not-003', 'ten-001', 'SMS', '(45) 99900-0003', 'Matricula confirmada', 'A matricula foi confirmada.', 'SENT', NULL, 'enr-003', NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days'),
('not-004', 'ten-001', 'WHATSAPP', '(45) 99900-0004', 'Solicitacao recebida', 'Sua solicitacao esta em analise.', 'SIMULATED', NULL, 'enr-004', NOW() - INTERVAL '12 days', NULL),
('not-005', 'ten-001', 'EMAIL', 'fernanda.costa@test.com', 'Atualizacao da fila', 'O status da solicitacao foi atualizado.', 'FAILED', 'Falha simulada no envio', 'enr-005', NOW() - INTERVAL '19 days', NULL),
('not-006', 'ten-001', 'WHATSAPP', '(45) 99900-0006', 'Solicitacao recebida', 'Sua solicitacao foi registrada.', 'SIMULATED', NULL, 'enr-006', NOW() - INTERVAL '8 days', NULL),
('not-007', 'ten-001', 'SMS', '(45) 99900-0009', 'Convocacao', 'Consulte o prazo para comparecimento ao CMEI.', 'SENT', NULL, 'enr-009', NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day'),
('not-008', 'ten-001', 'EMAIL', 'vanessa.rocha@test.com', 'Matricula confirmada', 'A matricula foi confirmada com sucesso.', 'SENT', NULL, 'enr-012', NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days'),
('not-009', 'ten-001', 'WHATSAPP', '(45) 99900-0014', 'Convocacao para matricula', 'Voce possui uma convocacao pendente.', 'PENDING', NULL, 'enr-014', NOW(), NULL),
('not-010', 'ten-001', 'EMAIL', 'felipe.barbosa@test.com', 'Solicitacao recebida', 'Sua solicitacao foi registrada na fila.', 'SIMULATED', NULL, 'enr-015', NOW() - INTERVAL '2 days', NULL);

-- Tokens de recuperacao de senha
INSERT INTO "PasswordResetToken" ("id", "token", "userId", "expiresAt", "usedAt", "createdAt") VALUES
('prt-001', 'TOKEN-TESTE-001', 'usr-002', NOW() + INTERVAL '1 hour', NULL, NOW()),
('prt-002', 'TOKEN-TESTE-002', 'usr-003', NOW() - INTERVAL '1 day', NOW() - INTERVAL '2 days', NOW() - INTERVAL '3 days');

-- Pre-matriculas (dados ficticios)
INSERT INTO "PreEnrollment" ("id", "tenantId", "protocol", "status", "childName", "childCpf", "childBirthDate", "birthCertificate", "observations", "guardianName", "guardianCpf", "guardianBirthDate", "guardianPhone", "guardianEmail", "relationship", "street", "number", "complement", "neighborhood", "city", "zipCode", "birthCertificateUrl", "guardianIdUrl", "proofOfResidenceUrl", "custodyDocumentUrl", "priorityDocumentUrl", "priorityKeys", "flags", "consentAcceptedAt", "submittedIp", "submittedAt", "reviewedAt", "reviewedById", "reviewNote", "enrollmentRequestId", "createdAt", "updatedAt") VALUES
('pre-001', 'ten-001', 'PRE-2026-0001', 'PENDENTE', 'Gabriel Nascimento', '70000000001', '2023-01-10', 'CERT-PRE-0001', NULL, 'Renata Nascimento', '60000000001', '1994-04-12', '(45) 99800-0001', 'renata.nascimento@test.com', 'MAE', 'Rua do Comercio', '120', NULL, 'Centro', 'Santa Tereza do Oeste', '85825-000', '/uploads/cert-0001.pdf', '/uploads/doc-0001.pdf', '/uploads/res-0001.pdf', NULL, NULL, ARRAY['WORKING_GUARDIAN'], ARRAY[]::TEXT[], NOW() - INTERVAL '1 day', '192.0.2.10', NOW() - INTERVAL '1 day', NULL, NULL, NULL, NULL, NOW(), NOW()),
('pre-002', 'ten-001', 'PRE-2026-0002', 'APROVADO', 'Mariana Lopes', '70000000002', '2022-06-15', 'CERT-PRE-0002', 'Documentacao conferida', 'Carlos Lopes', '60000000002', '1990-08-22', '(45) 99800-0002', 'carlos.lopes@test.com', 'PAI', 'Rua Sao Paulo', '245', 'Casa 2', 'Vila Nova', 'Santa Tereza do Oeste', '85825-000', '/uploads/cert-0002.pdf', '/uploads/doc-0002.pdf', '/uploads/res-0002.pdf', NULL, '/uploads/prioridade-0002.pdf', ARRAY['SOCIAL_VULNERABILITY'], ARRAY[]::TEXT[], NOW() - INTERVAL '10 days', '192.0.2.11', NOW() - INTERVAL '10 days', NOW() - INTERVAL '8 days', 'usr-002', 'Documentos aprovados para analise de vaga', NULL, NOW(), NOW()),
('pre-003', 'ten-001', 'PRE-2026-0003', 'REJEITADO', 'Pedro Henrique Alves', '70000000003', '2021-09-20', 'CERT-PRE-0003', NULL, 'Silvia Alves', '60000000003', '1988-02-03', '(45) 99800-0003', 'silvia.alves@test.com', 'MAE', 'Rua Bahia', '380', NULL, 'Jardim Europa', 'Santa Tereza do Oeste', '85825-000', '/uploads/cert-0003.pdf', '/uploads/doc-0003.pdf', '/uploads/res-0003.pdf', NULL, NULL, ARRAY[]::TEXT[], ARRAY['DOCUMENTO_PENDENTE'], NOW() - INTERVAL '15 days', '192.0.2.12', NOW() - INTERVAL '15 days', NOW() - INTERVAL '12 days', 'usr-002', 'Comprovante ilegivel; necessario reenviar', NULL, NOW(), NOW()),
('pre-004', 'ten-001', 'PRE-2026-0004', 'PENDENTE', 'Isadora Martins', '70000000004', '2020-12-02', 'CERT-PRE-0004', 'Solicitacao aguardando conferencia', 'Priscila Martins', '60000000004', '1992-11-17', '(45) 99800-0004', 'priscila.martins@test.com', 'RESPONSAVEL_LEGAL', 'Rua Mato Grosso', '510', 'Fundos', 'Centro', 'Santa Tereza do Oeste', '85825-000', '/uploads/cert-0004.pdf', '/uploads/doc-0004.pdf', '/uploads/res-0004.pdf', '/uploads/guarda-0004.pdf', NULL, ARRAY['SINGLE_PARENT'], ARRAY[]::TEXT[], NOW() - INTERVAL '3 days', '192.0.2.13', NOW() - INTERVAL '3 days', NULL, NULL, NULL, NULL, NOW(), NOW()),
('pre-005', 'ten-001', 'PRE-2026-0005', 'PENDENTE', 'Rafael Souza', '70000000005', '2019-04-25', 'CERT-PRE-0005', NULL, 'Andre Souza', '60000000005', '1987-07-30', '(45) 99800-0005', 'andre.souza@test.com', 'PAI', 'Rua Minas Gerais', '625', NULL, 'Jardim Primavera', 'Santa Tereza do Oeste', '85825-000', '/uploads/cert-0005.pdf', '/uploads/doc-0005.pdf', '/uploads/res-0005.pdf', NULL, NULL, ARRAY['WORKING_GUARDIAN'], ARRAY[]::TEXT[], NOW() - INTERVAL '2 days', '192.0.2.14', NOW() - INTERVAL '2 days', NULL, NULL, NULL, NULL, NOW(), NOW());

-- Logs de auditoria
INSERT INTO "AuditLog" ("id", "tenantId", "action", "entity", "entityId", "metadata", "userId", "ip", "createdAt") VALUES
('log-001', 'ten-001', 'CREATE', 'EnrollmentRequest', 'enr-001', '{"protocol":"2026-000001","status":"EM_ESPERA"}'::jsonb, 'usr-002', '192.0.2.20', NOW() - INTERVAL '20 days'),
('log-002', 'ten-001', 'UPDATE_STATUS', 'EnrollmentRequest', 'enr-002', '{"from":"EM_ESPERA","to":"CONVOCADO"}'::jsonb, 'usr-002', '192.0.2.20', NOW() - INTERVAL '2 days'),
('log-003', 'ten-001', 'ENROLL', 'EnrollmentRequest', 'enr-003', '{"status":"MATRICULADO"}'::jsonb, 'usr-003', '192.0.2.21', NOW() - INTERVAL '10 days'),
('log-004', 'ten-001', 'CREATE', 'PreEnrollment', 'pre-001', '{"protocol":"PRE-2026-0001"}'::jsonb, 'usr-005', '192.0.2.22', NOW() - INTERVAL '1 day'),
('log-005', 'ten-001', 'REVIEW', 'PreEnrollment', 'pre-003', '{"status":"REJEITADO"}'::jsonb, 'usr-002', '192.0.2.20', NOW() - INTERVAL '12 days');

COMMIT;