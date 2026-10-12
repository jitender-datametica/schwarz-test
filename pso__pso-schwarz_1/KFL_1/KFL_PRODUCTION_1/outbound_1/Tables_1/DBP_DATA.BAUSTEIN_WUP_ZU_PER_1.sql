--==============================================================
-- Table: baustein_wup_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: baustein_wup_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.baustein_wup_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_bis DATE NOT NULL OPTIONS(description='Ende des Gültigkeitszeitraums Format\'YYYY-MM_1-DD\''),
baustein_id INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
dat_von DATE OPTIONS(description='Beginn des Gültigkeitszeitraums Format\'YYYY-MM_1-DD\''),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_bis, baustein_id) NOT ENFORCED
) OPTIONS(description='TP2/7 AIS - Zuordnung Baustein zu Wup_1 - MULTISET');