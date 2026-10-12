CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_REGALACHSE_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 mandant_id
,fbb_nr
,regalachse_bez
,regalachse_bez_de
,regalachse_bez_cz
,regalachse_bez_sk
,regalachse_bez_hr
,regalachse_bez_pl
,regalachse_bez_ro
,regalachse_bez_bg
,dat_bis_neu
)

AS
SELECT
 v01.mandant_id
,v01.fbb_nr
,COALESCE(Max(CASE WHEN v02.spr_id =  22 THEN v02.layoutbaustein_bez END), 'N/A') AS regalachse_bez
,COALESCE(Max(CASE WHEN v02.spr_id =  22 THEN v02.layoutbaustein_bez END), 'N/A') AS regalachse_bez_de
,COALESCE(Max(CASE WHEN v02.spr_id = 124 THEN v02.layoutbaustein_bez END), regalachse_bez_de) AS regalachse_bez_cz
,COALESCE(Max(CASE WHEN v02.spr_id = 108 THEN v02.layoutbaustein_bez END), regalachse_bez_de) AS regalachse_bez_sk
,COALESCE(Max(CASE WHEN v02.spr_id =  65 THEN v02.layoutbaustein_bez END), regalachse_bez_de) AS regalachse_bez_hr
,COALESCE(Max(CASE WHEN v02.spr_id =  90 THEN v02.layoutbaustein_bez END), regalachse_bez_de) AS regalachse_bez_pl
,COALESCE(Max(CASE WHEN v02.spr_id =  95 THEN v02.layoutbaustein_bez END), regalachse_bez_de) AS regalachse_bez_ro
,COALESCE(Max(CASE WHEN v02.spr_id =  18 THEN v02.layoutbaustein_bez END), regalachse_bez_de) AS regalachse_bez_bg
,CASE WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND v01.dat_bis <> '9999-12-31' THEN v01.dat_bis +150 ELSE dat_bis END AS dat_bis_neu

FROM dbp_view.v_regalachse_2  v01

JOIN dbp_view.v_layoutbaustein_spr_zu_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.layoutbaustein_id = v02.layoutbaustein_id

WHERE v01.mandant_id <> 1
AND dat_bis_neu >= CURRENT_DATE

GROUP BY v01.mandant_id
,v01.fbb_nr
,v02.layoutbaustein_bez
,v01.dat_bis

QUALIFY ROW_NUMBER() OVER (PARTITION BY v01.mandant_id,v01.fbb_nr ORDER BY dat_bis_neu DESC NULLS LAST) = 1
;