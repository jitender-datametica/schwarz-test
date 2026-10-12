CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_flaeche_branche_zu_1 (mandant_id, flaeche_id, branche_id) AS
SELECT mandant_id,
 flaeche_id,
 MAX(branche_id) AS branche_id
FROM kfl_production_dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi_1
WHERE (mandant_id, flaeche_id, dat_flaeche_uebergabe) IN (SELECT (mandant_id, flaeche_id, MAX(dat_flaeche_uebergabe))
   FROM kfl_production_dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi_1 AS MFZP
   GROUP BY mandant_id,
    flaeche_id)
GROUP BY mandant_id,
 flaeche_id;