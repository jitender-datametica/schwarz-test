CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_mara_empf (art_id, mandant_id, ummat_sap, dat_von, dat_bis) AS
SELECT art_id,
 mandant_id,
  CASE
  WHEN artikelart_id = 'MWST'
  THEN TRIM(CAST(kl_art_id AS STRING FORMAT '0000'))
  ELSE CASE
   WHEN mandant_id <> 1
   THEN TRIM(CAST(kl_art_id AS STRING FORMAT '00000000'))
   WHEN mandant_id = 1 AND art_id > 0
   THEN TRIM(CAST(kl_art_id AS STRING FORMAT '0000000'))
   WHEN mandant_id = 1 AND art_id < 0
   THEN '00' || CAST(TRUNC(CAST(art_id / 100 AS BIGNUMERIC)) AS STRING)
   ELSE NULL
   END
  END AS ummat_sap,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_art
WHERE dat_bis = DATE '9999-12-31';