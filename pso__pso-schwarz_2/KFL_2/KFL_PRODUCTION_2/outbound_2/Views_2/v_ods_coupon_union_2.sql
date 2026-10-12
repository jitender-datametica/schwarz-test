CREATE OR REPLACE VIEW kfl_production_dbp_spezial.v_ods_coupon_union_2 (bon_id, bon_zeile, coupon_id, coupon_zeile,
coupon_menge, coupon_betrag, coupon_kz, mandant_id, wup_id, bon_dat) AS SELECT bon_id,
 bon_zeile,
 coupon_id,
 coupon_zeile,
 coupon_menge,
 coupon_betrag,
 coupon_kz,
 mandant_id,
 wup_id,
 bon_dat
FROM kfl_production_dbp_ods.ods_coupon_2
UNION ALL
SELECT bon_id,
 bon_zeile,
 coupon_id,
 coupon_zeile,
 coupon_menge,
 coupon_betrag,
 coupon_kz,
 mandant_id,
 wup_id,
 bon_dat
FROM kfl_production_dbp_ods_archiv.ods_coupon_2;