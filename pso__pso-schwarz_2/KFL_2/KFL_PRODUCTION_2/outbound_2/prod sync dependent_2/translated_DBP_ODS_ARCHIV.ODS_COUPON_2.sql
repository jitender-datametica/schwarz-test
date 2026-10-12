CREATE OR REPLACE TABLE kfl_production_dbp_ods_archiv.ods_coupon_2 (
bon_id STRING(100) NOT NULL,
bon_zeile INTEGER NOT NULL,
coupon_id INTEGER NOT NULL,
coupon_zeile INTEGER NOT NULL,
coupon_menge NUMERIC(29,3) DEFAULT 0 NOT NULL,
coupon_betrag NUMERIC(29,4) NOT NULL,
coupon_kz INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
bon_dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);