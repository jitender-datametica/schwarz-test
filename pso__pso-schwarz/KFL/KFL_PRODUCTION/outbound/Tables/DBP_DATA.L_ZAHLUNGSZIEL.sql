CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_zahlungsziel (
mandant_id BIGNUMERIC(38,0) NOT NULL,
zahlungsziel_id STRING(4) COLLATE 'und:ci' NOT NULL,
zahlungsziel_1_tage BIGNUMERIC(38,0),
zahlungsziel_1_prozent NUMERIC(9,3),
zahlungsziel_2_tage BIGNUMERIC(38,0),
zahlungsziel_2_prozent NUMERIC(9,3),
zahlungsziel_3_tage BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);