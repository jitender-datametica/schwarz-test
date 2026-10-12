CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_L_WRGTYP
AS

   SELECT DISTINCT land_id, wrg_id_land AS wrg_id, 1 AS wrgtyp_id
   FROM dbp_msi_view_ek_int.mv_land
   UNION ALL
   SELECT * FROM (
   SELECT DISTINCT land_id, 'EUR' AS wrg_id, 2 AS wrgtyp_id
   FROM dbp_msi_view_ek_int.mv_land) t01;