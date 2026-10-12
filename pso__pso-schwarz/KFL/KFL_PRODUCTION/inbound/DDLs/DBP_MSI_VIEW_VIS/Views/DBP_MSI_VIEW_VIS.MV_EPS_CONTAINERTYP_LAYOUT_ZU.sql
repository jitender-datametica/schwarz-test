CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_CONTAINERTYP_LAYOUT_ZU as
   -- 2019-10-30 ssch0611 - update in data model, Initial

   SELECT DISTINCT
   containertyp_id, layout_kz
   FROM dbp_view.v_eps_containertyp_layout_zu;