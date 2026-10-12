CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_BELEGTYP_1
AS
   SELECT
   v01.mandant_id, v01.flw_beleg_typ_id

   FROM dbp_view.v_flw_l_belegtyp_1 v01

   WHERE v01.mandant_id in (1,2);