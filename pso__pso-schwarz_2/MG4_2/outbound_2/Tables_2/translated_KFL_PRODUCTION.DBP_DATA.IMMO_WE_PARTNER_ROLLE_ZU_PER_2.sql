CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_we_partner_rolle_zu_per_2 (
mandant_id INTEGER NOT NULL,
we_intreno STRING(20) NOT NULL,
rolle_kz STRING(7) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
partner_id STRING(10) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);