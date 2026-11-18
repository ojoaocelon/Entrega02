INSERT INTO "Tenant" (id, name, city, state, slug) VALUES
    ('tenant-santa-tereza', 'Prefeitura de Santa Tereza do Oeste', 'Santa Tereza do Oeste', 'PR', 'santa-tereza')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "Cmei" (id, "tenantId", name, city, region, address) VALUES
    ('cmei-exemplo-1', 'tenant-santa-tereza', 'CMEI Pequeno Príncipe', 'Santa Tereza do Oeste', 'Centro',       'Rua das Flores, 100'),
    ('cmei-exemplo-2', 'tenant-santa-tereza', 'CMEI Arco-Íris',        'Santa Tereza do Oeste', 'Jardim Paraná', 'Av. Brasil, 2500')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "Capacity" (id, "tenantId", "cmeiId", infantil, "totalSeats") VALUES
    ('vaga-exemplo-1', 'tenant-santa-tereza', 'cmei-exemplo-1', 'INFANTIL_1', 20),
    ('vaga-exemplo-2', 'tenant-santa-tereza', 'cmei-exemplo-1', 'INFANTIL_2', 25),
    ('vaga-exemplo-3', 'tenant-santa-tereza', 'cmei-exemplo-2', 'INFANTIL_1', 15)
ON CONFLICT (id) DO NOTHING;

INSERT INTO "Guardian" (id, "tenantId", name, cpf, phone, email) VALUES
    ('resp-exemplo-1', 'tenant-santa-tereza', 'Maria da Silva', '11122233344', '(45) 99999-0001', 'maria@exemplo.com')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "Child" (id, "tenantId", "fullName", "birthDate", "birthCertificate", "guardianId") VALUES
    ('crianca-exemplo-1', 'tenant-santa-tereza', 'Ana da Silva', '2024-03-15', 'CERT-000001', 'resp-exemplo-1')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "EnrollmentRequest" (id, "tenantId", protocol, infantil, "schoolYear", "childId", "cmeiId") VALUES
    ('inscricao-exemplo-1', 'tenant-santa-tereza', 'EXEMPLO-2026-0001', 'INFANTIL_2', 2026, 'crianca-exemplo-1', 'cmei-exemplo-1')
ON CONFLICT (id) DO NOTHING;
