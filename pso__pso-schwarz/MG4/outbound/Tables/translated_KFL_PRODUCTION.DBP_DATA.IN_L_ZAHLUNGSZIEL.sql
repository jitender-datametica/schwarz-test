CREATE OR REPLACE TABLE kfl_production_dbp_data.in_l_zahlungsziel (
mandant_id INTEGER NOT NULL,
zahlungsziel_id STRING(4) COLLATE 'und:ci' DEFAULT '-1  ' NOT NULL,
zahlungsziel_1_tage INTEGER DEFAULT 0 NOT NULL,
zahlungsziel_1_prozent NUMERIC(9,3) DEFAULT 0 NOT NULL,
zahlungsziel_2_tage INTEGER DEFAULT 0 NOT NULL,
zahlungsziel_2_prozent NUMERIC(9,3) DEFAULT 0 NOT NULL,
zahlungsziel_3_tage INTEGER DEFAULT 0 NOT NULL,
zahlungsziel_max_tage INTEGER DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);