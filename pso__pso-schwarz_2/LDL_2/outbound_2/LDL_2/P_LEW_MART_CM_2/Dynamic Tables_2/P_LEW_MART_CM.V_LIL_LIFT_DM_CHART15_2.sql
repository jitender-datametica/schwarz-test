CREATE OR REPLACE TABLE ldl_p_lew_mart_cm.v_lil_lift_dm_chart15_2 AS WITH CLIENT_PERIOD AS (SELECT v_lil_client.client_id,
   v_lil_period.per_id,
   v_lil_period.per_tp_id
  FROM ldl_p_lew_mart_cm.v_lil_client_2
   INNER JOIN ldl_p_lew_mart_cm.v_lil_period_2 ON TRUE), CLIENT_PERIOD_RTL AS (SELECT DISTINCT a.client_id,
   a.per_id,
   B.rtl_id,
   C.rtl_tp_id,
   a.per_tp_id
  FROM CLIENT_PERIOD AS a
   INNER JOIN ldl_p_lew_mart_cm.v_lil_lift_data_act_2 AS B ON a.client_id = B.client_id AND a.per_id = B.per_id
   INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp_2 AS C ON B.rtl_lvl = C.rtl_lvl
  WHERE C.rtl_tp_id IN (2, 3)
   AND B.rtl_id NOT IN (930000, 940000, 930100, 930200)), BUYERSSPEND AS (SELECT A.client_id,
   A.per_id,
   A.rtl_id,
   B0.rtl_tp_id,
   SUM(A.val) AS value
  FROM ldl_p_lew_mart_cm.v_lil_lift_data_act_2 AS A
   INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp_2 AS B0 ON A.rtl_lvl = B0.rtl_lvl
  WHERE A.meas_id = 37
   AND A.prom_id = 1
   AND A.lift_cat_id = 1
   AND A.currency_iso_cd = 'EUR'
   AND B0.rtl_tp_id IN (2, 3)
   AND A.rtl_id NOT IN (930000, 940000, 930100, 930200)
  GROUP BY A.client_id,
   A.rtl_id,
   A.per_id,
   B0.rtl_tp_id), BUYERSSPENDTOTAL AS (SELECT DISTINCT A0.client_id,
   A0.per_id,
   B1.rtl_tp_id,
   A0.val AS value
  FROM ldl_p_lew_mart_cm.v_lil_lift_data_act_2 AS A0
   INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp_2 AS B1 ON A0.rtl_lvl = B1.rtl_lvl
  WHERE A0.meas_id = 37
   AND A0.prom_id = 1
   AND A0.lift_cat_id = 1
   AND A0.currency_iso_cd = 'EUR'
   AND B1.rtl_tp_id IN (2, 3)
   AND A0.rtl_id = 10), MARKET_SHARE AS (SELECT BS.client_id,
   BS.per_id,
   BS.rtl_id,
   BS.rtl_tp_id,
    IF(BST.value = 0, 0, SAFE_DIVIDE(BS.value, BST.value)) * 100 AS val
  FROM BUYERSSPEND AS BS
   INNER JOIN BUYERSSPENDTOTAL AS BST ON BS.client_id = BST.client_id AND BS.per_id = BST.per_id AND BS.rtl_tp_id = BST
     .rtl_tp_id), MS_FINAL AS (SELECT t11.client_id,
   t11.per_id,
   t11.rtl_id,
   t11.rtl_tp_id,
   t11.per_tp_id,
   t11.val,
   t11.grp,
   COALESCE(t11.val, MAX(t11.val) OVER (PARTITION BY CAST(t11.client_id AS STRING), CAST(t11.rtl_tp_id AS STRING), CAST(t11.rtl_id AS STRING)
       , CAST(t11.per_tp_id AS STRING), t11.grp ORDER BY t11.client_id IS NULL, t11.client_id, t11.per_id IS NULL, t11.per_id
       , t11.rtl_tp_id IS NULL, t11.rtl_tp_id, t11.per_tp_id IS NULL, t11.per_tp_id, t11.val IS NULL DESC, t11.val DESC
       , t11.grp IS NULL, t11.grp RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) AS val_win
  FROM (SELECT A.client_id,
     A.per_id,
     A.rtl_id,
     A.rtl_tp_id,
     A.per_tp_id,
     B.val,
     COUNT(B.val) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.rtl_tp_id AS STRING), CAST(A.rtl_id AS STRING)
        , CAST(A.per_tp_id AS STRING) ORDER BY A.client_id IS NULL, A.client_id, A.per_id IS NULL, A.per_id, A.rtl_tp_id
        IS NULL, A.rtl_tp_id, A.per_tp_id IS NULL, A.per_tp_id, B.val IS NULL DESC, B.val DESC RANGE BETWEEN
      UNBOUNDED PRECEDING AND CURRENT ROW) AS grp
    FROM CLIENT_PERIOD_RTL AS A
     LEFT JOIN MARKET_SHARE AS B ON A.client_id = B.client_id AND A.per_id = B.per_id AND A.rtl_id = B.rtl_id AND A.rtl_tp_id
        = B.rtl_tp_id) AS t11
  ORDER BY 1 NULLS LAST,
   2 NULLS LAST,
   4 NULLS LAST,
   6 DESC NULLS FIRST), MAT_LATEST AS (SELECT client_id,
   MAX(per_id) AS per_id_not_latest
  FROM ldl_p_lew_process_mstr_ac.v_lil_lift_dm_chart15_2
  WHERE per_id <> 15000000
  GROUP BY client_id), Q_LATEST AS (SELECT client_id,
   MAX(per_id) AS per_id_not_latest
  FROM ldl_p_lew_process_mstr_ac.v_lil_lift_dm_chart15_2
  WHERE per_id <> 3500000
   AND CAST(SUBSTR(SUBSTR(CAST(per_id AS STRING), 1, 39), 0, 1) AS FLOAT64) = 3
  GROUP BY client_id) (SELECT DM.lift_cat_id,
   DM.client_id,
   DM.per_id,
    CASE
    WHEN DM.per_id IN (15000000)
    THEN MAT.per_id_not_latest
    WHEN DM.per_id IN (3500000)
    THEN Q.per_id_not_latest
    ELSE DM.per_id
    END AS per_id_not_latest,
   DM.rtl_id AS clnt_rtl_id,
   DM.rtl_tp_id AS clnt_rtl_lvl,
   DM.currency_iso_cd,
   ROUND(CAST(DM.valuelidlcattototalshare AS NUMERIC), 5) AS v_lidl_cat_ttshare,
   DM.valuelidl as value_lidl,
   ROUND(CAST(DM.valuepotlidlcattototalshare AS NUMERIC), 5) AS valuepot_lidl_cat_ttshare,
   DM.valuepotentiallidl AS valuepot_lidl,
   ROUND(CAST(DM.valuepotentialexploitationlidl AS NUMERIC), 5) AS vpe_lidl_bar,
   DM.valuepotentialexploitationlidl AS vpe_lidl,
   ROUND(CAST(DM.valuepotentialexploitation AS NUMERIC), 5) AS vpe_bar,
   DM.valuepotentialexploitation AS vpe,
   ROUND(CAST(DM.vpegappp AS NUMERIC), 5) AS vpe_gap_pp_bar,
   DM.vpegappp AS vpe_gap_pp,
   ROUND(CAST(DM.avplidlsharebar AS NUMERIC), 5) AS avp_lidl_share_bar,
    CASE
    WHEN DM.addedvaluepotentiallidl > 0
    THEN ROUND(DM.addedvaluepotentiallidl)
    ELSE NULL
    END AS avp_lidl,
   DM_PY.valuelidl AS py_valuelidl,
   DM_PY.valuepotentiallidl AS py_valuepot_lidl,
   DM_PY.valuepotentialexploitationlidl AS py_vpe_lidl,
   DM_PY.valuepotentialexploitation AS py_vpe,
   DM_PY.vpegappp AS py_vpe_gap_pp,
    CASE
    WHEN DM_PY.addedvaluepotentiallidl > 0
    THEN ROUND(DM_PY.addedvaluepotentiallidl)
    ELSE NULL
    END AS py_avp_lidl,
   DM.maxrawbuyer AS rb,
   DM.maxrawbuyerlidl AS rb_lidl,
   0 AS prot_fg,
   MS.val_win AS market_share
  FROM ldl_p_lew_process_mstr_ac.v_lil_lift_dm_chart15_2 AS DM
   LEFT JOIN MS_FINAL AS MS ON DM.client_id = MS.client_id AND DM.per_id = MS.per_id AND DM.rtl_id = MS.rtl_id AND DM.rtl_tp_id
      = MS.rtl_tp_id
   INNER JOIN MAT_LATEST AS MAT ON DM.client_id = MAT.client_id
   INNER JOIN Q_LATEST AS Q ON DM.client_id = Q.client_id
   INNER JOIN ldl_p_lew_mart_cm.v_lil_period_2 AS PER ON CASE
     WHEN DM.per_id IN (15000000)
     THEN MAT.per_id_not_latest
     WHEN DM.per_id IN (3500000)
     THEN Q.per_id_not_latest
     ELSE DM.per_id
     END = PER.per_id
   LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_lift_dm_chart15_2 AS DM_PY ON PER.py_per_id = DM_PY.per_id AND DM.client_id =
         DM_PY.client_id AND DM.rtl_id = DM_PY.rtl_id AND DM.rtl_tp_id = DM_PY.rtl_tp_id AND DM.lift_cat_id = DM_PY.lift_cat_id
       AND DM.currency_iso_cd = DM_PY.currency_iso_cd);