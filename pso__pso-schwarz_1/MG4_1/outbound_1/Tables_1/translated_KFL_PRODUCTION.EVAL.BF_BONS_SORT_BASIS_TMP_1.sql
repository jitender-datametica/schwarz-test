CREATE OR REPLACE TABLE kfl_production_eval.bf_bons_sort_basis_tmp_1 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
dat DATE,
kasse_nr INTEGER NOT NULL,
bon_nr INTEGER NOT NULL,
bon_id STRING(25) COLLATE 'und:ci',
kl_art_id INTEGER NOT NULL,
bon_umsatz_af NUMERIC(18,2) NOT NULL,
bon_umsatz_sa NUMERIC(18,2) NOT NULL,
bon_absatz_af NUMERIC(18,3) NOT NULL,
bon_absatz_sa NUMERIC(18,3) NOT NULL,
art_umsatz_af NUMERIC(18,2) NOT NULL,
art_umsatz_sa NUMERIC(18,2) NOT NULL,
art_absatz_af NUMERIC(18,3) NOT NULL,
art_absatz_sa NUMERIC(18,3) NOT NULL,
cpaf_fg INTEGER NOT NULL,
cpsa_fg INTEGER NOT NULL
);