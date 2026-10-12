CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_coupon_2 AS SELECT bon_id,
 bon_zeile,
 coupon_id,
 coupon_zeile,
 coupon_menge,
 coupon_betrag,
 coupon_kz,
 mandant_id,
 wup_id,
 bon_dat,
 coupon_serien_id,
 td_insert,
 td_update
FROM kfl_production_dbp_ods.ods_coupon_2;