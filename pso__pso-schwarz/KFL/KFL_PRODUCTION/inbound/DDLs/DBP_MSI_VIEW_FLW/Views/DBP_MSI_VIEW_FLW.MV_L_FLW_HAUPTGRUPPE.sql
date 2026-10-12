CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_HAUPTGRUPPE
AS

   SELECT    mandant_id, hauptgruppe_id, hauptgruppe_id AS hauptgruppe_int_id
   FROM dbp_view.v_flw_hauptgruppe;