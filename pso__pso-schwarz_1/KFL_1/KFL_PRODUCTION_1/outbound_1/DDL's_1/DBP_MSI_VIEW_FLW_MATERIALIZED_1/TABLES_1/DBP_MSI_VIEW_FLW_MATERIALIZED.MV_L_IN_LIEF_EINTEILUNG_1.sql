CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_lief_einteilung_1 (
mandant_id INTEGER,
best_beleg_id INTEGER,
best_beleg_pos_id INTEGER,
charge_id STRING(10) COLLATE 'und:ci',
einteil_id INTEGER,
dat_lief_wunsch DATE,
zeit_lief_wunsch TIME,
datzeit_lief_wunsch DATETIME,
datzeit_lief_wunsch_az DATETIME
);