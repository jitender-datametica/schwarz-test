--==============================================================
-- Table: flw_plandaten
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_plandaten
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_plandaten (
gjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresmonat'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
umsatz_anlieferung_plan NUMERIC(18,4) NOT NULL OPTIONS(description='Anlieferumsatz aus cm_we_fl_cur'),
rohertrag_anlieferung_plan NUMERIC(18,4) NOT NULL
OPTIONS(description='Anlieferrohertrag Warengruppe Fleisch (account: cm_are_fl_cur)'),
abschrift_inventur_plan NUMERIC(18,4) NOT NULL
OPTIONS(description='Inventurabschriften Warengruppe Fleisch (account: cm_invdiff_cur)'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gjmo, wup_id, nb_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Planwerte für Fleischwaren pro Markt und Monat. Quelle ist Hyperion HFM');