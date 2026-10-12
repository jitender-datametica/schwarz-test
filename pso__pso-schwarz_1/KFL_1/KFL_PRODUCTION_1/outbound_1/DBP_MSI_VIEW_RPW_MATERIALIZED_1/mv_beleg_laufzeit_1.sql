CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_beleg_laufzeit_1 (
system_id INTEGER,
mandant_id INTEGER,
beleg_id INTEGER,
beleg_gj INTEGER,
dat_erfasst DATE,
dat_buch DATE,
dat_beleg DATE,
betrag_brutto NUMERIC(29,2),
gp_id INTEGER,
belegart_id STRING(2) COLLATE 'und:ci',
ersteller_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
einkaufsorganisation_id INTEGER,
anz_tage INTEGER,
max_dat DATE,
dat_lz DATE
);