CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_PRODUKTGRUPPE_1
AS

   SELECT   mandant_id, produktgruppe_id, produktgruppe_id AS produktgruppe_int_id, hauptgruppe_id
   FROM dbp_view.v_flw_produktgruppe_1;