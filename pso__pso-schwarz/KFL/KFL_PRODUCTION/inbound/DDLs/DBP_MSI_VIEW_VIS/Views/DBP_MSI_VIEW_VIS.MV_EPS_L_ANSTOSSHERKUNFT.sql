CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_L_ANSTOSSHERKUNFT as
   -- 26.08.2019 snik1809 - Change in backend setup
   -- 2019-10-30 ssch0611 - update in data model, mandant removed

   SELECT DISTINCT
   anstossherkunft_kz
   FROM dbp_view.v_l_eps_anstossherkunft;