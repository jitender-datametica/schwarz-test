CREATE OR REPLACE TABLE kfl_production_dbp_etl.sort_kpi_tag_basis_2 (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
dat DATE,
kasse_nr INTEGER NOT NULL,
bon_nr INTEGER NOT NULL,
bon_id STRING(25) COLLATE 'und:ci' NOT NULL,
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