CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_zahlungsziel (
mandant_id BIGNUMERIC(38,0) NOT NULL,
zahlungsziel_id STRING(4) COLLATE 'und:ci' DEFAULT '-1  ' NOT NULL,
zahlungsziel_1_tage BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
zahlungsziel_1_prozent NUMERIC(9,3) DEFAULT 0 NOT NULL,
zahlungsziel_2_tage BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
zahlungsziel_2_prozent NUMERIC(9,3) DEFAULT 0 NOT NULL,
zahlungsziel_3_tage BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
zahlungsziel_max_tage BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);