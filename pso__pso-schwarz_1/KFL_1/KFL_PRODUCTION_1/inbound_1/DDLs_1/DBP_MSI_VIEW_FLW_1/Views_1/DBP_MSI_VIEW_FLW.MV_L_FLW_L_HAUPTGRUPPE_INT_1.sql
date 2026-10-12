CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_HAUPTGRUPPE_INT_1
AS

   SELECT    hauptgruppe_id AS hauptgruppe_int_id
   FROM dbp_view.v_flw_hauptgruppe_1
   WHERE
   mandant_id = 2;