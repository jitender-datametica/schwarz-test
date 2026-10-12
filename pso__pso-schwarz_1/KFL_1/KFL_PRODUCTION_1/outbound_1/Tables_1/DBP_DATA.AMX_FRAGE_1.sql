--==============================================================
-- Table: amx_frage_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_frage_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_frage_1 (
amx_frage_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID einer Frage (Handlung) aus dem Quellfeld guideline.id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruef_kapitel_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines Pruef-Kapitels. Aus dem Quellfeld id'),
antwort_wert BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Beantwortung der Frage aus Quellfeld numeric_result'),
amx_frage_katalog_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID einer Frage aus dem Fragenkatalog aus der Quelle guideline.abstract_guideline_id.'),
anmerkung STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Anmerkung aus dem Quellfeld work_description'),
eingabe STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Eingabe aus dem Quellfeld enter_result'),
anz_fehler_amx BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fehler aus dem Quellfeld count_errors'),
stichprobe_umfang BIGNUMERIC(38,0) OPTIONS(description='Stichprobenumfang aus dem Quellfeld audited_amount'),
frage_gewichtung BIGNUMERIC(38,0) OPTIONS(description='Gewichtung der Fragen für die Berechnung des Endergebnisses'),
antwort_wert_text STRING(60) COLLATE 'und:ci'
OPTIONS(description='Textuelle Darstellung des nummerischen Feldes antwort_wert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_frage_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='VIS audimex - Die Tabelle amx_frage_1 enthält die Fragen (Handlungen) der Prüfprogramme. Aus der Quelle audimex.guideline');