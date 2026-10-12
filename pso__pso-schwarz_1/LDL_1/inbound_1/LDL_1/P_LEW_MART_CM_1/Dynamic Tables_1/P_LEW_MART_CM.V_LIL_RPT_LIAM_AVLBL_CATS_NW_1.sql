
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_RPT_LIAM_AVLBL_CATS_NW_1 (
       client_id
       , liam_clnt_cat_id
       , liam_chld_cat_desc
       , liam_chld_cat_desc_EN
       , liam_clnt_parnt_cat_id
       , liam_parnt_cat_desc
       , liam_parnt_cat_desc_EN
       , prom_id
       , per_id
       , per_text
       , per_text_EN
       , valid_data_flg
       , valid_data_flg_cd
       , exp_delivered_nopromo
       , exp_delivered_promo
       , exp_total_uwg
       , exp_promo_uwg
       , bnc_prom_total
       , bnc_prom_brand_pl
       , exp_delivered_nopromo_uwg
       , exp_delivered_promo_uwg
       , exp_delivered
       , expected_uwg
       , data_expected
       , exp_delivered_uwg
       , delivered_uwg
) 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS (
  SELECT
     psf.client_id
     , psf.liam_clnt_cat_id
     , psf.liam_chld_cat_desc
     , psf.liam_chld_cat_desc_EN
     , psf.liam_clnt_parnt_cat_id
     , psf.liam_parnt_cat_desc
     , psf.liam_parnt_cat_desc_EN
     , psf.prom_id
     , COALESCE(fact2.per_id, -1) AS per_id
     , CAST(COALESCE(per.per_text, 'N/A') AS VARCHAR(128)) AS per_text
     , CAST(COALESCE(per.per_text_EN, 'N/A') AS VARCHAR(128)) AS per_text_EN
     , COALESCE(fact2.valid_data_flg, 'N') AS valid_data_flg
     , COALESCE(fact2.valid_data_flg_cd, 0) AS valid_data_flg_cd
     , COALESCE(fact2.valid_data_flg_cd, 0)*psf.bnc_prom_total AS exp_delivered_nopromo
     , COALESCE(fact2.valid_data_flg_cd, 0)*psf.bnc_prom_brand_pl AS exp_delivered_promo
     , COALESCE(psf.exp_total_uwg, 0) AS exp_total_uwg
     , COALESCE(psf.exp_promo_uwg, 0) AS exp_promo_uwg
     , psf.bnc_prom_total
     , psf.bnc_prom_brand_pl
     , fact_c.exp_delivered_nopromo_uwg
     , fact_c.exp_delivered_promo_uwg
     , CASE
         WHEN psf.prom_id IN (1, 100, 110, 120) THEN COALESCE(fact2.valid_data_flg_cd, 0)*psf.bnc_prom_total
         ELSE COALESCE(fact2.valid_data_flg_cd, 0)*psf.bnc_prom_brand_pl
       END AS exp_delivered
     , CASE
         WHEN psf.prom_id IN (1, 100, 110, 120) THEN COALESCE(psf.exp_total_uwg, 0)
         ELSE COALESCE(psf.exp_promo_uwg, 0)
         END AS expected_uwg
     , CASE
         WHEN psf.prom_id IN (1, 100, 110, 120) THEN psf.bnc_prom_total
         ELSE psf.bnc_prom_brand_pl
       END AS data_expected
     , CASE
         WHEN psf.prom_id IN (1, 100, 110, 120) THEN fact_c.exp_delivered_nopromo_uwg
         ELSE fact_c.exp_delivered_promo_uwg
       END AS exp_delivered_uwg
     , COALESCE(fact_c.delivered_uwg, 0) AS delivered_uwg
  FROM (
    SELECT
      cat1.client_id
      , fact1.liam_parnt_clnt_cat_id
      , fact1.prom_id
      , SUM(cat1.bnc_prom_total*fact1.valid_data_flg_cd) AS exp_delivered_nopromo_uwg
      , SUM(cat1.bnc_prom_brand_pl*fact1.valid_data_flg_cd) AS exp_delivered_promo_uwg
      , SUM(fact1.valid_data_flg_cd) AS delivered_uwg
    FROM (
      SELECT
       f.client_id
       , f.assort_cat_sid
       , CAST(SUBSTR(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
       , CAST(ass.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
       , f.promotion_brand_id AS prom_id
       , CAST('J' AS VARCHAR(3)) AS valid_data_flg
       , CAST(1 AS BYTEINT) AS valid_data_flg_cd
       , MAX(p.period_id) AS per_id
     FROM P_LEW_CORE_AC.v_market_familygroup_1 AS f
     INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period_1 AS p
        ON f.period_sid=p.period_sid
     INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_assort_region_cat_1 AS ass
        ON ass.client_id = f.client_id
       AND ass.region_sid = f.region_sid
       AND ass.assort_cat_sid = f.assort_cat_sid
     INNER JOIN P_LEW_MART_CM.v_lil_liam_clnt_cat_1 AS lu
        ON f.client_id = lu.client_id
       AND ass.assort_region_cat_id = lu.liam_clnt_cat_id
     WHERE  f.turnover_val > 0
     GROUP BY f.client_id, f.assort_cat_sid, CAST(SUBSTR(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)), CAST(ass.assort_region_cat_id AS CHAR(27)) ,f.promotion_brand_id
  ) AS fact1
  INNER JOIN P_LEW_MART_CM.v_lil_liam_clnt_cat_1 AS cat1
     ON cat1.client_id = fact1.client_id
    AND cat1.liam_clnt_cat_id = fact1.liam_clnt_cat_id
  GROUP BY 1, 2, 3
  ) fact_c
  INNER JOIN (
    SELECT
      f.client_id
    , f.assort_cat_sid
    , CAST(SUBSTR(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
    , CAST(ass.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
    , f.promotion_brand_id AS prom_id
    , CAST('J' AS VARCHAR(3)) AS valid_data_flg
    , CAST(1 AS BYTEINT) AS valid_data_flg_cd
    , MAX(p.period_id) AS per_id
    FROM P_LEW_CORE_AC.v_market_familygroup_1 AS f
    INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period_1 AS p
       ON f.period_sid=p.period_sid
    INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_assort_region_cat_1 AS ass
       ON ass.client_id = f.client_id
      AND ass.region_sid = f.region_sid
      AND ass.assort_cat_sid = f.assort_cat_sid
    WHERE  f.turnover_val > 0
    GROUP BY f.client_id, f.assort_cat_sid, CAST(SUBSTR(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)), CAST(ass.assort_region_cat_id AS CHAR(27)) ,f.promotion_brand_id
  ) fact2
     ON fact2.client_id = fact_c.client_id
    AND fact2.liam_parnt_clnt_cat_id = fact_c.liam_parnt_clnt_cat_id
    AND fact2.prom_id = fact_c.prom_id
INNER JOIN P_LEW_MART_CM.v_lil_period_1 AS per
   ON fact2.per_id = per.per_id
RIGHT OUTER JOIN (
  SELECT DISTINCT mc.client_id
         , mc.liam_clnt_cat_id
         , mc.liam_chld_cat_desc
         , mc.liam_chld_cat_desc_EN
         , SUBSTR(mc.liam_clnt_cat_id,1, 15)||'005000000000' AS liam_clnt_parnt_cat_id
         , mc.liam_parnt_cat_desc
         , mc.liam_parnt_cat_desc_EN
         , prom.prom_id
         , mc.bnc_prom_total
         , mc.bnc_prom_brand_pl
         , exps.exp_total_uwg
         , exps.exp_promo_uwg
  FROM P_LEW_MART_CM.v_lil_liam_clnt_cat_1 AS mc
  CROSS JOIN P_LEW_MART_CM.v_lil_promotion_1 AS prom
  INNER JOIN (
    SELECT
      client_id
      , liam_parnt_cat_desc
      , SUM(bnc_prom_total) AS exp_total_uwg
      , SUM(bnc_prom_brand_pl) AS exp_promo_uwg
     FROM P_LEW_MART_CM.v_lil_liam_clnt_cat_1
     GROUP BY 1, 2
    ) AS exps
  ON TRIM(mc.liam_parnt_cat_desc) = TRIM(exps.liam_parnt_cat_desc)
  ) AS psf
   ON fact2.client_id = psf.client_id
  AND fact2.liam_clnt_cat_id = psf.liam_clnt_cat_id
  AND fact2.prom_id = psf.prom_id
);
