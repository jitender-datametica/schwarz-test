CREATE OR REPLACE TABLE kfl_production_dbp_etl.kmo_artbew_bon_promotion (
mandant_id INTEGER,
bon_id STRING(25) COLLATE 'und:ci',
dat_booking DATE,
kl_art_id INTEGER,
bon_zeile INTEGER,
bonuskauf_id STRING(20) COLLATE 'und:ci',
konditionsart_id STRING(10) COLLATE 'und:ci',
umsatz_brutto NUMERIC(18,4),
umsatz_promo_brutto NUMERIC(18,4),
menge_promo NUMERIC(18,3)
);