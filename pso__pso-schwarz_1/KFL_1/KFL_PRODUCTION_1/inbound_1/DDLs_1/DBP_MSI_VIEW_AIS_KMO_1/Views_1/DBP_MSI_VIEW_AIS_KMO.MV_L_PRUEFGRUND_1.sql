CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_PRUEFGRUND_1
-- EK-3243293 Änderung pruef_ids / 19.02.2013 sschuecke
-- RITM0354239 Erweiterung Exceptions 250/252 / 17.05.2017 sschuecke
--SPEC0044639 Erweiterung pruef_id 700,001,005/lsvi0303
--SPEC0044639 Erweiterung pruef_id 002/lsvi0303
--SPEC0070820 Änderung pruef_id 253/nwag2310
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_1 / ssch1303 02.02.2022
--INC4333473, dknop, removing pruef_bez from grouping
--SPEC0147775 Erweiterung pruef_id 254/richternic
(
 pruef_id
,mandant_id
,pruef_bez
,pruef_bez_de
,pruef_bez_cz
,pruef_bez_sk
,pruef_bez_hr
,pruef_bez_pl
,pruef_bez_ro
,pruef_bez_bg
,z_arbeitsgebiet_id
)

AS
SELECT
 v01.pruef_id
,v01.mandant_id
,COALESCE(MAX(CASE WHEN v01.spr_id = 22  THEN v01.pruef_bez END), 'N/A')  AS pruef_bez
,COALESCE(MAX(CASE WHEN v01.spr_id = 22  THEN v01.pruef_bez END), 'N/A')  AS pruef_bez_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.pruef_bez END), pruef_bez_de)  AS pruef_bez_cz
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.pruef_bez END), pruef_bez_de)  AS pruef_bez_sk
,COALESCE(MAX(CASE WHEN v01.spr_id = 65  THEN v01.pruef_bez END), pruef_bez_de)  AS pruef_bez_hr
,COALESCE(MAX(CASE WHEN v01.spr_id = 90  THEN v01.pruef_bez END), pruef_bez_de)  AS pruef_bez_pl
,COALESCE(MAX(CASE WHEN v01.spr_id = 95  THEN v01.pruef_bez END), pruef_bez_de)  AS pruef_bez_ro
,COALESCE(MAX(CASE WHEN v01.spr_id = 18  THEN v01.pruef_bez END), pruef_bez_de)  AS pruef_bez_bg
,v01.z_arbeitsgebiet_id
FROM dbp_view.v_l_pruefgrund_1 v01

WHERE v01.pruef_id IN (202,203,205,206,207,209,210,214,216,218,223,225,231,700)
AND v01.mandant_id > 1
AND v01.z_arbeitsgebiet_id = 1

OR (v01.mandant_id > 1
AND v01.pruef_id IN (250,252,001,005,002,253,254)
AND v01.z_arbeitsgebiet_id = 0)
GROUP BY
 v01.pruef_id
,v01.mandant_id
,v01.z_arbeitsgebiet_id
;