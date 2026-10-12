--==============================================================
-- Table: best_qualifikation_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_qualifikation_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.best_qualifikation_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
best_qualifikation_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Identifiziert eindeutig einen spezifischen Lagerbestand eines Materials, z. B. Qualitätsprüfbestand, Retourenbestand, usw.'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
best_qualifikation_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld enthält die Kurzbezeichnung der Bestandsqualifikationen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle befinden die sprachabhängigen Kurztexte für die Qulifikation der Lagerbestände. - MULTISET');