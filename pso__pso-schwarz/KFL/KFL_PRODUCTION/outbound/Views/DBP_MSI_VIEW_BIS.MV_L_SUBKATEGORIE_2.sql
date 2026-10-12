CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_subkategorie_2 (mandant_id, subkategorie_2_id) AS SELECT MIN(mandant_id
  ) AS mandant_id,
 subkategorie_2_id
FROM kfl_production_dbp_view.v_l_subkategorie_2
GROUP BY subkategorie_2_id;