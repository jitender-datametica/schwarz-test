CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_SCHNITT_SPR_ZU_2
-- 26.10.2011 system_id entfernt
-- 08.12.2011 MR Einschraenkung auf sek_schl_typ_id in ('M', 'P')
(
mandant_id
--, system_id
, schnitt_id
, spr_id
, sek_schl_typ_id
, sek_schl_id
, schnitt_bez
)
AS
   SELECT
   v01.mandant_id, v01.schnitt_id, v01.spr_id, v01.sek_schl_typ_id, v01.sek_schl_id, v01.schnitt_bez

   FROM dbp_view.v_flw_schnitt_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.sek_schl_typ_id in ('M', 'P');