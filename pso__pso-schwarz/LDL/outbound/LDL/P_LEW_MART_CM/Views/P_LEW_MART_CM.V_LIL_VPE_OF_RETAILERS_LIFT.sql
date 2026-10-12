
CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_vpe_of_retailers_lift (rtl_id, lift_cat_id, valuepotential, vpe, islidl,
client_id, per_id, currency_iso_cd, rnk_id, rnk_desc, max_raw_buyer, rtl_tp_id) AS SELECT A12.rtl_id,
 A11.lift_cat_id,
 SUM(CASE
   WHEN A11.meas_id = 5
   THEN A11.val
   ELSE NULL
   END) AS valuepotential,
  SUM(CASE
    WHEN A11.meas_id = 5
    THEN A11.val
    ELSE NULL
    END) - SUM(CASE
    WHEN A11.meas_id = 5
    THEN A11.py_val
    ELSE NULL
    END) AS vpe,
  CASE
  WHEN UPPER(TRIM(A12.rtl_desc)) = 'LIDL'
  THEN 1
  ELSE 0
  END AS islidl,
 A11.client_id,
 A11.per_id,
 A11.currency_iso_cd,
 RANK() OVER (PARTITION BY CAST(A11.per_id AS STRING), CAST(A11.client_id AS STRING), CAST(A11.lift_cat_id AS STRING), CAST(A55.rtl_tp_id AS STRING)
    , A11.currency_iso_cd ORDER BY SUM(CASE
      WHEN A11.meas_id = 5
      THEN A11.val
      ELSE NULL
      END) IS NULL DESC, SUM(CASE
      WHEN A11.meas_id = 5
      THEN A11.val
      ELSE NULL
      END) DESC) AS rnk_id,
  '#' || TRIM(SUBSTR(CAST(RANK() OVER (PARTITION BY CAST(A11.per_id AS STRING), CAST(A11.client_id AS STRING), CAST(A11.lift_cat_id AS STRING)
        , CAST(A55.rtl_tp_id AS STRING), A11.currency_iso_cd ORDER BY SUM(CASE
          WHEN A11.meas_id = 5
          THEN A11.val
          ELSE NULL
          END) IS NULL DESC, SUM(CASE
          WHEN A11.meas_id = 5
          THEN A11.val
          ELSE NULL
          END) DESC) AS STRING), 1, 19)) AS rnk_desc,
 MAX(A11.raw_buyer_id) AS max_raw_buyer,
 A55.rtl_tp_id
FROM ldl_p_lew_mart_cm.v_lil_lift_data_act AS A11
 INNER JOIN ldl_p_lew_mart_cm.v_lil_retailer AS A12 ON A11.rtl_id = A12.rtl_id
 INNER JOIN ldl_p_lew_mart_cm.v_lil_client AS A99 ON A11.client_id = A99.client_id
 INNER JOIN ldl_p_lew_mart_cm.v_lil_lift_cat AS A13 ON A11.lift_cat_id = A11.lift_cat_id
 INNER JOIN ldl_p_lew_mart_cm.v_lil_period AS A88 ON A11.per_id = A88.per_id
 INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp AS A50 ON A11.rtl_lvl = A50.rtl_lvl
 INNER JOIN ldl_p_lew_mart_cm.v_lil_retailer_type AS A55 ON A50.rtl_tp_id = A55.rtl_tp_id
WHERE (A88.per_lvl IN (1) AND (A88.per_id >= 12201713 OR A50.rtl_tp_id NOT IN (2)) OR A88.per_lvl IN (3) AND (A88.per_id
          >= 3201713 OR A50.rtl_tp_id NOT IN (2)) OR A88.per_lvl IN (4) AND (A88.per_id >= 201713 OR A50.rtl_tp_id
        NOT IN (2)) OR A88.per_lvl IN (2) AND (A88.per_id >= 6201713 OR A50.rtl_tp_id NOT IN (2)))
 AND A11.prom_id IN (1)
 AND A55.rtl_tp_id IN (2, 3)
 AND A13.gfk_cat_type_id = CASE
   WHEN A88.per_yr = 2019
   THEN CASE
    WHEN A13.gfk_cat_type_id = 0
    THEN 0
    ELSE 1
    END
   ELSE A13.gfk_cat_type_id
   END
 AND A12.rtl_id NOT IN (10, 930000, 940000, 970000, 960000)
GROUP BY A12.rtl_id,
 A11.lift_cat_id,
 islidl,
 A11.client_id,
 A11.per_id,
 A11.currency_iso_cd,
 A55.rtl_tp_id;

