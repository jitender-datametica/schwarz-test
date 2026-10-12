CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_PRODUKTGRUPPE_INT_1
AS

   SELECT  produktgruppe_id AS produktgruppe_int_id, hauptgruppe_id AS hauptgruppe_int_id
   FROM dbp_view.v_flw_produktgruppe_1
   WHERE
   mandant_id = 2;