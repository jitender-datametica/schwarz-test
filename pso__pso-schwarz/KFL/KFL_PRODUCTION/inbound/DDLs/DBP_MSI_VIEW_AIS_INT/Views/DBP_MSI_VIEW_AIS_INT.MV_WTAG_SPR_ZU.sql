CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_WTAG_SPR_ZU(
	WTAG_ID,
	WTAG_BEZ,
	WTAG_BEZ_DE,
	WTAG_BEZ_CZ,
	WTAG_BEZ_SK,
	WTAG_BEZ_HR,
	WTAG_BEZ_PL,
	WTAG_BEZ_RO,
	WTAG_BEZ_BG
) AS
-- SPEC0244443, prescherad, 16.04.2024, Neuanlage 
SELECT
 v01.wtag_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wtag_bez END), 'N/A') AS wtag_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wtag_bez END), 'N/A') AS wtag_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_bg
FROM dbp_view.v_wtag_spr_zu v01
GROUP BY
v01.wtag_id
;