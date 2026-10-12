CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_vpe_of_retailers_liam (
  client_id, per_id, liam_clnt_cat_id,
  liam_parnt_clnt_cat_id, valuepotential, vpe, islidl, rtl_id,
  rnk_id, rnk_desc, max_raw_buyer, rtl_tp_id, currency_iso_cd
) AS

SELECT
  t2.client_id,
  t2.per_id,
  t2.liam_clnt_cat_id,
  t2.liam_parnt_clnt_cat_id,
  t2.valuepotential,

  t2.valuepotential - t2.py_value AS vpe,

  t2.islidl,
  t2.rtl_id,

  RANK() OVER (
    PARTITION BY CAST(t2.per_id AS STRING),
                 CAST(t2.client_id AS STRING),
                 t2.liam_clnt_cat_id,
                 CAST(t2.rtl_tp_id AS STRING),
                 t2.currency_iso_cd
    ORDER BY t2.valuepotential IS NULL DESC,
             t2.valuepotential DESC
  ) AS rnk_id,

  CONCAT(
    '#',
    TRIM(SUBSTR(CAST(
      RANK() OVER (
        PARTITION BY CAST(t2.per_id AS STRING),
                     CAST(t2.client_id AS STRING),
                     t2.liam_clnt_cat_id,
                     CAST(t2.rtl_tp_id AS STRING),
                     t2.currency_iso_cd
        ORDER BY t2.valuepotential IS NULL DESC,
                 t2.valuepotential DESC
      ) AS STRING), 1, 19))
  ) AS rnk_desc,

  t2.max_raw_buyer,
  t2.rtl_tp_id,
  t2.currency_iso_cd

FROM (
  SELECT
    A13.client_id,
    A15.per_id,
    A13.liam_clnt_cat_id,
    A11.liam_parnt_clnt_cat_id,

    CASE
      WHEN UPPER(TRIM(A12.rtl_desc)) = 'LIDL' THEN 1
      ELSE 0
    END AS islidl,

    A12.rtl_id,
    A55.rtl_tp_id,
    A11.currency_iso_cd,
    SUM(CASE
      WHEN A11.meas_id = 5 THEN A11.val
      ELSE NULL
    END) AS valuepotential,
    SUM(CASE
      WHEN A11.meas_id = 5 THEN A11.py_val
      ELSE NULL
    END) AS py_value,

    MAX(A11.raw_buyer_id) AS max_raw_buyer

  FROM ldl_p_lew_mart_cm.v_lil_liam_data_act AS A11
  INNER JOIN ldl_p_lew_mart_cm.v_lil_retailer AS A12
    ON A11.rtl_id = A12.rtl_id
  INNER JOIN ldl_p_lew_mart_cm.v_lil_liam_clnt_cat AS A13
    ON A11.client_id = A13.client_id
   AND A11.liam_clnt_cat_id = A13.liam_clnt_cat_id
  INNER JOIN ldl_p_lew_mart_cm.v_lil_client AS A14
    ON A13.client_id = A14.client_id
  INNER JOIN ldl_p_lew_mart_cm.v_lil_period AS A15
    ON A11.per_id = A15.per_id
  INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp AS A50
    ON A11.rtl_lvl = A50.rtl_lvl
  INNER JOIN ldl_p_lew_mart_cm.v_lil_retailer_type AS A55
    ON A50.rtl_tp_id = A55.rtl_tp_id

  WHERE A13.clnt_cat_lvl IN (1, 2, 3)
    AND A55.rtl_tp_id IN (3, 2)
    AND (
      A15.per_id BETWEEN 6201805 AND 6500000 OR
      A15.per_id BETWEEN 3201805 AND 3500000 OR
      A15.per_id BETWEEN 12201805 AND 15000000 OR
      A15.per_id BETWEEN 201805 AND 250000 OR
      A55.rtl_tp_id NOT IN (2)
    )
    AND A11.prom_id IN (1)
    AND A11.meas_id = 5
    AND A12.rtl_id NOT IN (10, 930000, 940000)

  GROUP BY
    A13.client_id,
    A15.per_id,
    A13.liam_clnt_cat_id,
    A11.liam_parnt_clnt_cat_id,
    islidl,
    A12.rtl_id,
    A55.rtl_tp_id,
    A11.currency_iso_cd

  HAVING valuepotential IS NOT NULL

) AS t2;
