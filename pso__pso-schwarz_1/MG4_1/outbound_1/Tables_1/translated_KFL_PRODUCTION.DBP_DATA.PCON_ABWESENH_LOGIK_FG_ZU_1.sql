CREATE OR REPLACE TABLE kfl_production_dbp_data.pcon_abwesenh_logik_fg_zu_1 (
mandant_id INTEGER NOT NULL,
abwesenheit_id STRING(4) COLLATE 'und:ci' NOT NULL,
kjmo_bis INTEGER NOT NULL,
kjmo_von INTEGER NOT NULL,
logik_kz STRING(40) COLLATE 'und:ci' DEFAULT '-1' NOT NULL,
langzeit_abwesend_fg INTEGER DEFAULT 0 NOT NULL,
pflege_fg INTEGER DEFAULT 0 NOT NULL,
beschaeftigungs_verbot_fg INTEGER DEFAULT 0 NOT NULL,
krankheit_unfall_fg INTEGER DEFAULT 0 NOT NULL,
sonstige_abwesenheit_fg INTEGER DEFAULT 0 NOT NULL,
freigestellt_fg INTEGER DEFAULT 0 NOT NULL,
mutterschutz_fg INTEGER DEFAULT 0 NOT NULL,
elternzeit_fg INTEGER DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);