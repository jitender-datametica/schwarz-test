CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_KALK_VARIANTE_2
AS
   SELECT
   v01.mandant_id, v01.kalk_variante_id

   FROM dbp_view.v_flw_l_kalk_variante_2 v01;