create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_AAD_SCENARIO_HIT_1(
	SCENARIO_ID,
	BON_ID,
	BON_DAT,
	WUP_ID,
	MANDANT_ID,
	WRG_ID,
	BON_NR,
	BON_BOOKING,
	KASSE_NR,
	HASHED_CASHIER_ID,
	FRAUD_VALUE_GROSS_LOCAL_VAL,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP,
	CNT_ZEILE_HIT,
	AKTUELLER_STATUS_HIT
) as







WITH t_antrag_bediener AS

( SELECT
    MANDANT_ID,
    HASHED_CASHIER_ID,
    MAX(REQUEST_STATUS_TYPE_ID) AS max_status_pro_Bediener
    FROM DBP_MSI_DATA.TS_AAD_REQUEST_WORKFLOW_1
    WHERE EXPIRATION_TMSP > CURRENT_DATE() 
    GROUP BY    MANDANT_ID,
    HASHED_CASHIER_ID
)
, thresholds AS
(
  SELECT
    scenario_id
  , mandant_id
  , region_id       AS vs_id
  , MAX(CASE WHEN scenario_metric_id = 98 THEN scenario_metric_threshold_init_val ELSE NULL END) timeframe
  , MAX(CASE WHEN scenario_metric_id = 99 THEN scenario_metric_threshold_init_val ELSE NULL END) cnt_hits
  FROM DBP_VIEW.V_AAD_SCENARIO_METRIC_THRESHOLD_1
  GROUP BY
    scenario_id
  , mandant_id
  , region_id
)
SELECT DISTINCT
  v01.scenario_id
, v01.bon_id
, v01.bon_dat
, v03.aktuell_wup_id AS wup_id
, v01.mandant_id
, v01.wrg_id
, v01.bon_nr
, v01.bon_booking
, v01.kasse_nr
, v01.hashed_cashier_id
, v01.fraud_value_gross_local_val
, v01.dwh_created_tmsp
, v01.dwh_updated_tmsp
, 1 AS CNT_ZEILE_HIT
, COALESCE(v02.max_status_pro_Bediener,0) AS aktueller_Status_HIT
FROM 
(
    SELECT DISTINCT
      hits.scenario_id
    , hits.bon_id
    , hits.bon_dat
    , hits.wup_id
    , hits.mandant_id
    , hits.wrg_id
    , hits.bon_nr
    , hits.bon_booking
    , hits.kasse_nr
    , hits.hashed_cashier_id
    , hits.fraud_value_gross_local_val
    , hits.dwh_created_tmsp
    , hits.dwh_updated_tmsp
    , COUNT(*) OVER (PARTITION BY  hits.scenario_id
                                  ,hits.mandant_id
                                  ,hits.wup_id
                                  ,hits.hashed_cashier_id
                                  ,tmp.bon_dat) AS cnt_hits_in_timeframe
    , tmp.cnt_hits
    FROM DBP_VIEW.V_AAD_SCENARIO_HIT_1 hits
        INNER JOIN
         (
            SELECT
              sh.scenario_id
            , sh.bon_dat
            , sh.wup_id
            , sh.mandant_id
            , sh.hashed_cashier_id
            , COALESCE (thr_reg.timeframe, thr_cntr.timeframe)   AS timeframe
            , COALESCE (thr_reg.cnt_hits, thr_cntr.cnt_hits)     AS cnt_hits
            , DATEADD (DAY, -COALESCE (thr_reg.timeframe, thr_cntr.timeframe), sh.bon_dat) date_from
            FROM DBP_VIEW.V_AAD_SCENARIO_HIT_1 AS sh
                INNER JOIN  DBP_VIEW.V_WUP_1 AS w
                   ON w.mandant_id = sh.mandant_id
                  AND w.wup_id     = sh.wup_id
                INNER JOIN thresholds AS thr_cntr                                                                                          
                   ON sh.scenario_id = thr_cntr.scenario_id
                  AND sh.mandant_id  = thr_cntr.mandant_id
                  AND thr_cntr.vs_id = 0                        
                LEFT OUTER JOIN thresholds AS thr_reg                                                                                          
                   ON sh.scenario_id = thr_reg.scenario_id
                  AND sh.mandant_id  = thr_reg.mandant_id
                  AND w.vs_id        = thr_reg.vs_id            
               GROUP BY
                 sh.scenario_id
               , sh.mandant_id
               , sh.wup_id
               , sh.hashed_cashier_id
               , sh.bon_dat
               , COALESCE (thr_reg.timeframe, thr_cntr.timeframe)
               , COALESCE (thr_reg.cnt_hits, thr_cntr.cnt_hits)
         ) AS tmp
        ON hits.scenario_id = tmp.scenario_id
       AND hits.mandant_id = tmp.mandant_id
       AND hits.wup_id = tmp.wup_id
       AND hits.hashed_cashier_id = tmp.hashed_cashier_id
       AND hits.bon_dat BETWEEN tmp.date_from AND tmp.bon_dat
) v01
LEFT JOIN t_antrag_bediener v02
ON v01.mandant_id = v02.mandant_id
AND v01.hashed_cashier_id = v02.hashed_cashier_id

INNER JOIN dbp_view.v_wup_1 v03
ON v01.wup_id = v03.wup_id
AND v01.mandant_id = v03.mandant_id

WHERE v01.cnt_hits_in_timeframe >= v01.cnt_hits
;