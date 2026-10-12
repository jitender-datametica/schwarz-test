CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_hfm_marke_1 (mandant_id, art_id, hfm_c2_marke) AS SELECT a11
 .mandant_id,
 a11.art_id,
  CASE
  WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id = '' AND a11.aldi_id = 1 AND a11.yellowprint_fg = 1 AND a11.mandant_id
      <> 1
  THEN 'MA_FM_PE'
  WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id = '' AND a11.mandant_id <> 1
  THEN 'MA_FM_MA_SO'
  WHEN a13.abt_id = 8 AND a11.eigenmarke_id = 'H' AND a11.mandant_id <> 1
  THEN 'MA_EM_HM'
  WHEN a13.abt_id = 8 AND a11.mandant_id <> 1 AND a11.eigenmarke_id IS NOT NULL
  THEN 'MA_EM_OK'
  WHEN a11.eigenmarke_id = 'H' AND a11.mandant_id = 1
  THEN 'MA_EM_HM'
  WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id = '' AND a11.aldi_id <> 0 AND (a11.discountart_id = 'AM' OR a11.discountart_id
         = 'DC') AND a11.mandant_id = 1
  THEN 'MA_FM_MA_DC'
  WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id = '' AND a11.aldi_id <> 0 AND a11.mandant_id = 1
  THEN 'MA_FM_PE'
  WHEN a11.eigenmarke_id IS NULL OR a11.eigenmarke_id = '' AND a11.mandant_id = 1
  THEN 'MA_FM_MA_SO'
  WHEN a13.abt_id = 8 AND a11.mandant_id = 1
  THEN 'MA_EM_OK'
  ELSE IFNULL(A17.hfm_markengruppe_kz, 'Keine Eigenmarkenzuordnung')
  END AS hfm_c2_marke
FROM (SELECT V01.mandant_id,
   V01.art_id,
   V01.eigenmarke_id,
   V01.aldi_id,
   V01.yellowprint_fg,
   V01.discount_id,
   V01.discountart_id
  FROM kfl_production_dbp_view.v_art_1 AS V01
   INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id) AS a11
 INNER JOIN (SELECT mandant_id,
   art_id,
   wg_id,
   wug_id,
   arthiertyp_id
  FROM kfl_production_dbp_view.v_art_wg_zu_per_1 AS V01
  WHERE arthiertyp_id = 2
   AND dat_bis = DATE '9999-12-31') AS a12 ON a11.art_id = a12.art_id AND a11.mandant_id = a12.mandant_id
 INNER JOIN (SELECT mandant_id,
   wg_id,
   arthiertyp_id,
   abt_id,
   TRIM(CAST(wg_id AS STRING FORMAT '000')) AS wg_id_lang,
   owg_id
  FROM kfl_production_dbp_view.v_wg_per_1 AS V01
  WHERE dat_bis = DATE '9999-12-31') AS a13 ON a12.mandant_id = a13.mandant_id AND a12.wg_id = a13.wg_id
 INNER JOIN (SELECT owg_id,
   mandant_id,
   dat_von,
   dat_bis,
   arthiertyp_id,
   hwg_id
  FROM kfl_production_dbp_view.v_owg_per_1 AS V01
  WHERE arthiertyp_id = 2
   AND dat_bis = DATE '9999-12-31') AS a14 ON a13.mandant_id = a14.mandant_id AND a13.owg_id = a14.owg_id
 INNER JOIN (SELECT V013.mandant_id,
   V013.art_id,
   V020.kl_art_id,
   COALESCE(MAX(CASE
      WHEN V013.spr_id = 22
      THEN V013.art_bez
      ELSE NULL
      END), 'N/A') AS art_bez,
   COALESCE(MAX(CASE
      WHEN V013.spr_id = 22
      THEN V013.art_bez
      ELSE NULL
      END), 'N/A') AS art_bez_de,
   COALESCE(MAX(CASE
      WHEN V013.spr_id = 124
      THEN V013.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V013.spr_id = 22
       THEN V013.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_cz,
   COALESCE(MAX(CASE
      WHEN V013.spr_id = 108
      THEN V013.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V013.spr_id = 22
       THEN V013.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_sk,
   COALESCE(MAX(CASE
      WHEN V013.spr_id = 65
      THEN V013.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V013.spr_id = 22
       THEN V013.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_hr,
   COALESCE(MAX(CASE
      WHEN V013.spr_id = 90
      THEN V013.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V013.spr_id = 22
       THEN V013.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_pl,
   COALESCE(MAX(CASE
      WHEN V013.spr_id = 95
      THEN V013.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V013.spr_id = 22
       THEN V013.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_ro,
   COALESCE(MAX(CASE
      WHEN V013.spr_id = 18
      THEN V013.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V013.spr_id = 22
       THEN V013.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_bg
  FROM kfl_production_dbp_view.v_art_spr_zu_1 AS V013
   INNER JOIN kfl_production_dbp_view.v_art_1 AS V020 ON V013.art_id = V020.art_id AND V013.mandant_id = V020.mandant_id
  GROUP BY V013.mandant_id,
   V013.art_id,
   V020.kl_art_id) AS a15 ON a11.art_id = a15.art_id AND a11.mandant_id = a15.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_l_eigenmarke_hfm_kz_1 AS A17 ON a11.eigenmarke_id = A17.eigenmarke_id AND a11.mandant_id
     = A17.mandant_id AND CASE
    WHEN a11.art_id < 10000000
    THEN '00' || CAST(CAST(a11.art_id / 100 AS BIGNUMERIC) AS STRING)
    WHEN a11.art_id < 100000000
    THEN '0' || CAST(CAST(a11.art_id / 100 AS BIGNUMERIC) AS STRING)
    ELSE CAST(CAST(a11.art_id / 100 AS BIGNUMERIC) AS STRING)
    END = CASE
    WHEN a15.art_id < 10000000
    THEN '00' || CAST(CAST(a15.art_id / 100 AS BIGNUMERIC) AS STRING)
    WHEN a15.art_id < 100000000
    THEN '0' || CAST(CAST(a15.art_id / 100 AS BIGNUMERIC) AS STRING)
    ELSE CAST(CAST(a15.art_id / 100 AS BIGNUMERIC) AS STRING)
    END;