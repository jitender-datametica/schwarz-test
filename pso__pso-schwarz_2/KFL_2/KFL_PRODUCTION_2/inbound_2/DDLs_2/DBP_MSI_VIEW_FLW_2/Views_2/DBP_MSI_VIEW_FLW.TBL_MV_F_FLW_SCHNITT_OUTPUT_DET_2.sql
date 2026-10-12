CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_SCHNITT_OUTPUT_DET_2
-- 26.10.2011 system_id entfernt
-- 08.12.2011 AL Einschraenkung auf sek_schl_typ_id in ('M', 'P')
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, in_art_id
, schnitt_id
, sek_schl_typ_id
, sek_schl_id
, schnitt_pos_id
, menge_schnitt
, wrg_id
, default_wrg
, betrag_schnitt_output
, dat_kalk_ab_v02
, dat_kalk_ab_v03


)

AS
   SELECT
   v01.mandant_id, 
   v01.flw_art_id AS in_art_id, 
   v01.schnitt_id, 
   v01.sek_schl_typ_id, 
   v01.sek_schl_id, 
   v01.schnitt_pos_id, 
   v01.menge_schnitt,
   v01.wrg_id,
   v100.default_wrg, 
   v01.betrag_schnitt_output,
   v02.dat_kalk_ab,
   v03.dat_kalk_ab

   FROM dbp_view.v_flw_schnitt_output_det_2 v01

   JOIN dbp_view.v_flw_kalk_material_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.sek_schl_id = v02.materialwert_kalk_id

   LEFT OUTER JOIN dbp_view.v_flw_kalk_plan_2 v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.sek_schl_id = v03.plan_kalk_id

   JOIN dbp_view.v_mandant_2 v100
   ON v01.mandant_id = v100.mandant_id

   WHERE v01.sek_schl_typ_id in ('M', 'P');