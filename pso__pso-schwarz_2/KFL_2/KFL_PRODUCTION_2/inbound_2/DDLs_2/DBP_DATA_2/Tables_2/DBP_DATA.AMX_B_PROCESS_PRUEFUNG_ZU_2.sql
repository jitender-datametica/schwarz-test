--==============================================================
-- Table: amx_b_process_pruefung_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_b_process_pruefung_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_B_PROCESS_PRUEFUNG_ZU_2 (
   business_process_id                 NUMBER(38,0)     NOT NULL COMMENT 'ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id',
   pruefung_id                         NUMBER(38,0)     NOT NULL COMMENT 'Die eindeutige ID einer Prüfung aus dem Quellfeld auditing.id',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_B_PROCESS_PRUEFUNG_ZU PRIMARY KEY (business_process_id, pruefung_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - bildet n:m-Beziehung zwischen business_process und Pruefung ab. Wird im DWH befüllt';

