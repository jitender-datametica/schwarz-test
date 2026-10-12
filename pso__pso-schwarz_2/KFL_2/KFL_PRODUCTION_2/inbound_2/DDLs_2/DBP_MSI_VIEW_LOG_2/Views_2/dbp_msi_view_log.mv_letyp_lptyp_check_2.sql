CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_LETYP_LPTYP_CHECK_2(
	LETYP_LPTYP_CHECK_ID,
	LETYP_LPTYP_DIFF_BEZ,
	LETYP_LPTYP_DIFF_BEZ_DE,
	LETYP_LPTYP_DIFF_BEZ_CZ,
	LETYP_LPTYP_DIFF_BEZ_SK,
	LETYP_LPTYP_DIFF_BEZ_HR,
	LETYP_LPTYP_DIFF_BEZ_PL,
	LETYP_LPTYP_DIFF_BEZ_RO,
	LETYP_LPTYP_DIFF_BEZ_BG
) AS
--2023-12-21, dknop, AP0201997, SPEC0229692, initial
SELECT  
  0   AS letyp_lptyp_check_id
,'Palette im richtigen Fach' AS letyp_lptyp_diff_bez
,'Palette im richtigen Fach' AS letyp_lptyp_diff_bez_de
,'Pallet in correct bin' AS letyp_lptyp_diff_bez_cz
,'Pallet in correct bin' AS letyp_lptyp_diff_bez_sk
,'Pallet in correct bin' AS letyp_lptyp_diff_bez_hr
,'Pallet in correct bin' AS letyp_lptyp_diff_bez_pl
,'Pallet in correct bin' AS letyp_lptyp_diff_bez_ro
,'Pallet in correct bin' AS letyp_lptyp_diff_bez_bg

UNION

SELECT  
  1   AS letyp_lptyp_check_id
,'Palette nicht im richtigen Fach' AS letyp_lptyp_diff_bez
,'Palette nicht im richtigen Fach' AS letyp_lptyp_diff_bez_de
,'Pallet not in correct bin' AS letyp_lptyp_diff_bez_cz
,'Pallet not in correct bin' AS letyp_lptyp_diff_bez_sk
,'Pallet not in correct bin' AS letyp_lptyp_diff_bez_hr
,'Pallet not in correct bin' AS letyp_lptyp_diff_bez_pl
,'Pallet not in correct bin' AS letyp_lptyp_diff_bez_ro
,'Pallet not in correct bin' AS letyp_lptyp_diff_bez_bg

;