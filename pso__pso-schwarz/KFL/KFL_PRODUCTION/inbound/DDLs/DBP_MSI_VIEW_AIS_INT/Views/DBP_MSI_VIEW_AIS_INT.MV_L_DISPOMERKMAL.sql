CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_DISPOMERKMAL
--SPEC0209335, 31.07.2023: Initial creation on DBP_MSI_VIEW_AIS_INT
(
 dispomerkmal
,dispomerkmal_bez
,dispomerkmal_bez_de
,dispomerkmal_bez_cz
,dispomerkmal_bez_sk
,dispomerkmal_bez_hr
,dispomerkmal_bez_pl
,dispomerkmal_bez_ro
,dispomerkmal_bez_bg
)

AS
SELECT 
 dispomerkmal
,COALESCE(MAX(CASE WHEN spr_id = 22  THEN dispomerkmal_bez END), 'N/A')  AS dispomerkmal_bez
,COALESCE(MAX(CASE WHEN spr_id = 22  THEN dispomerkmal_bez END), 'N/A')  AS dispomerkmal_bez_de
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN dispomerkmal_bez END), dispomerkmal_bez_de)  AS dispomerkmal_bez_cz
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN dispomerkmal_bez END), dispomerkmal_bez_de)  AS dispomerkmal_bez_sk
,COALESCE(MAX(CASE WHEN spr_id = 65  THEN dispomerkmal_bez END), dispomerkmal_bez_de)  AS dispomerkmal_bez_hr
,COALESCE(MAX(CASE WHEN spr_id = 90  THEN dispomerkmal_bez END), dispomerkmal_bez_de)  AS dispomerkmal_bez_pl
,COALESCE(MAX(CASE WHEN spr_id = 95  THEN dispomerkmal_bez END), dispomerkmal_bez_de)  AS dispomerkmal_bez_ro
,COALESCE(MAX(CASE WHEN spr_id = 18  THEN dispomerkmal_bez END), dispomerkmal_bez_de)  AS dispomerkmal_bez_bg
FROM dbp_view.v_dispomerkmal_spr_zu

GROUP BY
 dispomerkmal
;