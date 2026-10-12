CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_ersteller_rpw_gruppe_zu_per_2 (mandant_id, rpw_ersteller_id,
gruppe_id, abteilung_id, dat_von, dat_bis, system_id) AS SELECT mandant_id,
 ersteller_id AS rpw_ersteller_id,
 gruppe_id,
 abteilung_id,
 dat_von,
 dat_bis,
 7 AS system_id
FROM kfl_production_dbp_view.v_ersteller_rpw_gruppe_zu_per_2
WHERE mandant_id = 1
GROUP BY mandant_id,
 ersteller_id,
 gruppe_id,
 abteilung_id,
 dat_von,
 dat_bis
QUALIFY (SUM(mandant_id) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(ersteller_id AS STRING) ORDER BY
      ersteller_id IS NULL, ersteller_id, dat_bis IS NULL, dat_bis ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) =
  1;