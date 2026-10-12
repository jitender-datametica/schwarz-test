--==============================================================
-- Table: amx_empfehlung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_empfehlung_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_EMPFEHLUNG_2 (
   empfehlung_id                       NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID einer Empfehlung aus dem Quellfeld suggestion.id',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   empfehlung_nr                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Nummer der Empfehlung aus dem Quellfeld action_no, z.Bsp. 001-001',
   feststellung_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID einer Feststellung aus issue_id',
   zustand_id                          NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Zustands aus dem Quellfeld state. Referenz zur Tabelle amx_l_zustand_2',
   dat_soll                            DATE             COMMENT 'Der Tag_2, an dem die Maßnahme abgeschlossen sein sollte aus init_finish_date',
   dat_abschluss                       DATE             COMMENT 'Der Tag_2, an dem diese Maßnahme tatsächlich erledigt wurde aus dem Quellfeld closed_when',
   pruef_feld_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Eintrags aus dem Quellfeld responsible_unit_id. Referenz zu audit_universe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_EMPFEHLUNG PRIMARY KEY (empfehlung_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Die Tabelle Empfehlung enthält die Empfehlungen aus den Prüfungen. Aus der Quelle audimex.suggestion';

