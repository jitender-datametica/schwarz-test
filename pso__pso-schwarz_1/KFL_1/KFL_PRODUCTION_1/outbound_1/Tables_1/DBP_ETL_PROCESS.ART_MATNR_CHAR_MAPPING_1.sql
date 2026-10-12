CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_matnr_char_mapping_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kl_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer'),
matnr_char STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Alphanummerisch Artikelnummer aus dem Quellsystem (matnr)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);