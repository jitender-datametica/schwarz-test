CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ssm_wup_cluster_prozess_zu_2 (mandant_id, wup_id, nb_id,
ssm_cluster_id, ssm_prozess_id, dat_von, dat_bis, wup_bereich_id, wup_abt_id, etagen_anz) AS SELECT SSMCL.mandant_id,
 SSMCL.wup_id,
 SSMCL.nb_id,
 SSMCL.ssm_cluster_id,
 SSMCL.ssm_prozess_id,
 SSMCL.dat_von,
 SSMCL.dat_bis,
 SSMCL.wup_bereich_id,
 SSMCL.wup_abt_id,
 WP.etagen_anz
FROM kfl_production_dbp_view.v_ssm_wup_cluster_prozess_zu_2 AS SSMCL
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WP ON SSMCL.mandant_id = WP.mandant_id AND SSMCL.wup_id = WP.wup_id;