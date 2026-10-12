CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_AUTODISPOCLUSTER
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 02.02.2022
(
 mandant_id
,autodispo_id
,autodispo_bez
,autodispo_bez_de
,autodispo_bez_cz
,autodispo_bez_sk
,autodispo_bez_hr
,autodispo_bez_pl
,autodispo_bez_ro
,autodispo_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.wg_hierarchie_id  AS autodispo_id
,COALESCE(MAX(CASE WHEN v02.spr_id = 22  THEN v02.wg_hierarchie_bez END), 'N/A')  AS autodispo_bez
,COALESCE(MAX(CASE WHEN v02.spr_id = 22  THEN v02.wg_hierarchie_bez END), 'N/A')  AS autodispo_bez_de
,COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.wg_hierarchie_bez END), autodispo_bez_de)  AS autodispo_bez_cz
,COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.wg_hierarchie_bez END), autodispo_bez_de)  AS autodispo_bez_sk
,COALESCE(MAX(CASE WHEN v02.spr_id = 65  THEN v02.wg_hierarchie_bez END), autodispo_bez_de)  AS autodispo_bez_hr
,COALESCE(MAX(CASE WHEN v02.spr_id = 90  THEN v02.wg_hierarchie_bez END), autodispo_bez_de)  AS autodispo_bez_pl
,COALESCE(MAX(CASE WHEN v02.spr_id = 95  THEN v02.wg_hierarchie_bez END), autodispo_bez_de)  AS autodispo_bez_ro
,COALESCE(MAX(CASE WHEN v02.spr_id = 18  THEN v02.wg_hierarchie_bez END), autodispo_bez_de)  AS autodispo_bez_bg
FROM dbp_view.v_wg_hierarchie_zu_per v01

INNER JOIN
dbp_view.v_wg_hierarchie_spr_zu v02
ON  v01.mandant_id = v02.mandant_id
AND v01.wg_hierarchie_id = v02.wg_hierarchie_id
AND v01.wg_hierarchie_ebene_id = v02.wg_hierarchie_ebene_id
AND v01.arthiertyp_id = v02.arthiertyp_id

WHERE v01.arthiertyp_id = 9
AND v01.mandant_id <> 1
AND v01.wg_hierarchie_ebene_id = 1
AND v01.dat_bis = '9999-12-31'

GROUP BY
 v01.mandant_id
,v01.wg_hierarchie_id
;