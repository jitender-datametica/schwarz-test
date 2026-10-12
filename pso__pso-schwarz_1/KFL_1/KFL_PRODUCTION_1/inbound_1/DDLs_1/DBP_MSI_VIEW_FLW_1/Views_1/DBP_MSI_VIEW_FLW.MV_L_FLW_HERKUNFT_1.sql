CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_HERKUNFT_1
AS
   SELECT
   v01.mandant_id, v01.herkunft_id

   FROM dbp_view.v_flw_l_herkunft_1 v01

   WHERE v01.mandant_id in (1,2);