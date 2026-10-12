CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_kostenstelle AS SELECT kostenstelle_id,
 mandant_id,
 kostenstelle_bez,
 dat_bis
FROM kfl_production_dbp_view.v_kostenstelle_per
QUALIFY (ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, CAST(mandant_id AS STRING) ORDER BY dat_bis IS NULL, dat_bis)
   ) = 1;