CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_bonuskauf_promotionstyp_2 (bonuskauf_promotionstyp_id,
bonuskauf_promotionstyp_desc) AS SELECT COALESCE(bonuskauf_promotionstyp, '-1') AS bonuskauf_promotionstyp_id,
 COALESCE(bonuskauf_promotionstyp, 'STANDARD') AS bonuskauf_promotionstyp_desc
FROM kfl_production_dbp_view.v_pmr_angebot_art_wup_zu_2
GROUP BY bonuskauf_promotionstyp;