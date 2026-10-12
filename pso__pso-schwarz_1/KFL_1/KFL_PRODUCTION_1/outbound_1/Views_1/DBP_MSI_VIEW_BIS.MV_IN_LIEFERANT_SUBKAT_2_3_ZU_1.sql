CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_lieferant_subkat_2_3_zu_1 (in_lief_id, mandant_id,
subkategorie_2_id) AS SELECT DT1.in_lief_id,
 DT1.mandant_id,
 COALESCE(t1.subkategorie_2_id, - 1) AS subkategorie_2_id
FROM kfl_production_dbp_view.v_in_lieferant_1 AS DT1
 LEFT JOIN (SELECT mandant_id,
   in_lief_id,
   subkategorie_2_id
  FROM kfl_production_dbp_view.v_in_lieferant_subkat_2_zu_1 AS DT2
  WHERE subkategorie_2_id <> - 1
  QUALIFY (SUM(1) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(in_lief_id AS STRING) ORDER BY subkategorie_2_id
        IS NULL, subkategorie_2_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 3) AS t1_1 ON DT1.in_lief_id = t1_1
   .in_lief_id AND DT1.mandant_id = t1.mandant_id;