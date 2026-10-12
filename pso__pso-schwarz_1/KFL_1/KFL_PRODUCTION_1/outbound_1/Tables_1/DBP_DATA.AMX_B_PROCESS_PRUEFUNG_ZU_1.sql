--==============================================================
-- Table: amx_b_process_pruefung_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_b_process_pruefung_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_b_process_pruefung_zu_1 (
business_process_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id'),
pruefung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die eindeutige ID einer Prüfung aus dem Quellfeld auditing.id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (business_process_id, pruefung_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - bildet n:m-Beziehung zwischen business_process und Pruefung ab. Wird im DWH befüllt');