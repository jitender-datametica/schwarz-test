--==============================================================
-- Table: amx_pruef_programm_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_pruef_programm_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_PRUEF_PROGRAMM_1 (
   pruef_programm_id                   NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID des Prüfprogramms aus dem Quellfeld ID',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruef_programm_bez                  VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Prüfprogramms aus der Quellspalte name',
   zustand_id                          NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Zustands aus dem Quellfeld state. Referenz zu wal_state.nr',
   kapitel_typ_id                      NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des Prüfprogrammtyps aus dem Quellfeld id',
   pruef_programm_mutter_id            NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'übergeordnetes Kapitel aus dem Quellfeld father_id. Referenz zu pruef_programm_id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_PRUEF_PROGRAMM PRIMARY KEY (pruef_programm_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Prüfprogramm - Aus der Quelle audimex.audit_concept';

