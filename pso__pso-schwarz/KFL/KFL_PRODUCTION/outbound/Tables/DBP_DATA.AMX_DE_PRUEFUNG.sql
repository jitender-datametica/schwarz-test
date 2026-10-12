--==============================================================
-- Table: amx_de_pruefung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_de_pruefung
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_de_pruefung (
pruefung_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID der Prüfung'),
pruefung_nr STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Prüfungsnummer'),
zustand_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID des Zustanddes'),
pruefung_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung der Prüfung'),
dat_start DATE OPTIONS(description='Startdatum der Prüfung'),
dat_ende DATE OPTIONS(description='Enddatum der Prüfung'),
revisor_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='ID des Revisors, wird aus datenschutzrechtlichen Gründen nicht verwendet'),
pruefung_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID des Prüfungstypes'),
pruefung_klasse_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Eindeutige ID der Prüfungsklasse'),
pruefung_ergebnis_wert BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Ergebnisswert'),
business_unit_id BIGNUMERIC(38,0) OPTIONS(description='ID der Organisationseinheit'),
mandant_id BIGNUMERIC(38,0) OPTIONS(description='ID des Mandanten'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='ID der Filiale'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruefung_id) NOT ENFORCED
) OPTIONS(description='KMR - Audimex. Enthält Prüfungsdaten Kurzcheck aus DE');