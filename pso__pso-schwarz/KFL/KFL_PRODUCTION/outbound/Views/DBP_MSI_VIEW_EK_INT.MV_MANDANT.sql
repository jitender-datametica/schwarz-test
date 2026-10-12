CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_mandant AS SELECT mandant_sort_id,
 mandant_id,
 mandant_bez,
 mandant_kbez,
 default_wrg,
 mandant_sap_id,
 spaet_lief_tage
FROM kfl_production_dbp_view.v_mandant AS V01;