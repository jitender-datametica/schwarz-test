CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_SCHNITT_KOSTEN_1
-- 26.10.2011 system_id entfernt
-- 07.12.2011 MR Einschraenkung auf sek_schl_typ_id in ('M', 'P')
(
mandant_id
--, system_id
, schnitt_id
, sek_schl_typ_id
, sek_schl_id
, input_typ_id
, kosten_block_id
, default_wrg
, fertig_einzel_kosten_kg
, wrg_id
, dat_kalk_ab_v02
, dat_kalk_ab_v03
)
AS
   SELECT
   v01.mandant_id, 
   v01.schnitt_id, 
   v01.sek_schl_typ_id, 
   v01.sek_schl_id, 
   v01.input_typ_id, 
   v01.kosten_block_id,
   v100.default_wrg, 
   v01.fertig_einzel_kosten_kg,
   v01.wrg_id,
   v02.dat_kalk_ab,
   v03.dat_kalk_ab

   FROM dbp_view.v_flw_schnitt_kosten_1 v01

   JOIN dbp_view.v_flw_kalk_material_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.sek_schl_id = v02.materialwert_kalk_id

   LEFT OUTER JOIN dbp_view.v_flw_kalk_plan_1 v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.sek_schl_id = v03.plan_kalk_id

   JOIN dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id

   WHERE  v01.sek_schl_typ_id in ('M', 'P');