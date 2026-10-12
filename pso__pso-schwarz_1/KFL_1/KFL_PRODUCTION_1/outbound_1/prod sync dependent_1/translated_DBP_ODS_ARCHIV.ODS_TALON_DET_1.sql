CREATE OR REPLACE TABLE kfl_production_dbp_ods_archiv.ods_talon_det_1 (
mandant_id INTEGER NOT NULL,
talon_id NUMERIC(29,0) NOT NULL,
talon_pos_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
kl_art_id INTEGER,
umsatz_brutto NUMERIC(29,4) DEFAULT 0 NOT NULL,
menge NUMERIC(29,3) DEFAULT 0 NOT NULL,
mwst NUMERIC(29,4) DEFAULT 0 NOT NULL,
wg_id INTEGER,
turnover_fg INTEGER DEFAULT 1 NOT NULL,
artbew_fg INTEGER DEFAULT 0 NOT NULL,
aktion_id STRING(10) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);