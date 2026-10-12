CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mandant AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sap_id,
 default_wrg,
 mandant_sort_id,
 spaet_lief_tage,
 mandant_sb_id,
 mandant_sb_tf_id,
 mandant_id_ursprung
FROM kfl_production_dbp_data.mandant;