CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_WETTERZUSTAND as
   SELECT
   v01.wetterzustand_id
   FROM dbp_view.v_l_wetterzustand v01;