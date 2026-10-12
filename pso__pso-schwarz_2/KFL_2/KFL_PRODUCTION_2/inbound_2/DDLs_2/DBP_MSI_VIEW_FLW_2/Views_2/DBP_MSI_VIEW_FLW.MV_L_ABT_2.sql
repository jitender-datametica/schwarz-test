CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ABT_2
AS

   SELECT
   v01.mandant_id, v01.abt_id, v01.arthiertyp_id

   FROM dbp_view.v_abt_2  v01

   WHERE v01.arthiertyp_id = 2
   AND v01.mandant_id IN (1,2)
   AND v01.abt_id BETWEEN -3 AND 8;