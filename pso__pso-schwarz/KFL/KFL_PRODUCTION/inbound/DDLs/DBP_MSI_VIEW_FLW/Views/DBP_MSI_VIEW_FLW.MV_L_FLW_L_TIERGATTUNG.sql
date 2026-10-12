CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_TIERGATTUNG
AS

   SELECT
    v01.mandant_id, v01.tiergattung_id, v02.mandant_kbez

   FROM dbp_view.v_flw_l_tiergattung v01

   JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id;