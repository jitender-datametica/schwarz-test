CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_objekt (mandant_id, objekt_nummer_id, dat_produktion1,
dat_verpackung, dat_fuell) AS SELECT mandant_id,
 objekt_nummer_id,
 MAX(CASE
   WHEN CAST(int_merkmal_id AS FLOAT64) = 1621
   THEN dat_wert
   ELSE NULL
   END) AS dat_produktion1,
 MAX(CASE
   WHEN CAST(int_merkmal_id AS FLOAT64) = 1624
   THEN dat_wert
   ELSE NULL
   END) AS dat_verpackung,
 MAX(CASE
   WHEN CAST(int_merkmal_id AS FLOAT64) = 1625
   THEN dat_wert
   ELSE NULL
   END) AS dat_fuell
FROM kfl_production_dbp_view.v_flw_charge_objekt_merkmal_zu
GROUP BY mandant_id,
 objekt_nummer_id;