CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_WETTERZUSTAND_2 as
   SELECT
   v01.wetterzustand_id
   FROM dbp_view.v_l_wetterzustand_2 v01;