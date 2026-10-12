CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_crm_ebene_3_spr_zu_1
-- 04.06.2020 lsvi0303: Initial AP0048480, SPEC0075325
AS
SELECT

v01.ebene_3_id,
MAX(CASE WHEN v01.spr_id =   22 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez   --standard=deutsch
,
MAX(CASE WHEN v01.spr_id = 124 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_cz,
MAX(CASE WHEN v01.spr_id =   90 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_pl,
MAX(CASE WHEN v01.spr_id = 108 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_sk,
MAX(CASE WHEN v01.spr_id =   65 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_hr,
MAX(CASE WHEN v01.spr_id =   95 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_ro,
MAX(CASE WHEN v01.spr_id =   18 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_bg
FROM dbp_view.v_crm_themenbaum_lv2_spr_zu_1 v01

GROUP BY v01.ebene_3_id;