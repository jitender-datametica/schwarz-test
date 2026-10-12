CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bewart_det_spr_zu_2 (
mandant_id BIGNUMERIC NOT NULL,
bewart_det_id BIGNUMERIC DEFAULT 9999 NOT NULL,
spr_id BIGNUMERIC NOT NULL,
bewart_det_bez STRING(70),
td_update TIMESTAMP,
td_insert TIMESTAMP
);