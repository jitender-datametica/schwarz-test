CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_wup_tag_bestand_korrektur_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL,
dat_mhd DATE NOT NULL,
prozess_kz STRING(10) NOT NULL,
kl_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer.'),
wg_id BIGNUMERIC(38,0),
wug_id BIGNUMERIC(38,0),
menge_rest BIGNUMERIC(38,3),
menge_we_ges BIGNUMERIC(38,3),
menge_einh_id STRING(10),
mhd_gruppe_id BIGNUMERIC(38,0),
anz_tage_soll_lieferzeit BIGNUMERIC(38,0),
anz_tage_soll_we_bearbeitung BIGNUMERIC(38,0),
datzeit_erstellung TIMESTAMP,
datzeit_aenderung TIMESTAMP,
datzeit_extrakt TIMESTAMP,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_mhd, prozess_kz, art_id) NOT ENFORCED
) OPTIONS(description='SOURCE: SAP ZRS_STOCK_REDUCT');