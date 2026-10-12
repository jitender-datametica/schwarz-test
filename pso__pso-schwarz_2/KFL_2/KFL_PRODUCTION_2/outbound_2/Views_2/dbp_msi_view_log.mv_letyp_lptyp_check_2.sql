CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_letyp_lptyp_check_2 (letyp_lptyp_check_id, letyp_lptyp_diff_bez
, letyp_lptyp_diff_bez_de, letyp_lptyp_diff_bez_cz, letyp_lptyp_diff_bez_sk, letyp_lptyp_diff_bez_hr,
letyp_lptyp_diff_bez_pl, letyp_lptyp_diff_bez_ro, letyp_lptyp_diff_bez_bg) AS SELECT 0 AS letyp_lptyp_check_id,
 'Palette im richtigen Fach' AS letyp_lptyp_diff_bez,
 'Palette im richtigen Fach' AS letyp_lptyp_diff_bez_de,
 'Pallet in correct bin' AS letyp_lptyp_diff_bez_cz,
 'Pallet in correct bin' AS letyp_lptyp_diff_bez_sk,
 'Pallet in correct bin' AS letyp_lptyp_diff_bez_hr,
 'Pallet in correct bin' AS letyp_lptyp_diff_bez_pl,
 'Pallet in correct bin' AS letyp_lptyp_diff_bez_ro,
 'Pallet in correct bin' AS letyp_lptyp_diff_bez_bg
UNION ALL
SELECT 1 AS letyp_lptyp_check_id,
 'Palette nicht im richtigen Fach' AS letyp_lptyp_diff_bez,
 'Palette nicht im richtigen Fach' AS letyp_lptyp_diff_bez_de,
 'Pallet not in correct bin' AS letyp_lptyp_diff_bez_cz,
 'Pallet not in correct bin' AS letyp_lptyp_diff_bez_sk,
 'Pallet not in correct bin' AS letyp_lptyp_diff_bez_hr,
 'Pallet not in correct bin' AS letyp_lptyp_diff_bez_pl,
 'Pallet not in correct bin' AS letyp_lptyp_diff_bez_ro,
 'Pallet not in correct bin' AS letyp_lptyp_diff_bez_bg;