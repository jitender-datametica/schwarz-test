CREATE OR REPLACE TABLE kfl_production_dbp_etl.lips_lgnum_vepo_anr (
mandant_id INTEGER,
lief_beleg_id INTEGER,
lief_beleg_pos_id INTEGER,
art_id INTEGER,
dat_lief_soll DATE,
menge_lief_ist_bme NUMERIC(18,3),
menge_kolli NUMERIC(18,3),
menge_lief_ist_kolli NUMERIC(18,3),
wup_id INTEGER NOT NULL,
vk_netto_lief_ist NUMERIC(18,4),
vk_netto NUMERIC(9,4),
menge_handling_kolli NUMERIC(9,3)
);