CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_L_DRUCK_ANLASS_2 as
   -- 12.03.2019 dsim0608 - SPEC0049429
   -- 26.08.2019 snik1809 - Change in backend setup
   -- 2019-10-30 ssch0611 - update in data model, mandant_2 removed

   SELECT DISTINCT
   druck_anlass_id
   FROM dbp_view.v_l_eps_druck_anlass_2;