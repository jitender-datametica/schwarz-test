--==============================================================
-- Table: amx_l_business_process_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_business_process_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_BUSINESS_PROCESS_1 (
   business_process_id                 NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   business_process_bez                VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Die Bezeichnung (der Name) des Prüffeldes aus der Quellspalte audit_universe.name, z.Bsp. Arbeitsschutz',
   pruef_feld_typ_id                   NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Prüffeld-Typs aus der Quelle audit_universe.au_type_id',
   in_matrix_pruefgebiete_fg           NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Flag aus dem Quellfeld shows_up_in_dimension',
   aktiv_fg                            NUMBER(38,0)     NOT NULL DEFAULT 1 COMMENT 'Flag zeigt an, ob das Prüffeld aktiv ist. Aus dem Quellfeld active',
   amx_grp_id                          NUMBER(38,0)     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_BUSINESS_PROCESS PRIMARY KEY (business_process_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - audimex - Lookup Tabelle der Business-Prozesse (z.B. Prüfprogram für eine_1 Filiale). Quelle ist audit_universe, wird im DWH befüllt';

