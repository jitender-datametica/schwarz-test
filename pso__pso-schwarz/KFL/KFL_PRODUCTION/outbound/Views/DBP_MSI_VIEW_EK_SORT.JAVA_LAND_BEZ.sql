CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_land_bez AS SELECT mandant_id,
 spr_id,
 mandant_bez
FROM (SELECT DISTINCT m.mandant_id,
   MSZ.spr_id,
   L.land_bez AS mandant_bez
  FROM kfl_production_dbp_view.v_land AS L
   INNER JOIN (SELECT mandant_id,
      CASE
      WHEN mandant_kbez = 'D'
      THEN 'DE'
      ELSE mandant_kbez
      END AS land_id
    FROM kfl_production_dbp_view.v_mandant) AS m ON L.land_id = m.land_id
   INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu AS MSZ ON L.mandant_id = MSZ.mandant_id) AS v01;