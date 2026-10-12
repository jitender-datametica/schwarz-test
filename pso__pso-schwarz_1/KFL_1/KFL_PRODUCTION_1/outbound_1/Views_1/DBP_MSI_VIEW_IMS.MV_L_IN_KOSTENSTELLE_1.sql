CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_in_kostenstelle_1 AS SELECT mandant_id,
 kostenstelle_id,
 krk_id,
 COALESCE(pc_id, '-1') AS pc_id,
 buchungskreis_id,
 geschaeftsbereich_id,
 kostenstellenart_id
FROM kfl_production_dbp_view.v_in_kostenstelle_per_1
QUALIFY (ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, CAST(mandant_id AS STRING) ORDER BY dat_bis IS NULL, dat_bis)
   ) = 1;