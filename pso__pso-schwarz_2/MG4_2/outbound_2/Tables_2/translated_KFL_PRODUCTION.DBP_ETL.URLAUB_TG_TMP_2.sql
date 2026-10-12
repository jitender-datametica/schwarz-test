CREATE OR REPLACE TABLE kfl_production_dbp_etl.urlaub_tg_tmp_2 (
mandant_id INTEGER NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo INTEGER NOT NULL,
urlaub_tage NUMERIC(9,2),
urlaub_arbeitstage NUMERIC(9,2)
) OPTIONS(description='Arbeitstabelle fuer SHR_AGG, bitte nicht loeschen');