CREATE OR REPLACE TABLE kfl_production_dbp_etl.hr_kennz_abw_eltern_2 (
mandant_id INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
beschaeftigungs_verbot_fg INTEGER,
elternzeit_fg INTEGER,
mutterschutz_fg INTEGER,
tage_verbot NUMERIC(9,2),
tage_eltern NUMERIC(9,2),
tage_muschu NUMERIC(9,2),
kalendertage_monat INTEGER,
endda DATE,
beginn_muschu DATE,
beginn_eltern DATE,
tage_0210 NUMERIC(9,2),
beginn_0210 DATE
);