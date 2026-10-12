CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_VPE_OF_RETAILERS_LIAM_2
(
  client_id
  , per_id
  , liam_clnt_cat_id
  , liam_parnt_clnt_cat_id
  , ValuePotential
  , VPE
  , IsLidl
  , rtl_id
  , Rnk_id
  , Rnk_desc
  , max_raw_buyer
  , rtl_tp_id
  , currency_iso_cd
)
AS
SELECT 
     a13.client_id AS client_id
    , a15.per_id AS per_id
    , a13.liam_clnt_cat_id AS liam_clnt_cat_id
    , a11.liam_parnt_clnt_cat_id AS liam_parnt_clnt_cat_id
    , SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) AS ValuePotential
    , (SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) ) - SUM(CASE WHEN a11.meas_id = 5 THEN a11.py_val ELSE NULL END) AS VPE
    , (CASE WHEN UPPER(TRIM(a12.rtl_desc)) = 'LIDL' THEN 1 ELSE 0 END) AS IsLidl
    , a12.rtl_id AS rtl_id
    , (RANK () Over(PARTITION BY a15.per_id,a13.client_id,a13.liam_clnt_cat_id, a55.rtl_tp_id, a11.currency_iso_cd  ORDER BY SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) DESC)) AS Rnk_id
    , '#'|| TRIM((RANK () Over(PARTITION BY a15.per_id,a13.client_id,a13.liam_clnt_cat_id, a55.rtl_tp_id, a11.currency_iso_cd  ORDER BY SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) DESC))) AS Rnk_desc
    , MAX(a11.raw_buyer_id) AS max_raw_buyer
    , a55.rtl_tp_id AS rtl_tp_id
    , a11.currency_iso_cd AS currency_iso_cd
FROM    P_LEW_MART_CM.v_lil_liam_data_act_2 AS a11
    INNER JOIN  P_LEW_MART_CM.v_lil_retailer_2 AS a12
      ON    (a12.rtl_id = a11.rtl_id)
    INNER JOIN  P_LEW_MART_CM.v_lil_liam_clnt_cat_2 AS a13
      ON    (a11.client_id = a13.client_id AND 
    a11.liam_clnt_cat_id = a13.liam_clnt_cat_id)
    INNER JOIN  P_LEW_MART_CM.v_lil_client_2 AS a14
      ON    (a13.client_id = a14.client_id)
    INNER JOIN  P_LEW_MART_CM.v_lil_period_2 AS a15
      ON    (a11.per_id = a15.per_id)
    INNER JOIN  P_LEW_MART_CM.v_lil_rtl_lvl_tp_2 AS a50
      ON    (a11.rtl_lvl = a50.rtl_lvl)
    INNER JOIN  P_LEW_MART_CM.v_lil_retailer_type_2 AS a55
      ON    (a50.rtl_tp_id = a55.rtl_tp_id)
WHERE (a13.clnt_cat_lvl IN (1, 2, 3)
 AND a55.rtl_tp_id IN (3, 2)
AND
(a15.per_id BETWEEN 6201805 AND 6500000
 OR a15.per_id BETWEEN 3201805 AND 3500000
 OR a15.per_id BETWEEN 12201805 AND 15000000
 OR a15.per_id BETWEEN 201805 AND 250000
 OR NOT (a55.rtl_tp_id IN (2)))
 AND NOT (a12.rtl_id IN (10, 930000, 940000))
 AND a11.prom_id IN (1)
 AND a11.meas_id = 5
)
GROUP BY 1,2,3,4,7,8,12,13
HAVING SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) IS NOT NULL;
