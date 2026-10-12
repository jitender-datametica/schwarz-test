CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_CONTAINERTYP_ANSTOSSHERKUNFT_ZU_1 as
   -- 2019-10-30 ssch0611 - update in data model, Initial

   SELECT DISTINCT
   containertyp_id, anstossherkunft_kz
   FROM dbp_view.v_eps_containertyp_anstossherkunft_zu_1;