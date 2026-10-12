CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTKZ_EIGENMARKE_2 as
   SELECT
   v01.eigenmarke_id, v01.mandant_id, v01.spr_id, v01.eigenmarke_bez
   FROM dbp_view.v_artkz_eigenmarke_2 v01;