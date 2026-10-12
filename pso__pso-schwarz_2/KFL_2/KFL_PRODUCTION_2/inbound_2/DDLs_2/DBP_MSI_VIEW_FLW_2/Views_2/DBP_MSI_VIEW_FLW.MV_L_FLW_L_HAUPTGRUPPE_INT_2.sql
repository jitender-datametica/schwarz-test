CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_HAUPTGRUPPE_INT_2
AS

   SELECT    hauptgruppe_id AS hauptgruppe_int_id
   FROM dbp_view.v_flw_hauptgruppe_2
   WHERE
   mandant_id = 2;