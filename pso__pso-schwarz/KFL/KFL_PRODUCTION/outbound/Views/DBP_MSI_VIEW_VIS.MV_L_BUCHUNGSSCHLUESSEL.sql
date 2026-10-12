CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_buchungsschluessel (buchungsschluessel_id,
buchungsschluessel_bez, buchungsschluessel_lang_bez) AS SELECT buchungsschluessel_id,
 buchungsschluessel_bez,
   CAST(buchungsschluessel_id AS STRING) || ' ' || buchungsschluessel_bez AS buchungsschluessel_lang_bez
FROM kfl_production_dbp_v_ods.v_buchungsschluessel_spr_zu
WHERE spr_id = 124;