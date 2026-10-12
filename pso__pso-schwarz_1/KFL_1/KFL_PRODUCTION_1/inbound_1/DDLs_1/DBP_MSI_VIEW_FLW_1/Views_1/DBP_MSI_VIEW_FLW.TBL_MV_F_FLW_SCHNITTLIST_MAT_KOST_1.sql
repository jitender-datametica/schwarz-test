CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_SCHNITTLIST_MAT_KOST_1
-- 26.10.2011 system_id entfernt
-- 07.12.2011 AL Einschraenkung auf sek_schl_typ_id in ('M', 'P')
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, schnittliste_id
, sek_schl_typ_id
, sek_schl_id
, in_art_id
, input_material_typ_id
, kosten_block_id
, wrg_id
, default_wrg
, intern_var_kosten
, dat_kalk_ab_v02
, dat_kalk_ab_v03
)
AS
   SELECT
   v01.mandant_id, 
   v01.schnittliste_id, 
   v01.sek_schl_typ_id, 
   v01.sek_schl_id, 
   v01.flw_art_id AS in_art_id, 
   v01.input_material_typ_id, 
   v01.kosten_block_id, 
   v01.wrg_id,
   v100.default_wrg,
   v01.intern_var_kosten,
   v02.dat_kalk_ab,
   v03.dat_kalk_ab

   FROM dbp_view.v_flw_schnittliste_mat_kosten_1 v01
   LEFT OUTER JOIN dbp_view.v_flw_kalk_material_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.sek_schl_id = v02.materialwert_kalk_id
   LEFT OUTER JOIN dbp_view.v_flw_kalk_plan_1 v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.sek_schl_id = v03.plan_kalk_id

   JOIN dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id

   WHERE v01.sek_schl_typ_id in ('M', 'P');