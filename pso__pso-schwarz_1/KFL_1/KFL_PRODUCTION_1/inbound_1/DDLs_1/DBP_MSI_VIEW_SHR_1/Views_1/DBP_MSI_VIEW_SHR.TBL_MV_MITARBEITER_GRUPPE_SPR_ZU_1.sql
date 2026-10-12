CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.TBL_MV_MITARBEITER_GRUPPE_SPR_ZU_1
(
mandant_id
, mitarbeiter_gruppe_id
, mitarbeiter_gruppe_bez
, spr_id
)
AS
   SELECT
   v01.mandant_id, v01.mitarbeiter_gruppe_id, v01.mitarbeiter_gruppe_bez, v01.spr_id

   FROM dbp_view.v_mitarbeiter_gruppe_spr_zu_1 v01

   --JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   --ON v01.spr_id = v02.spr_id
   -- WHERE v01.spr_id = 22
   ;