
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_WH_MONTH_COSTS_LOGISTIC_TOTAL_1 AS
(SELECT
  agg.client_id
, agg.cy_month
, CASE
       WHEN    agg.client_id    =    1    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    2    AND    agg.wh_id    =    10    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    3    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    4    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    5    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    6    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    8    AND    agg.wh_id    =    50    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    9    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    10    AND    agg.wh_id    =    10    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    11    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    12    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    13    AND    agg.wh_id    =    50    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    14    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    15    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    16    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    17    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    18    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    19    AND    agg.wh_id    =    51    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    20    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)       
       WHEN    agg.client_id    =    21    AND    agg.wh_id    =    2    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    22    AND    agg.wh_id    =    100    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    23    AND    agg.wh_id    =    99    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    24    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    25    AND    agg.wh_id    =    998    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    26    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    27    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    28    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    29    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    32    AND    agg.wh_id    =    700    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    33    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       WHEN    agg.client_id    =    34    AND    agg.wh_id    =    1    THEN    agg.client_id    *(-1)
       ELSE agg.wh_id
   END wh_id
, agg.currency_iso_cd
, Cast(CASE WHEN ref_cur.currency_iso_cd = 'EUR'
         THEN 0
       WHEN ref_cur.currency_iso_cd = 'GBP'
         THEN 40
       ELSE ref_cur.client_id
      END AS SMALLINT) AS curr_tot_id
, agg.current_year_act_val
, agg.current_year_plan_val
, agg.prev_year_act_val

FROM p_lew_bil_ac.v_agg_wh_month_costs_logistic_total_1 AS agg
INNER JOIN
(
    SELECT
        client_id
        , 'EUR' AS currency_iso_cd
    FROM p_lew_core_ac.v_client_1
    WHERE curr_cd <> 'EUR'
        UNION ALL
    SELECT
        client_id
        , curr_cd AS currency_iso_cd
    FROM p_lew_core_ac.v_client_1
) AS ref_cur
ON agg.client_id 		= ref_cur.client_id
AND agg.currency_iso_cd = ref_cur.currency_iso_cd

)
;
