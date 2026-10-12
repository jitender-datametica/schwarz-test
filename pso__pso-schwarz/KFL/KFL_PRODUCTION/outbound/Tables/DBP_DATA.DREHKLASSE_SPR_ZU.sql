--==============================================================
-- Table: drehklasse_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: drehklasse_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.drehklasse_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
drehklasse_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Drehklasse auf Artikel-/ Markt-Kombination(z.B. A, B oder C (Schnell-, Mittel- und Langsamdreher )-wird im ETL-Prozess auf Basis der F&R-Daten ermittelt: Schwellwerte: A=80% des Absatz (Stückbedarf an Gesamtmenge), B= 15% des Absatz, C= 5% des Absatz)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
drehklasse_bez STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Drehklasse (Ausprägungen z.B. A, B oder C - wird im ETL-Prozess auf Basis der F&R-Daten ermittelt)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='SCM - Sprachabhängige Bezeichnungen für Drehklassen (z.B. A,B und C resp. Schnell-, Mittel- und Langsamdreher) wird auf Basis der Daten auf SAP RET FRE - Tabelle');