CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_kostenstelle_spr_zu_bg_2 AS SELECT mandant_id,
 kostenstelle_id,
 krk_id,
 kostenstelle_bez
FROM kfl_production_dbp_view.v_in_kostenstelle_spr_zu_per_2
WHERE spr_id = 18
QUALIFY (ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, CAST(mandant_id AS STRING) ORDER BY dat_bis IS NULL, dat_bis)
   ) = 1;