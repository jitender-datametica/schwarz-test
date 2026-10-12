CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_LETYP_LPTYP_DIF_1(
	LETYP_LPTYP_DIFF_ID,
	LETYP_LPTYP_CHECK_ID,
	SIZE_IS_AV_FG,
	LETYP_LPTYP_DIFF_BEZ,
	LETYP_LPTYP_DIFF_BEZ_DE,
	LETYP_LPTYP_DIFF_BEZ_CZ,
	LETYP_LPTYP_DIFF_BEZ_SK,
	LETYP_LPTYP_DIFF_BEZ_HR,
	LETYP_LPTYP_DIFF_BEZ_PL,
	LETYP_LPTYP_DIFF_BEZ_RO,
	LETYP_LPTYP_DIFF_BEZ_BG
) AS
--2023-12-20, dknop, AP0201997, SPEC0229692, initial

SELECT  
  0   AS letyp_lptyp_diff_id
, 0   AS letyp_lptyp_check_id
, 1   AS size_is_av_fg
,'OK' AS letyp_lptyp_diff_bez
,'OK' AS letyp_lptyp_diff_bez_de
,'OK' AS letyp_lptyp_diff_bez_cz
,'OK' AS letyp_lptyp_diff_bez_sk
,'OK' AS letyp_lptyp_diff_bez_hr
,'OK' AS letyp_lptyp_diff_bez_pl
,'OK' AS letyp_lptyp_diff_bez_ro
,'OK' AS letyp_lptyp_diff_bez_bg

UNION

SELECT  
  1       AS letyp_lptyp_diff_id
, 0       AS letyp_lptyp_check_id  
, 0       AS size_is_av_fg
,'plus 1 / passender LPTYP nicht verfügbar' AS letyp_lptyp_diff_bez
,'plus 1 / correct LPTYP not available' AS letyp_lptyp_diff_bez_de
,'plus 1 / correct LPTYP not available' AS letyp_lptyp_diff_bez_cz
,'plus 1 / correct LPTYP not available' AS letyp_lptyp_diff_bez_sk
,'plus 1 / correct LPTYP not available' AS letyp_lptyp_diff_bez_hr
,'plus 1 / correct LPTYP not available' AS letyp_lptyp_diff_bez_pl
,'plus 1 / correct LPTYP not available' AS letyp_lptyp_diff_bez_ro
,'plus 1 / correct LPTYP not available' AS letyp_lptyp_diff_bez_bg

UNION

SELECT  
  1       AS letyp_lptyp_diff_id
, 1       AS letyp_lptyp_check_id  
, 1       AS size_is_av_fg
,'plus 1' AS letyp_lptyp_diff_bez
,'plus 1' AS letyp_lptyp_diff_bez_de
,'plus 1' AS letyp_lptyp_diff_bez_cz
,'plus 1' AS letyp_lptyp_diff_bez_sk
,'plus 1' AS letyp_lptyp_diff_bez_hr
,'plus 1' AS letyp_lptyp_diff_bez_pl
,'plus 1' AS letyp_lptyp_diff_bez_ro
,'plus 1' AS letyp_lptyp_diff_bez_bg

UNION

SELECT  
 2              AS letyp_lptyp_diff_id
,1              AS letyp_lptyp_check_id
,0              AS size_is_av_fg
,'größer 1'     AS letyp_lptyp_diff_bez
,'größer 1'     AS letyp_lptyp_diff_bez_de
,'bigger than 1'AS letyp_lptyp_diff_bez_cz
,'bigger than 1'AS letyp_lptyp_diff_bez_sk
,'bigger than 1'AS letyp_lptyp_diff_bez_hr
,'bigger than 1'AS letyp_lptyp_diff_bez_pl
,'bigger than 1'AS letyp_lptyp_diff_bez_ro
,'bigger than 1'AS letyp_lptyp_diff_bez_bg

UNION

SELECT  
 2              AS letyp_lptyp_diff_id
,1              AS letyp_lptyp_check_id
,1              AS size_is_av_fg
,'größer 1'     AS letyp_lptyp_diff_bez
,'größer 1'     AS letyp_lptyp_diff_bez_de
,'bigger than 1'AS letyp_lptyp_diff_bez_cz
,'bigger than 1'AS letyp_lptyp_diff_bez_sk
,'bigger than 1'AS letyp_lptyp_diff_bez_hr
,'bigger than 1'AS letyp_lptyp_diff_bez_pl
,'bigger than 1'AS letyp_lptyp_diff_bez_ro
,'bigger than 1'AS letyp_lptyp_diff_bez_bg

;