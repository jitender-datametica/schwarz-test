CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_wup_tag_bestand_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL,
kl_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer.'),
menge_lgbest_erp_frei_bme BIGNUMERIC(38,3),
menge_lgbest_erp_nach_abverkauf_bme BIGNUMERIC(38,3),
menge_abverkauf_bme BIGNUMERIC(38,3),
datzeit_extrakt TIMESTAMP,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id) NOT ENFORCED
) OPTIONS(description='SOURCE: SAP ZDMONLINESTOCKS4');