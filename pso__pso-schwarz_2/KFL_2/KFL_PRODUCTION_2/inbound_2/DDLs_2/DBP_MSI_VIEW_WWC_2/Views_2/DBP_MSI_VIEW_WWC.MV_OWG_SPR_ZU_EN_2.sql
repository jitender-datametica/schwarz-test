CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_OWG_SPR_ZU_EN_2
-- 05.04.2018, AP0021792, srom: OWG Umstellung
-- 29.12.2020, AP0078017/SPEC0097095 snik1809 - change all views with a filter owg_id >=0
(
owg_id
,arthiertyp_id
,mandant_id
,spr_id
,owg_bez
,owg_id_bez
)
AS
   SELECT
   v01.owg_id, v01.arthiertyp_id, v01.mandant_id, MAX(v01.spr_id) AS spr_id, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.owg_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.owg_bez END)
   ) AS owg_bez, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN CASE WHEN v01.owg_id < 0 THEN TO_VARCHAR(v01.owg_id, 'FM0000')
   ELSE TO_VARCHAR(v01.owg_id, 'FM0000')
   END || ' ' || v01.owg_bez
   END),
   MAX(CASE WHEN v01.spr_id = 22 THEN CASE WHEN v01.owg_id < 0 THEN TO_VARCHAR(v01.owg_id, 'FM0000')
   ELSE TO_VARCHAR(v01.owg_id, 'FM0000')
   END || ' ' || v01.owg_bez
   END)
   ) AS owg_id_bez
   FROM dbp_view.v_owg_spr_zu_2 v01
   WHERE v01.spr_id IN (22,24)
   AND v01.arthiertyp_id = 2
   AND v01.owg_id >= 0
   GROUP BY v01.owg_id
   ,v01.mandant_id
   ,v01.arthiertyp_id;