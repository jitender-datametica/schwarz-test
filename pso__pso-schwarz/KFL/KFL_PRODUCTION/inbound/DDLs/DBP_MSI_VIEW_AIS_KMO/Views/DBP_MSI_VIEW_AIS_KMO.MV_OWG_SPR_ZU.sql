CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_OWG_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 01.02.2022
(
 owg_id
,arthiertyp_id
,mandant_id
,owg_bez
,owg_bez_de
,owg_bez_cz
,owg_bez_sk
,owg_bez_hr
,owg_bez_pl
,owg_bez_ro
,owg_bez_bg
)

AS 
SELECT 
 owg_id
,arthiertyp_id
,mandant_id
,COALESCE(Max(CASE WHEN spr_id =  22 THEN owg_bez END), 'N/A') AS owg_bez
,COALESCE(Max(CASE WHEN spr_id =  22 THEN owg_bez END), 'N/A') AS owg_bez_de
,COALESCE(Max(CASE WHEN spr_id = 124 THEN owg_bez END), owg_bez_de) AS owg_bez_cz
,COALESCE(Max(CASE WHEN spr_id = 108 THEN owg_bez END), owg_bez_de) AS owg_bez_sk
,COALESCE(Max(CASE WHEN spr_id =  65 THEN owg_bez END), owg_bez_de) AS owg_bez_hr
,COALESCE(Max(CASE WHEN spr_id =  90 THEN owg_bez END), owg_bez_de) AS owg_bez_pl
,COALESCE(Max(CASE WHEN spr_id =  95 THEN owg_bez END), owg_bez_de) AS owg_bez_ro
,COALESCE(Max(CASE WHEN spr_id =  18 THEN owg_bez END), owg_bez_de) AS owg_bez_bg
FROM dbp_view.v_owg_spr_zu

WHERE mandant_id <> 1

GROUP BY
 owg_id
,arthiertyp_id
,mandant_id;