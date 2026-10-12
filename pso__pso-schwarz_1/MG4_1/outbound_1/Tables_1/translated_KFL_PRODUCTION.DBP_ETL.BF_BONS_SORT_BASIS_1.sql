CREATE OR REPLACE TABLE kfl_production_dbp_etl.bf_bons_sort_basis_1 (
mandant_id INTEGER,
wup_id INTEGER,
dat DATE,
kasse_nr INTEGER,
bon_nr INTEGER,
bon_id STRING(25),
kl_art_id INTEGER,
bon_umsatz_af NUMERIC(18,2),
bon_umsatz_sa NUMERIC(18,2),
bon_absatz_af NUMERIC(18,3),
bon_absatz_sa NUMERIC(18,3),
art_umsatz_af NUMERIC(18,2),
art_umsatz_sa NUMERIC(18,2),
art_absatz_af NUMERIC(18,3),
art_absatz_sa NUMERIC(18,3),
cpaf_fg INTEGER,
cpsa_fg INTEGER
);