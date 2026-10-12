CREATE OR REPLACE TABLE kfl_production_dbp_msi_view3_materialized.tbl_mv_handling_unit_rekl (
handling_unit_id INTEGER,
art_id INTEGER,
mandant_id INTEGER,
handling_unit_pos_id INTEGER,
dat_buch DATE,
dat_erfasst DATE,
menge_bme NUMERIC(29,3),
tour_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
vz_wup_id INTEGER,
lis_rekl_grund_id INTEGER,
lis_rekl_status_id STRING(10) COLLATE 'und:ci',
versandstelle_id STRING(4) COLLATE 'und:ci',
wrg_typ_id INTEGER,
vk_brutto NUMERIC(29,3),
umrechnungskurs NUMERIC(29,5)
);