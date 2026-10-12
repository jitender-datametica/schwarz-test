--==============================================================
-- Table: amx_de_pruef_kapitel_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_de_pruef_kapitel_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_de_pruef_kapitel_1 (
pruef_kapitel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID des Prüfkapitels'),
pruefung_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Eindeutige Prüfung zu der dieses Prüfkapitel gehört.'),
pruef_kapitel_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prüfkapitels aus dem Quellfeld name'),
hauptbereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID des Hauptbereichs'),
teilbereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID des Teilbereichs'),
kapitel_ergebnis_wert BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Ergebnisswert aus dem Quellfeld numeric_result'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruef_kapitel_id) NOT ENFORCED
) OPTIONS(description='KMR - Audimex. Enthäl Kapitel der Prüfprogramme für Kurzcheck Daten aus DE');