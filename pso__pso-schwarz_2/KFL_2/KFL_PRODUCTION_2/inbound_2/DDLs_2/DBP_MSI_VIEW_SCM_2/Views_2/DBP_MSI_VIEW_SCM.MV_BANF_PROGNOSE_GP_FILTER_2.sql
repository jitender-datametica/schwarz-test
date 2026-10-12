CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_BANF_PROGNOSE_GP_FILTER_2 as
   SELECT
   mandant_id, gp_id
   from dbp_view.v_banf_prognose_gp_filter_2;