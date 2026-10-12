CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_einkaufspreisstamm_kbsal
OPTIONS(ENABLE_REFRESH = TRUE,  max_staleness = INTERVAL "1:30:0" HOUR TO SECOND, allow_non_incremental_definition = TRUE) AS
SELECT v01.mandant_id,
 v01.art_id,
 v01.bezugsweg_id,
 MAX(v01.ek_kal_basis) AS ek_kal_basis,
 MAX(v01.ek_mep) AS ek_mep,
 MAX(v01.logistikkostenzuschlag) AS logistikkostenzuschlag
FROM kfl_production_dbp_view.v_art_gp_wup_zu_per AS v01
 INNER JOIN kfl_production_dbp_msi_view2.mv_art_gp_nm_zu_aktuell AS v02 ON v01.art_id = v02.art_id AND v01.gp_id = v02.akt_gp_id
     AND v01.mandant_id = v02.mandant_id
WHERE v01.dat_bis = DATE '9999-12-31'
 AND v01.mandant_id = 1
GROUP BY v01.mandant_id,
 v01.art_id,
 v01.bezugsweg_id;
