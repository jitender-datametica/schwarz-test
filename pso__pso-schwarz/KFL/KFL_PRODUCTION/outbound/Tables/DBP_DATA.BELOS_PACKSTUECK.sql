--==============================================================
-- Table: belos_packstueck
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_packstueck
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_packstueck (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
belos_vorgang_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierte eindeutige ID für die Belos Vorgänge. Ein Belos Vorgang setzt sich aus einem Transportauftrag (Logistikdaten) und einer Sendung (Abrechnungsdaten).'),
belos_packstueck_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige Nummer des Packstücks innerhalb eines Belos-Vorgangs'),
packstueck_gebinde_einh_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Einheiten der Packstück Gebinde (z. B. Europalette)'),
packstueck_gebindeart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Arten der Packstück Gebinde (z. B. Fleisch)'),
gebinde_anz BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl gleicher Gebinde innerhalb der Packstückposition'),
bruttogew_avisiert NUMERIC(18,3) NOT NULL OPTIONS(description='Avisiertes Bruttogewicht'),
sendung_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag zum Bezug des Packstücks auf die Sendung (=1)'),
belosart_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zeigt an, ob es sich bei dem Datensatz um einen Distributions- oder Beschaffungsvorgang handelt'),
nettogew_avisiert NUMERIC(18,3) NOT NULL
OPTIONS(description='Avisiertes Nettogewicht. Wird aus SAP (führendes System) oder aus Belos befüllt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (belos_vorgang_id, belos_packstueck_id, mandant_id) NOT ENFORCED
) OPTIONS(description='LIS - Die Tabelle enthaelt die Packstuecke pro Transportauftrag');