CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_TIERGATTUNG_1
AS

   SELECT
    v01.mandant_id, v01.tiergattung_id, v02.mandant_kbez

   FROM dbp_view.v_flw_l_tiergattung_1 v01

   JOIN dbp_view.v_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id;