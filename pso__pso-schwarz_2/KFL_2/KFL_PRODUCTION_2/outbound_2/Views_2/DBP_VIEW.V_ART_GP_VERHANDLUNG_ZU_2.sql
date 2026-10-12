CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_gp_verhandlung_zu_2 AS SELECT mandant_id,
 art_id,
 gp_id,
 ivn_gruppe_id,
 ivn_verhandlungs_cluster_id,
 ivn_sortimentsgruppe_id,
 quellsystem_id
FROM kfl_production_dbp_data.art_gp_verhandlung_zu_2;