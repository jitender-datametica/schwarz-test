CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_kmr_l_organisationseinheit (orga_einheit_id,
amx_system_id, orga_einheit_bez, wup_id, mandant_id, nb_id, orga_einheit_imp_referenz) AS SELECT v01.orga_einheit_id,
 v01.amx_system_id,
 v01.orga_einheit_bez,
 v02.aktuell_wup_id AS wup_id,
 v01.mandant_id,
 v01.nb_id,
 v01.orga_einheit_imp_referenz
FROM kfl_production_dbp_view.v_kmr_l_organisationseinheit AS v01
 INNER JOIN kfl_production_dbp_view.v_wup AS v02 ON v01.wup_id = v02.wup_id AND v01.mandant_id = v02.mandant_id;