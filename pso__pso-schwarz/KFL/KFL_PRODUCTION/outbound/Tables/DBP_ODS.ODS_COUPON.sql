CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_coupon (
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
coupon_serien_id STRING(80) DEFAULT '' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='ODS - Bon- Coupondaten aus den Kassensystemen. Eine Bonzeile kann zu n Coupons gehören');