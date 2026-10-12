CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_OWG_SPR_ZU_CZ_1
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
   v01.owg_id, v01.arthiertyp_id, v01.mandant_id, v01.spr_id, v01.owg_bez, CASE WHEN v01.owg_id < 0 THEN TO_VARCHAR(v01.owg_id, 'FM0000')
   ELSE TO_VARCHAR(v01.owg_id, 'FM0000')
   END || ' ' || v01.owg_bez AS owg_id_bez
   FROM dbp_view.v_owg_spr_zu_1 v01
   WHERE v01.spr_id = 124
   AND v01.arthiertyp_id = 2
   AND v01.owg_id >= 0;