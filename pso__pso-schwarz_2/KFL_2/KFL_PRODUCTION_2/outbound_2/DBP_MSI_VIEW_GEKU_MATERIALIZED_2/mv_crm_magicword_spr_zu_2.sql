CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_crm_magicword_spr_zu_2 (crm_magicword_id,
crm_magicword_bez) AS SELECT crm_magicword_id,
 MAX(CASE
   WHEN crm_magicword_id <> '-1'
   THEN crm_magicword_bez
   ELSE NULL
   END) AS crm_magicword_bez
FROM dbp_view.v_crm_magicword_spr_zu_2 AS V01
GROUP BY crm_magicword_id;