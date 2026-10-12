CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_L_LAYOUT_1 as
   -- 2019-10-30 ssch0611 - update in data model

   SELECT DISTINCT
   layout_kz
   FROM dbp_view.v_l_eps_layout_1;