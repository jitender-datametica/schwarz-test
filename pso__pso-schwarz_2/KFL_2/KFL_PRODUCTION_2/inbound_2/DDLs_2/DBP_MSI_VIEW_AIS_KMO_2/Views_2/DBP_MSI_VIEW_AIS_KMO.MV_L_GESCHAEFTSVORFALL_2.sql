CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_GESCHAEFTSVORFALL_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 02.02.2022
(
 mandant_id
,geschaeftsvorfall_id
,geschaeftsvorfall_bez
,geschaeftsvorfall_bez_de
,geschaeftsvorfall_bez_cz
,geschaeftsvorfall_bez_sk
,geschaeftsvorfall_bez_hr
,geschaeftsvorfall_bez_pl
,geschaeftsvorfall_bez_ro
,geschaeftsvorfall_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.geschaeftsvorfall_id
,COALESCE(MAX(CASE WHEN v03.spr_id = 22  THEN v03.geschaeftsvorfall_bez END), 'N/A')  AS geschaeftsvorfall_bez
,COALESCE(MAX(CASE WHEN v03.spr_id = 22  THEN v03.geschaeftsvorfall_bez END), 'N/A')  AS geschaeftsvorfall_bez_de
,COALESCE(MAX(CASE WHEN v03.spr_id = 124 THEN v03.geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de)  AS geschaeftsvorfall_bez_cz
,COALESCE(MAX(CASE WHEN v03.spr_id = 108 THEN v03.geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de)  AS geschaeftsvorfall_bez_sk
,COALESCE(MAX(CASE WHEN v03.spr_id = 65  THEN v03.geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de)  AS geschaeftsvorfall_bez_hr
,COALESCE(MAX(CASE WHEN v03.spr_id = 90  THEN v03.geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de)  AS geschaeftsvorfall_bez_pl
,COALESCE(MAX(CASE WHEN v03.spr_id = 95  THEN v03.geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de)  AS geschaeftsvorfall_bez_ro
,COALESCE(MAX(CASE WHEN v03.spr_id = 18  THEN v03.geschaeftsvorfall_bez END), geschaeftsvorfall_bez_de)  AS geschaeftsvorfall_bez_bg

FROM dbp_view.v_l_geschaeftsvorfall_2 v01

JOIN dbp_view.v_geschaeftsvorfall_spr_zu_2 v03
ON v01.geschaeftsvorfall_id = v03.geschaeftsvorfall_id
AND v01.mandant_id = v03.mandant_id

WHERE v01.mandant_id <> 1
GROUP BY
 v01.mandant_id
,v01.geschaeftsvorfall_id
;