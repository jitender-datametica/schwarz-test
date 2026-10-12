--==============================================================
-- Table: lief_plantour_arbeitsvorrat_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lief_plantour_arbeitsvorrat_2
   generated from Powerdesigner on Thursday, April 28, 2022 3:20:41 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lief_plantour_arbeitsvorrat_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lief_beleg_id INTEGER NOT NULL OPTIONS(description='Lieferung'),
av_herkunft_id STRING(10) NOT NULL OPTIONS(description='Herkunft Arbeitsvorrat'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
plantour_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Plantournummer'),
vp_fg BIGNUMERIC(38,0) OPTIONS(description='virtuelle Palette'),
stp_faktor_tour BIGNUMERIC(38,5) OPTIONS(description='Stellplatzfaktor für Tourenplanung'),
anz_stp BIGNUMERIC(38,5) OPTIONS(description='Summe Stellplätze'),
dat_aenderung DATE OPTIONS(description='Datum der letzten Änderung'),
dat_lief_soll DATE OPTIONS(description='Lieferdatum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lief_beleg_id, av_herkunft_id) NOT ENFORCED
) OPTIONS(description='Plantouren: Arbeitsvorrat');