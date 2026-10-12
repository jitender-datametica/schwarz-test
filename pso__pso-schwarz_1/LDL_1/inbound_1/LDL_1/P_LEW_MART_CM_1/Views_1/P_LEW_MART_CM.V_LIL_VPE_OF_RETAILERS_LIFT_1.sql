CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_VPE_OF_RETAILERS_LIFT_1 
(
    rtl_id
    , lift_cat_id
    , VALUEPOTENTIAL
    , VPE
    , IsLidl
    , client_id
    , per_id
    , currency_iso_cd
    , Rnk_id
    , Rnk_desc
    , Max_Raw_buyer
    , rtl_tp_id
)
AS
SELECT 
    a12.rtl_id AS rtl_id
    ,a13.lift_cat_id AS lift_cat_id
    ,SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) AS VALUEPOTENTIAL
    ,(SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) ) - SUM(CASE WHEN a11.meas_id = 5 THEN a11.py_val ELSE NULL END) AS VPE
    ,(CASE WHEN UPPER(TRIM(a12.rtl_desc)) = 'LIDL' THEN 1 ELSE 0 END) AS IsLidl
    ,a11.client_id AS client_id
    ,a11.per_id AS per_id
    ,a11.currency_iso_cd AS currency_iso_cd
    ,(RANK () OVER(PARTITION BY  a11.per_id,a11.client_id,a13.lift_cat_id, a55.rtl_tp_id, a11.currency_iso_cd ORDER BY SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) DESC)) AS Rnk_id
    ,'#'|| TRIM((RANK () OVER(PARTITION BY  a11.per_id,a11.client_id,a13.lift_cat_id, a55.rtl_tp_id, a11.currency_iso_cd ORDER BY SUM(CASE WHEN a11.meas_id = 5 THEN a11.val ELSE NULL END) DESC))) AS Rnk_desc
    ,MAX(a11.raw_buyer_id) AS Max_Raw_buyer
    ,a55.rtl_tp_id AS rtl_tp_id
FROM    P_LEW_MART_CM.v_lil_lift_data_act_1 AS a11
    INNER JOIN  P_LEW_MART_CM.v_lil_retailer_1 AS a12
      ON    (a11.rtl_id = a12.rtl_id)
    INNER JOIN  P_LEW_MART_CM.v_lil_client_1 AS a99
      ON    (a11.client_id = a99.client_id)
    INNER JOIN  P_LEW_MART_CM.v_lil_lift_cat_1 AS a13
      ON    (a11.lift_cat_id = a13.lift_cat_id)
    INNER JOIN  P_LEW_MART_CM.v_lil_period_1 AS a88
      ON    (a11.per_id = a88.per_id)
    INNER JOIN  P_LEW_MART_CM.v_lil_rtl_lvl_tp_1 AS a50
      ON    (a11.rtl_lvl = a50.rtl_lvl)
    INNER JOIN  P_LEW_MART_CM.v_lil_retailer_type_1 AS a55
      ON    (a50.rtl_tp_id = a55.rtl_tp_id)
WHERE
(
((a88.per_lvl IN (1)
 AND (a88.per_id >=  12201713
 OR NOT (a50.rtl_tp_id IN (2))))
 OR (a88.per_lvl IN (3)
 AND (a88.per_id >=  3201713
 OR NOT (a50.rtl_tp_id IN (2))))
 OR (a88.per_lvl IN (4)
 AND (a88.per_id >=  201713
 OR NOT (a50.rtl_tp_id IN (2))))
 OR (a88.per_lvl IN (2)
 AND (a88.per_id >=  6201713
 OR NOT (a50.rtl_tp_id IN (2)))))
 AND a11.prom_id IN (1)
 AND a55.rtl_tp_id IN (2, 3)
 AND NOT (a12.rtl_id IN (10, 930000, 940000, 970000, 960000))
AND (a13.gfk_cat_type_id= DECODE(a88.per_yr,2019, DECODE(a13.gfk_cat_type_id,0,0,1),a13.gfk_cat_type_id))
)
GROUP BY 1,2,5,6,7,8,12;
