CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_DISPOMERKMAL_1 as
   SELECT
   v01.mandant_id, v01.dispomerkmal
   FROM dbp_view.v_l_dispomerkmal_1 v01;