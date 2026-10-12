CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_crm_magicword_spr_zu (crm_magicword_id,
crm_magicword_bez) AS SELECT crm_magicword_id,
 MAX(CASE
   WHEN crm_magicword_id <> '-1'
   THEN crm_magicword_bez
   ELSE NULL
   END) AS crm_magicword_bez
FROM kfl_production_dbp_view.v_crm_magicword_spr_zu AS V01
GROUP BY crm_magicword_id;