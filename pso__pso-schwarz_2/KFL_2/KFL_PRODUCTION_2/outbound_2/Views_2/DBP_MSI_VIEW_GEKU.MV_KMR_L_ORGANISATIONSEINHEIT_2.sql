CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_organisationseinheit_2 (orga_einheit_id, amx_system_id,
orga_einheit_bez, wup_id, mandant_id, nb_id, orga_einheit_imp_referenz) AS SELECT V01.orga_einheit_id,
 V01.amx_system_id,
 V01.orga_einheit_bez,
 V02.aktuell_wup_id AS wup_id,
 V01.mandant_id,
 V01.nb_id,
 V01.orga_einheit_imp_referenz
FROM kfl_production_dbp_view.v_kmr_l_organisationseinheit_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;