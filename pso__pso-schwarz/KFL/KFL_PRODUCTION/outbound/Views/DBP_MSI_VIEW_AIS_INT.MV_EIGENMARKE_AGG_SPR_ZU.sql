CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_eigenmarke_agg_spr_zu (mandant_id, eigenmarke_agg,
eigenmarke_agg_bez, eigenmarke_agg_bez_de, eigenmarke_agg_bez_cz, eigenmarke_agg_bez_sk, eigenmarke_agg_bez_hr,
eigenmarke_agg_bez_pl, eigenmarke_agg_bez_ro, eigenmarke_agg_bez_bg) AS SELECT mandant_id,
 eigenmarke_agg,
 eigenmarke_agg_bez,
 eigenmarke_agg_bez AS eigenmarke_agg_bez_de,
  CASE
  WHEN eigenmarke_agg = 1
  THEN 'KL-Značka'
  ELSE 'žádný KL-Značka'
  END AS eigenmarke_agg_bez_cz,
  CASE
  WHEN eigenmarke_agg = 1
  THEN 'KL-Značka'
  ELSE 'nie KL-Značka'
  END AS eigenmarke_agg_bez_sk,
  CASE
  WHEN eigenmarke_agg = 1
  THEN 'KL-Marka'
  ELSE 'Ne KL-Marka'
  END AS eigenmarke_agg_bez_hr,
  CASE
  WHEN eigenmarke_agg = 1
  THEN 'Marka KL'
  ELSE 'nie Marka'
  END AS eigenmarke_agg_bez_pl,
  CASE
  WHEN eigenmarke_agg = 1
  THEN 'Marcă KL'
  ELSE 'nu Marcă KL'
  END AS eigenmarke_agg_bez_ro,
  CASE
  WHEN eigenmarke_agg = 1
  THEN 'KFL-Марка'
  ELSE 'не KFL-Марка'
  END AS eigenmarke_agg_bez_bg
FROM (SELECT mandant_id,
    CASE
    WHEN eigenmarke_id <> ''
    THEN 1
    ELSE 2
    END AS eigenmarke_agg,
    CASE
    WHEN CASE
      WHEN eigenmarke_id <> ''
      THEN 1
      ELSE 2
      END = 1
    THEN 'KL-Marke'
    ELSE 'nicht KL-Marke'
    END AS eigenmarke_agg_bez
  FROM kfl_production_dbp_data.artkz_eigenmarke AS V01
  GROUP BY mandant_id,
   eigenmarke_agg,
   eigenmarke_agg_bez) AS t0;