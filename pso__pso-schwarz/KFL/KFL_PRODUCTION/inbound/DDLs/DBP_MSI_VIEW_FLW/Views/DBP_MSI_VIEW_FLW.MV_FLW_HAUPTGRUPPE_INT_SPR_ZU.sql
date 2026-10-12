CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_HAUPTGRUPPE_INT_SPR_ZU
AS

   SELECT    v01.hauptgruppe_id AS hauptgruppe_int_id, v01.hauptgruppe_bez
   FROM dbp_view.v_flw_hauptgruppe_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
   WHERE
   v01.mandant_id  = 2;