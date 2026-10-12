CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_coupon_2 (
bon_id STRING(100) NOT NULL,
bon_zeile INTEGER NOT NULL,
coupon_id INTEGER NOT NULL,
coupon_zeile INTEGER NOT NULL,
coupon_menge NUMERIC(18,3) DEFAULT 0 NOT NULL,
coupon_betrag NUMERIC(18,4) NOT NULL,
coupon_kz INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
bon_dat DATE NOT NULL,
coupon_serien_id STRING(80) DEFAULT '' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='ODS - Bon- Coupondaten aus den Kassensystemen. Eine_2 Bonzeile kann zu n Coupons gehören');