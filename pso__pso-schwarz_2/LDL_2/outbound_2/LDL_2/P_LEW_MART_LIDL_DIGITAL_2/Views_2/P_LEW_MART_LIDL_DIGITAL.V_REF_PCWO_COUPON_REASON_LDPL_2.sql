CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_pcwo_coupon_reason_ldpl_2 (coupon_reason_nr
OPTIONS(description='identifier of the coupon reason in SCRM'), loyalty
OPTIONS(description='loyalty (when coupon_promo_type_sid not in (7,12,13,39))'), coupon_reason_descr
OPTIONS(description='description of the coupon reason in SCRM'), pcwo_reason_id
OPTIONS(description='WaWi unique ID of reasons for writeoffs and price changees'), pcwo_reason_desc
OPTIONS(description='WaWi unique ID of reasons for writeoffs and price changees description'), is_price_change_fg
OPTIONS(description='Is price change flag'), is_writeoff_fg OPTIONS(description='Is writeoff flag'), is_default_coupon
OPTIONS(description='Is default coupon')) AS WITH CTE_REASON AS (SELECT coupon_reason_nr,
    'N' AS loyalty,
    coupon_reason_descr,
    emp_coupon_fg,
     CASE
     WHEN coupon_reason_nr = 100001400
     THEN 6
     WHEN coupon_reason_nr IN (100001000, 100001001, 100001002)
     THEN 41
     WHEN coupon_reason_nr = 100001003
     THEN 45
     WHEN coupon_reason_nr = 100001470
     THEN 43
     WHEN coupon_reason_nr IN (100001006, 100001007)
     THEN 41
     WHEN coupon_reason_nr IN (100001008, 100001009)
     THEN 47
     ELSE NULL
     END AS pcwo_reason_id
   FROM ldl_p_lew_core.t_ref_coupon_reason_2 AS CR
   UNION ALL
   SELECT 100001003 AS coupon_reason_nr,
    'N' AS loyalty,
    'Employee_2 Coupons' AS coupon_reason_descr,
    1 AS emp_coupon_fg,
    45 AS pcwo_reason_id
   FROM (SELECT 100001003 AS coupon_reason_nr,
      'N' AS loyalty,
      'Employee_2 Coupons' AS coupon_reason_descr,
      1 AS emp_coupon_fg,
      45 AS pcwo_reason_id) AS t0
   WHERE coupon_reason_nr NOT IN (SELECT coupon_reason_nr
      FROM ldl_p_lew_core.t_ref_coupon_reason_2)
   UNION ALL
   SELECT coupon_reason_nr,
    'Y' AS loyalty,
    coupon_reason_descr,
    emp_coupon_fg,
     CASE
     WHEN coupon_reason_nr IN (100001000, 100001001, 100001002, 100001004, 100001005)
     THEN 41
     ELSE NULL
     END AS pcwo_reason_id
   FROM ldl_p_lew_core.t_ref_coupon_reason_2 AS CR
   WHERE coupon_reason_nr IN (100001000, 100001001, 100001002, 100001004, 100001005)), CTE_PCWO_BASE AS (SELECT
   pcwo_reason_id,
   pcwo_reason_desc
  FROM ldl_p_lew_core.t_wawi_ref_pcwo_reason_desc_2 AS PCWO
  WHERE language_id = 7
   AND client_id = 23
   AND dat_rec_end = DATE('9999-12-31')
   AND pcwo_reason_id IN (-999, 6, 41, 43, 45, 46, 47, 48, 81, 42, 151)), CTE_PCWO AS (SELECT pcwo_reason_id,
    pcwo_reason_desc
   FROM CTE_PCWO_BASE
   UNION ALL
   SELECT 45 AS pcwo_reason_id,
    'MA-Rabatte' AS pcwo_reason_desc
   FROM (SELECT 45 AS pcwo_reason_id,
      'MA-Rabatte' AS pcwo_reason_desc) AS t12
   WHERE pcwo_reason_id NOT IN (SELECT pcwo_reason_id
      FROM ldl_p_lew_core.t_wawi_ref_pcwo_reason_desc_2 AS PCWO
      WHERE language_id = 7
       AND client_id = 23
       AND dat_rec_end = DATE('9999-12-31')
       AND pcwo_reason_id IN (-999, 6, 41, 43, 45, 46, 47, 48, 81, 42, 151))
   UNION ALL
   SELECT -99 AS pcwo_reason_id,
    'Preisgebietsdifferenzen' AS pcwo_reason_desc
   FROM (SELECT 0 AS zero) AS t17
   WHERE -99 NOT IN (SELECT pcwo_reason_id
      FROM ldl_p_lew_core.t_wawi_ref_pcwo_reason_desc_2 AS PCWO
      WHERE language_id = 7
       AND client_id = 23
       AND dat_rec_end = DATE('9999-12-31')
       AND pcwo_reason_id IN (-999, 6, 41, 43, 45, 46, 47, 48, 81, 42, 151))) (SELECT IFNULL(r.coupon_reason_nr, 0) AS
   coupon_reason_nr,
   COALESCE(r.loyalty, 'N') AS loyalty,
   COALESCE(r.coupon_reason_descr, '') AS coupon_reason_descr,
    CASE
    WHEN pcwo.pcwo_reason_id = -999
    THEN 0
    ELSE pcwo.pcwo_reason_id
    END AS pcwo_reason_id,
    CASE
    WHEN pcwo.pcwo_reason_id = -999
    THEN 'Other'
    ELSE pcwo.pcwo_reason_desc
    END AS pcwo_reason_desc,
    CASE
    WHEN pcwo.pcwo_reason_id IN (41, 43, 45, 42, 46, 47, 48, -99)
    THEN 'Y'
    ELSE 'N'
    END AS is_price_change,
    CASE
    WHEN pcwo.pcwo_reason_id IN (6, 81, 151)
    THEN 'Y'
    ELSE 'N'
    END AS is_writeoff,
    CASE
    WHEN r.pcwo_reason_id = 41 AND r.coupon_reason_nr IN (100001000, 100001001, 100001002, 100001004, 100001005)
    THEN 'N'
    ELSE 'Y'
    END AS is_default_coupon
  FROM CTE_REASON AS r
   FULL JOIN CTE_PCWO AS pcwo ON r.pcwo_reason_id = pcwo.pcwo_reason_id);