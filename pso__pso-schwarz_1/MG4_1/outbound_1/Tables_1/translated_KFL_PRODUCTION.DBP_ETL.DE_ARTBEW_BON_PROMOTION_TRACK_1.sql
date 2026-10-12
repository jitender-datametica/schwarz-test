CREATE OR REPLACE TABLE kfl_production_dbp_etl.de_artbew_bon_promotion_track_1 (
mandant_id INTEGER,
bon_id STRING(25),
dat_booking DATE,
kl_art_id INTEGER,
bon_zeile INTEGER,
bonuskauf_id STRING(20),
konditionsart_id STRING(10),
umsatz_brutto NUMERIC(18,4),
umsatz_promo_brutto NUMERIC(18,4),
menge_promo NUMERIC(18,3),
customer_promotion_fg INTEGER DEFAULT 0,
promotion_art STRING(100),
lfd_nr INTEGER,
wup_id INTEGER
);