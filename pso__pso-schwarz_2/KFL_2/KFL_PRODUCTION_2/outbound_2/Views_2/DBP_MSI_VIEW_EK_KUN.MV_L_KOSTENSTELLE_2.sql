CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_l_kostenstelle_2 (kostenstelle_id, mandant_id,
kostenstelle_bez, dat_bis) AS SELECT kostenstelle_id,
 mandant_id,
 kostenstelle_bez,
 dat_bis
FROM kfl_production_dbp_data.kostenstelle_per_2
QUALIFY (ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id ORDER BY dat_bis NULLS LAST)) = 1;