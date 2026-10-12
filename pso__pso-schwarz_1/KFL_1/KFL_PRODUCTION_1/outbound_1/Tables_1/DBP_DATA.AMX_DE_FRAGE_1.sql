--==============================================================
-- Table: amx_de_frage_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_de_frage_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_de_frage_1 (
amx_frage_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID einer Frage (Handlung) aus dem Quellfeld guideline.id'),
pruef_kapitel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Prüf Kapitels'),
antwort_wert BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Beantwortung der Frage aus dem Quellfeld numeric_result'),
amx_frage_katalog_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID einer Frage aus dem Fragenkatalog'),
anmerkung STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Anmerkung aus dem Quellfeld work_description'),
eingabe STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Eingabe aus dem Quellfeld enter_result'),
anz_fehler_amx BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fehler'),
stichprobe_umfang BIGNUMERIC(38,0) OPTIONS(description='Stichprobenumfang'),
frage_gewichtung BIGNUMERIC(38,0) OPTIONS(description='Gewichtung der Frage für die Berechnung des Endergebnisses'),
antwort_wert_text STRING(60) COLLATE 'und:ci' OPTIONS(description='Textuelle Darstellung des Felder antwort_wert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_frage_id) NOT ENFORCED
) OPTIONS(description='KMR - Audimex. Enthält die Fragen der Prüfprogramme für Kurzcheck DE Daten');