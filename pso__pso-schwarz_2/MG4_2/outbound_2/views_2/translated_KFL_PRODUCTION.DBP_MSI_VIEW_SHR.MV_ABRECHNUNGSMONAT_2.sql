CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_abrechnungsmonat_2 (mandant_id, kjmo_abr) AS SELECT mandant_id,
 MAX(kjmo) AS kjmo_abr
FROM kfl_production_dbp_view.v_shr_kennzahlen_2 AS v01
WHERE shr_freigabe_fg = 1
GROUP BY mandant_id;