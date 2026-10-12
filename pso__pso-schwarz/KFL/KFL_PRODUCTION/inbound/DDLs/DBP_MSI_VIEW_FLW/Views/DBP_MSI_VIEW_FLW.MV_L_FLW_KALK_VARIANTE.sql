CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_KALK_VARIANTE
AS
   SELECT
   v01.mandant_id, v01.kalk_variante_id

   FROM dbp_view.v_flw_l_kalk_variante v01;