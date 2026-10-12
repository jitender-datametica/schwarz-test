CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_l_wirtschaftseinheit_2 AS
SELECT
  mandant_id AS mandant_id,
  we_intreno AS we_intreno,
  CASE
    WHEN LENGTH(wirtschaftseinheit_id) = 3
    THEN '0' || wirtschaftseinheit_id
    ELSE wirtschaftseinheit_id
  END AS wirtschaftseinheit_id,
  wirtschaftseinheit_bez AS wirtschaftseinheit_bez,
  we_objekt_nr AS we_objekt_nr,
  dat_eroeffnung AS dat_eroeffnung
FROM kfl_production_dbp_view.v_immo_wirtschaftseinheit_2 AS v0
WHERE
  CURRENT_DATE BETWEEN dat_we_gueltig_von AND dat_we_gueltig_bis;
