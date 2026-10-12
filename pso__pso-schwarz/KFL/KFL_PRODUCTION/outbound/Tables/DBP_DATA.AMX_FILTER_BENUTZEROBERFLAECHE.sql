--==============================================================
-- Table: amx_filter_benutzeroberflaeche
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_filter_benutzeroberflaeche
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_filter_benutzeroberflaeche (
amx_filter_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Typ der IDs zur Unterscheidung der generischen Platzhalter-Spalten (1 - Hauptbereich, 2 - Teilbereich, 3 - Frage) zur Filterung in Berichtsoberflaeche'),
platzhalter_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Generische Spalte mit IDs aus amx_hauptbereich, amx_teilbereich, amx_frage(0 als nicht relevant, da Verwendung von platzhalter_string) Tabellen'),
platzhalter_string STRING(50) NOT NULL
OPTIONS(description='Generische Spalte mit Teilstring (Suffix) zu den Fragen aus amx_frage Tabelle zur Selektion aller anzuzeigenden Fragen in der Oberflaeche'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
platzhalter_sort BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Sortierfeld für Platzhalter'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_filter_typ_id, platzhalter_id, platzhalter_string, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - audimex - Tabelle mit generischen Platzhalter-Spalten ..._id aus Teilbereich, Hauptbereich, ..._string (Teilstring als Suffixe der Fragenummer) zur Anzeigesteuerung in KMR Dashboard im Vertriebs-Cockpit');