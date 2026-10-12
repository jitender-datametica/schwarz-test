CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_gp_verhandlung_zu_1 (mandant_id, art_id, gp_id,
ivn_gruppe_id, ivn_verhandlungs_cluster_id, ivn_sortimentsgruppe_id) AS SELECT mandant_id,
 art_id,
 gp_id,
 ivn_gruppe_id,
 ivn_verhandlungs_cluster_id,
 ivn_sortimentsgruppe_id
FROM kfl_production_dbp_view.v_art_gp_verhandlung_zu_1
WHERE mandant_id <> 1;