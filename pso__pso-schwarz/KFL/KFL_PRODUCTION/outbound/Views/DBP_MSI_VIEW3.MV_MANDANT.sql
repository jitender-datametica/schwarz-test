CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_mandant (mandant_id, mandant_bez, mandant_kbez, mandant_sap_id,
default_wrg, mandant_sort_id, spaet_lief_tage) AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sap_id,
 default_wrg,
 mandant_sort_id,
 spaet_lief_tage
FROM kfl_production_dbp_view.v_mandant;