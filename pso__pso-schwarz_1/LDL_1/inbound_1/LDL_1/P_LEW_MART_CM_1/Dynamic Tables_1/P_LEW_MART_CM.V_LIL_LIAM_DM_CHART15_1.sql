
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CM.V_LIL_LIAM_DM_CHART15_1
#----------------------------------------------------------------------------
# History:
#  1.0  <=10.07.2024  -                        Generated from Teradata
#  1.1  12.07.2024    Winkowski,Krzysztof      Fixed: division by zero issue
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LIAM_DM_CHART15_1
 (
    liam_clnt_cat_id
    , currency_iso_cd
    , liam_prnt_cat_id
    , client_id
    , per_id
    , clnt_rtl_id
    , clnt_rtl_lvl
    , LIAMVALUELIDLCATTOTOTALSHARE
    , LIAMVALUEPOTLIDLCATTOTOTALSHAR
    , VALUELIDL
    , VALUEPOTENTIALLIDL
    , VALUEPOTENTIALEXPLOITATIONLIDL
    , VALUEPOTENTIALEXPLOITATION
    , VPEGAPPP
    , AVPLIDLSHAREBAR
    , ADDEDVALUEPOTENTIALLIDL
    , LIAMVALUELIDLTFMCG
    , PY_VALUELIDL
    , PY_VALUEPOTENTIALLIDL
    , PY_VALUEPOTENTIALEXPLOITATIONLIDL
    , PY_VALUEPOTENTIALEXPLOITATION
    , PY_VPEGAPPP
    , PY_ADDEDVALUEPOTENTIALLIDL
    , MAXRAWBUYER
    , MAXRAWBUYERLIDL
    , val
    , prot_fg
) 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
WITH BuyersSpend AS(
SELECT
    a.client_id
    ,a.liam_parnt_clnt_cat_id
    ,a.per_id
    ,a.rtl_id
    ,b.rtl_tp_id
    ,SUM(a.val) AS "Value"
FROM P_LEW_MART_CM.V_LIL_LIAM_DATA_ACT_1 a
JOIN P_LEW_MART_CM.V_LIL_RTL_LVL_TP_1 b
ON a.rtl_lvl = b.rtl_lvl
JOIN P_LEW_MART_CM.V_LIL_LIAM_CLNT_CAT_1 cat
ON a.liam_clnt_cat_id =  cat.liam_clnt_cat_id
WHERE meas_id = 37 AND prom_id =1 AND currency_iso_cd = 'EUR' AND rtl_tp_id IN (2,3) AND rtl_id NOT IN (930000, 940000, 930100, 930200) AND clnt_cat_lvl = 2
GROUP BY 1,2,3,4,5)
,BuyersSpendTotal AS(
SELECT
    a.client_id
    ,a.liam_parnt_clnt_cat_id
    ,a.per_id
    ,b.rtl_tp_id
    ,val AS "Value"
FROM P_LEW_MART_CM.V_LIL_LIAM_DATA_ACT_1 a
JOIN P_LEW_MART_CM.V_LIL_RTL_LVL_TP_1 b
ON a.rtl_lvl = b.rtl_lvl
JOIN P_LEW_MART_CM.V_LIL_LIAM_CLNT_CAT_1 cat
ON a.liam_clnt_cat_id =  cat.liam_clnt_cat_id
WHERE meas_id = 37 AND prom_id =1 AND currency_iso_cd = 'EUR' AND rtl_tp_id IN (2,3) AND rtl_id = 10 AND clnt_cat_lvl = 2)
,MARKET_SHARE AS(
SELECT
   BS.client_id
  ,BS.liam_parnt_clnt_cat_id
  ,BS.per_id
  ,BS.rtl_id
  ,BS.rtl_tp_id
  ,DIV0(BS.Value,BST.Value)*100 AS "val"
FROM BuyersSpend BS
JOIN BuyersSpendTotal BST
  ON BS.client_id = BST.client_id
  AND BS.liam_parnt_clnt_cat_id = BST.liam_parnt_clnt_cat_id
  AND BS.per_id = BST.per_id
  AND BS.rtl_tp_id = BST.rtl_tp_id
)
 SELECT 
   DM.liam_clnt_cat_id
  ,DM.currency_iso_cd
  ,DM.liam_parnt_clnt_cat_id AS liam_prnt_cat_id
  ,DM.client_id
  ,DM.per_id
  ,DM.rtl_id AS clnt_rtl_id
  ,DM.rtl_tp_id AS clnt_rtl_lvl
  ,(DM.LIAMVALUELIDLCATTOTOTALSHARE)::DECIMAL(23,5)
  ,(DM.LIAMVALUEPOTLIDLCATTOTOTALSHAR)::DECIMAL(23,5)
  ,DM.VALUELIDL AS VALUELIDL
  ,DM.VALUEPOTENTIALLIDL AS VALUEPOTENTIALLIDL
  ,DM.VALUEPOTENTIALEXPLOITATIONLIDL  AS VALUEPOTENTIALEXPLOITATIONLIDL
  ,DM.VALUEPOTENTIALEXPLOITATION AS VALUEPOTENTIALEXPLOITATION
  ,DM.VPEGAPPP  AS VPEGAPPP
  ,(DM.AVPLIDLSHAREBAR)::DECIMAL(23,5)
  ,(CASE WHEN DM.ADDEDVALUEPOTENTIALLIDL > 0 THEN ROUND(DM.ADDEDVALUEPOTENTIALLIDL) ELSE NULL END) AS ADDEDVALUEPOTENTIALLIDL
  ,(DM.LIAMVALUELIDLTFMCG)::DECIMAL(23,5)
  ,DM_PY.VALUELIDL AS PY_VALUELIDL
  ,DM_PY.VALUEPOTENTIALLIDL AS PY_VALUEPOTENTIALLIDL
  ,DM_PY.VALUEPOTENTIALEXPLOITATIONLIDL AS PY_VALUEPOTENTIALEXPLOITATIONLIDL
  ,DM_PY.VALUEPOTENTIALEXPLOITATION  AS PY_VALUEPOTENTIALEXPLOITATION
  ,DM_PY.VPEGAPPP AS PY_VPEGAPPP
  ,(CASE WHEN DM_PY.ADDEDVALUEPOTENTIALLIDL > 0 THEN ROUND(DM_PY.ADDEDVALUEPOTENTIALLIDL) ELSE NULL END) AS PY_ADDEDVALUEPOTENTIALLIDL
  ,DM.MAXRAWBUYER
  ,DM.MAXRAWBUYERLIDL
  ,MS.val
  ,CAST(1 AS BYTEINT) AS prot_fg
 FROM p_lew_process_mstr_ac.v_lil_liam_dm_chart15_1 DM
 LEFT JOIN MARKET_SHARE MS
  ON MS.client_id = DM.CLIENT_ID
  AND MS.per_id = DM.PER_ID
  AND MS.rtl_id = DM.rtl_id
  AND MS.rtl_tp_id = DM.rtl_tp_id
  AND MS.liam_parnt_clnt_cat_id = DM.liam_parnt_clnt_cat_id
 JOIN P_LEW_MART_CM.V_LIL_PERIOD_1 PER
  ON DM.per_id=PER.per_id
 LEFT JOIN p_lew_process_mstr_ac.v_lil_liam_dm_chart15_1 DM_PY
  ON DM_PY.per_id = PER.PY_PER_ID
  AND DM_PY.client_id = DM.CLIENT_ID
  AND DM_PY.rtl_id = DM.rtl_id
  AND DM_PY.rtl_tp_id = DM.rtl_tp_id
  AND DM_PY.liam_clnt_cat_id = DM.liam_clnt_cat_id
  AND DM_PY.currency_iso_cd = DM.currency_iso_cd
  AND DM_PY.liam_parnt_clnt_cat_id = DM.liam_parnt_clnt_cat_id
  WHERE  DM.VALUELIDL <> 0
    OR  DM.VALUEPOTENTIALLIDL <> 0
    OR  DM.VALUEPOTENTIALEXPLOITATIONLIDL <> 0
    OR  DM.VALUEPOTENTIALEXPLOITATION <> 0
    OR  DM.VPEGAPPP <> 0;
