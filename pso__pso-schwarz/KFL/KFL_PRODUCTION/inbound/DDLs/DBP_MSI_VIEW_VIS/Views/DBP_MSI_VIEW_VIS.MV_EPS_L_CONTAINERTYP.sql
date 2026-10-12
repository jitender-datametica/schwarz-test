CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_L_CONTAINERTYP as
   -- 26.08.2019 snik1809 - Change in backend setup
   -- 2019-10-30 ssch0611 - update in data model, mandant removed

   SELECT DISTINCT
   containertyp_id
   FROM dbp_view.v_l_eps_containertyp;