CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_SCHNITT_INPUT
-- 26.10.2011 system_id entfernt
-- 07.12.2011 AL Einschraenkung auf sek_schl_typ_id in ('M', 'P')
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, schnitt_id
, sek_schl_typ_id
, sek_schl_id
, in_art_id
, werk_id
, dat_von
, dat_bis
, default_wrg
, wrg_id_v01
, material_einzel_kosten

)
AS
   SELECT
   mandant_id, 
   schnitt_id, 
   sek_schl_typ_id, 
   sek_schl_id, 
   flw_art_id AS in_art_id, 
   werk_id, 
   dat_von, 
   dat_bis, 
   default_wrg,
   wrg_id,
   material_einzel_kosten

   FROM
   (
   SELECT
   v01.mandant_id, 
   v01.schnitt_id, 
   v01.sek_schl_typ_id, 
   v01.sek_schl_id, 
   v01.flw_art_id, 
   v01.werk_id, 
   v01.dat_von, 
   v01.dat_bis, 
   v100.default_wrg,
   v01.wrg_id,
   v01.material_einzel_kosten

   FROM dbp_view.v_flw_schnitt_input v01

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id

   WHERE v01.sek_schl_typ_id in ('M', 'P')
   ) dt1;
