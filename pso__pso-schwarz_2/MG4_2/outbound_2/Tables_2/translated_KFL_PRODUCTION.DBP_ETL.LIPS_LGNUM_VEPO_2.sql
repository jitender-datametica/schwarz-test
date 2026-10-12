CREATE OR REPLACE TABLE kfl_production_dbp_etl.lips_lgnum_vepo_2 (
mandant_id INTEGER,
lief_beleg_id INTEGER,
lief_beleg_pos_id INTEGER,
art_id INTEGER,
dat_lief_soll DATE,
wup_id INTEGER NOT NULL,
vk_netto NUMERIC(9,4),
menge_handling_kolli NUMERIC(9,3),
ek_nettonetto NUMERIC(18,4),
verk_menge_einh_id STRING(3) COLLATE 'und:ci',
vemng NUMERIC(9,3)
);