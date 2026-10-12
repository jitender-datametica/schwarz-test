CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_TIERKATEGORIE
AS
   SELECT
   v01.mandant_id, v01.werk_id, v01.tierkategorie_id

   FROM dbp_view.v_flw_l_tierkategorie v01
   WHERE v01.mandant_id in (1,2);