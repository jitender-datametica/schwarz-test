--==============================================================
-- Table: amx_empfehlung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_empfehlung_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_empfehlung_1 (
empfehlung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID einer Empfehlung aus dem Quellfeld suggestion.id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
empfehlung_nr STRING(10) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Nummer der Empfehlung aus dem Quellfeld action_no, z.Bsp. 001-001'),
feststellung_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID einer Feststellung aus issue_id'),
zustand_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Zustands aus dem Quellfeld state. Referenz zur Tabelle amx_l_zustand_1'),
dat_soll DATE OPTIONS(description='Der Tag_1, an dem die Maßnahme abgeschlossen sein sollte aus init_finish_date'),
dat_abschluss DATE
OPTIONS(description='Der Tag_1, an dem diese Maßnahme tatsächlich erledigt wurde aus dem Quellfeld closed_when'),
pruef_feld_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Eintrags aus dem Quellfeld responsible_unit_id. Referenz zu audit_universe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (empfehlung_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Die Tabelle Empfehlung enthält die Empfehlungen aus den Prüfungen. Aus der Quelle audimex.suggestion');