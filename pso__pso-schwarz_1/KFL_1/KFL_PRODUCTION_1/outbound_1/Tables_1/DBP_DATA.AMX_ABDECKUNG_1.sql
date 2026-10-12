--==============================================================
-- Table: amx_abdeckung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_abdeckung_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_abdeckung_1 (
abdeckung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID der Tabelle amx_abdeckung. Aus dem Quellfeld auditing_id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruefung_id BIGNUMERIC(38,0) OPTIONS(description='Die eindeutige ID einer Prüfung aus dem Quellfeld auditing.id'),
berechneter_wert NUMERIC(9,2) OPTIONS(description='Automatisch berechneter Wert anhand der Gewichtung aus amx_frage_1'),
manueller_wert NUMERIC(9,2) OPTIONS(description='Manuell gesetzter Wert durch Prüfer'),
business_process_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Geschäftsprozesses.Verweis auf ein Prüffeld mit dem Typ Prozess. Referenz auf pruef_feld_id. Aus dem Quellfeld audit_universe.business_process_id bzw.audit_universe.id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (abdeckung_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - audimex - Die Tabelle Abdeckung enthält den Jahresplan der Prüfungen. Aus der Quelle audimex.contains_pu');