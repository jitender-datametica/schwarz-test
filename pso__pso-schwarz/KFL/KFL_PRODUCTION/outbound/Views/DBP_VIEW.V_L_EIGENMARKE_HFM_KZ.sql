CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_eigenmarke_hfm_kz AS SELECT mandant_id,
 eigenmarke_id,
 hfm_markengruppe_kz
FROM kfl_production_dbp_data.l_eigenmarke_hfm_kz;