CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods_archiv.ods_coupon_1 (
bon_id STRING(100) NOT NULL,
bon_zeile BIGNUMERIC(38,0) NOT NULL,
coupon_id INTEGER NOT NULL,
coupon_zeile BIGNUMERIC(38,0) NOT NULL,
coupon_menge NUMERIC(18,3) DEFAULT 0 NOT NULL,
coupon_betrag NUMERIC(18,4) NOT NULL,
coupon_kz BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
bon_dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);