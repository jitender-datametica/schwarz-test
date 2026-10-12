--==============================================================
-- Table: flw_storno_nachkauf
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_storno_nachkauf
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_storno_nachkauf (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dat DATE NOT NULL OPTIONS(description='Tagesdatum - immer zum Samstag einer Kalenderwoche werden die Daten eingespielt'),
storno_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Stornofall, wenn = 1, Nachkauf, wenn = 0'),
menge_kg_wunsch NUMERIC(18,3) NOT NULL OPTIONS(description='Wunschmenge in Kilogramm'),
menge_kg_ist NUMERIC(18,3) NOT NULL OPTIONS(description='Istmenge in Kilogramm'),
menge_bstmg_wunsch NUMERIC(18,3) NOT NULL OPTIONS(description='Wunschmenge in Bestellmengeneinheit'),
menge_bstmg_ist NUMERIC(18,3) NOT NULL OPTIONS(description='Gesamtmenge erfüllt in Bestellmengeneinheit'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, werk_id, dat, storno_fg, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Storno- und Nachkaufmengen im Fleischwerk. Quelle ist Hyperion');