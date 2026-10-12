/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CM.V_LIL_LIAM_DM_CHART15_2
#----------------------------------------------------------------------------
# History:
#  1.0  <=10.07.2024  -                        Generated from Teradata
#  1.1  12.07.2024    Winkowski,Krzysztof      Fixed: division by zero issue
#----------------------------------------------------------------------------
*/




CREATE OR REPLACE TABLE ldl_p_lew_mart_cm.v_lil_liam_dm_chart15_2 
AS 
WITH BUYERSSPEND AS (SELECT A.client_id,
   A.liam_parnt_clnt_cat_id,
   A.per_id,
   A.rtl_id,
   B.rtl_tp_id,
   SUM(A.val) AS value
  FROM ldl_p_lew_mart_cm.v_lil_liam_data_act_2 AS A
   INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp_2 AS B ON A.rtl_lvl = B.rtl_lvl
   INNER JOIN ldl_p_lew_mart_cm.v_lil_liam_clnt_cat_2 AS CAT ON A.liam_clnt_cat_id = CAT.liam_clnt_cat_id
  WHERE A.meas_id = 37
   AND A.prom_id = 1
   AND A.currency_iso_cd = 'EUR'
   AND B.rtl_tp_id IN (2, 3)
   AND CAT.clnt_cat_lvl = 2
   AND A.rtl_id NOT IN (930000, 940000, 930100, 930200)
  GROUP BY A.client_id,
   A.rtl_id,
   A.per_id,
   A.liam_parnt_clnt_cat_id,
   B.rtl_tp_id), BUYERSSPENDTOTAL AS (SELECT A0.client_id,
   A0.liam_parnt_clnt_cat_id,
   A0.per_id,
   B0.rtl_tp_id,
   A0.val AS value
  FROM ldl_p_lew_mart_cm.v_lil_liam_data_act_2 AS A0
   INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp_2 AS B0 ON A0.rtl_lvl = B0.rtl_lvl
   INNER JOIN ldl_p_lew_mart_cm.v_lil_liam_clnt_cat_2 AS CAT0 ON A0.liam_clnt_cat_id = CAT0.liam_clnt_cat_id
  WHERE A0.meas_id = 37
   AND A0.prom_id = 1
   AND A0.currency_iso_cd = 'EUR'
   AND B0.rtl_tp_id IN (2, 3)
   AND A0.rtl_id = 10
   AND CAT0.clnt_cat_lvl = 2), MARKET_SHARE AS (SELECT BS.client_id,
   BS.liam_parnt_clnt_cat_id,
   BS.per_id,
   BS.rtl_id,
   BS.rtl_tp_id,
    IF(BST.value = 0, 0, SAFE_DIVIDE(BS.value, BST.value)) * 100 AS val
  FROM BUYERSSPEND AS BS
   INNER JOIN BUYERSSPENDTOTAL AS BST ON BS.client_id = BST.client_id AND BS.liam_parnt_clnt_cat_id = BST.liam_parnt_clnt_cat_id
        AND BS.per_id = BST.per_id AND BS.rtl_tp_id = BST.rtl_tp_id) (SELECT DM.liam_clnt_cat_id,
   DM.currency_iso_cd,
   DM.liam_parnt_clnt_cat_id AS liam_prnt_cat_id,
   DM.client_id,
   DM.per_id,
   DM.rtl_id AS clnt_rtl_id,
   DM.rtl_tp_id AS clnt_rtl_lvl,
   CAST(DM.liamvaluelidlcattototalshare AS NUMERIC) AS liamvaluelidlcattototalshare,
   CAST(DM.liamvaluepotlidlcattototalshar AS NUMERIC) AS liamvaluepotlidlcattototalshar,
   DM.valuelidl,
   DM.valuepotentiallidl,
   DM.valuepotentialexploitationlidl,
   DM.valuepotentialexploitation,
   DM.vpegappp,
   CAST(DM.avplidlsharebar AS NUMERIC) AS avplidlsharebar,
    CASE
    WHEN DM.addedvaluepotentiallidl > 0
    THEN ROUND(DM.addedvaluepotentiallidl)
    ELSE NULL
    END AS addedvaluepotentiallidl,
   CAST(DM.liamvaluelidltfmcg AS NUMERIC) AS liamvaluelidltfmcg,
   DM_PY.valuelidl AS py_valuelidl,
   DM_PY.valuepotentiallidl AS py_valuepotentiallidl,
   DM_PY.valuepotentialexploitationlidl AS py_valuepotentialexploitationlidl,
   DM_PY.valuepotentialexploitation AS py_valuepotentialexploitation,
   DM_PY.vpegappp AS py_vpegappp,
    CASE
    WHEN DM_PY.addedvaluepotentiallidl > 0
    THEN ROUND(DM_PY.addedvaluepotentiallidl)
    ELSE NULL
    END AS py_addedvaluepotentiallidl,
   DM.maxrawbuyer,
   DM.maxrawbuyerlidl,
   MS.val,
   1 AS prot_fg
  FROM ldl_p_lew_process_mstr_ac.v_lil_liam_dm_chart15_2 AS DM
   LEFT JOIN MARKET_SHARE AS MS ON DM.client_id = MS.client_id AND DM.per_id = MS.per_id AND DM.rtl_id = MS.rtl_id AND
      DM.rtl_tp_id = MS.rtl_tp_id AND DM.liam_parnt_clnt_cat_id = MS.liam_parnt_clnt_cat_id
   INNER JOIN ldl_p_lew_mart_cm.v_lil_period_2 AS PER ON DM.per_id = PER.per_id
   LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_liam_dm_chart15_2 AS DM_PY ON PER.py_per_id = DM_PY.per_id AND DM.client_id =
          DM_PY.client_id AND DM.rtl_id = DM_PY.rtl_id AND DM.rtl_tp_id = DM_PY.rtl_tp_id AND DM.liam_clnt_cat_id =
       DM_PY.liam_clnt_cat_id AND DM.currency_iso_cd = DM_PY.currency_iso_cd AND DM.liam_parnt_clnt_cat_id = DM_PY.liam_parnt_clnt_cat_id
     
  WHERE DM.valuelidl <> 0
   OR DM.valuepotentiallidl <> 0
   OR DM.valuepotentialexploitationlidl <> 0
   OR DM.valuepotentialexploitation <> 0
   OR DM.vpegappp <> 0);

