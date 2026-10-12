CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_runbfexecutionextract(IN pClientId FLOAT64, IN pSchema STRING, IN pCalDtFrom STRING, IN pCalDtTo STRING, IN pAdvWeekIdFrom FLOAT64, IN pAdvWeekIdTo FLOAT64, IN pApplicationName STRING, IN pModuleName STRING, IN pRunClusteringDesc STRING, IN pSchemaCoreAC STRING, IN pSchemaBilAC STRING, OUT out_param STRING)
BEGIN
DECLARE _rowCnt BIGNUMERIC;
DECLARE _rowCntExtract INT64;
DECLARE msg STRING;
DECLARE strRunCluster STRING;
DECLARE sqlStmtLogStart STRING;
DECLARE sqlStmtLogEnd STRING;
DECLARE sqlStmtCheck STRING;
DECLARE sqlStmtCnt STRING;
DECLARE sqlStmt STRING;
DECLARE strSchemaCoreAC STRING;
DECLARE strSchemaBilAC STRING;
DECLARE res STRING;
DECLARE resExtract INT64;
-- ---------------------------------------------------------------------
-- PROCEDURE	:	sp_RunBFExecutionWrapper(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pMaxRuns DOUBLE)
-- Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
-- 				pSchema 				STRING
-- 				pApplicationName 		STRING
-- 				pModuleName 			STRING
--     			pRunClusteringDesc    	STRING --> [0] running in sequence
--     			pMaxRuns				DOUBLE
-- Return		:	Error + Error Msg or in success case number of processed Tables
-- Convert		:	None
-- Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
--                 Logging is also enables  but must be enabled!
-- Example		:	CALL P_LEW_MART_PIT_ONPREM.sp_RunBFExecutionExtract (4,'P_LEW_MART_PIT_ONPREM', '2021-07-30','2021-09-01',202130,202135);
-- ------------------------------------------------------------------------
--
-- # History:
-- #  1.0  2021-07-01 Andreas Kurz    	Initial version
-- #  1.3  2021-11-08 Andreas Kurz		Added additional logging

SET _rowCnt  =  0;
SET _rowCntExtract  =  0;
SET msg  =  '';
SET strRunCluster  =  '[0]';
SET sqlStmtLogStart  =  '';
SET sqlStmtLogEnd  =  '';
SET sqlStmtCheck  =  '';
SET sqlStmtCnt  =  '';
SET sqlStmt  =  '';
SET strSchemaCoreAC  =  'P_LEW_CORE_AC';
SET strSchemaBilAC  =  'P_LEW_BIL_AC';

IF pClientId IS NULL OR pClientId IS NULL OR IS_NAN(pClientId) = true
 THEN
    BEGIN
    SET msg  =  'Missing parameter Client ID or not a number: Mandatory Parameter)';
    RAISE USING MESSAGE = msg ;
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
END IF;


IF pAdvWeekIdFrom IS NULL OR pAdvWeekIdFrom IS NULL OR IS_NAN(pAdvWeekIdFrom) = true
 THEN
    BEGIN
    SET msg  =  'Missing Parameter Adv-Week ID From or not a number';
    RAISE USING MESSAGE = msg ;
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
END IF;


IF pAdvWeekIdTo IS NULL OR pAdvWeekIdTo IS NULL OR IS_NAN(pAdvWeekIdTo) = true
 THEN
    BEGIN
    SET msg  =  'Missing Parameter Adv-Week ID To or not a number';
    RAISE USING MESSAGE = msg ;
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
END IF;

-- CHECK INPUT runcluster


IF pRunClusteringDesc = '' OR pRunClusteringDesc IS NULL OR (LENGTH(pRunClusteringDesc) = 0)
 OR pRunClusteringDesc IS NULL THEN
    BEGIN
    SET pRunClusteringDesc  =  strRunCluster;
    END;
ELSE
    BEGIN
    SET strRunCluster  =  UPPER(pRunClusteringDesc);
    END;
END IF;

-- CHECK INPUT pSchemaCoreAC


IF pSchemaCoreAC = '' OR pSchemaCoreAC IS NULL OR (LENGTH(pSchemaCoreAC) = 0)
 OR pSchemaCoreAC IS NULL THEN
    BEGIN
    SET pSchemaCoreAC  =  strSchemaCoreAC;
    END;
ELSE
    BEGIN
    SET strSchemaCoreAC  =  pSchemaCoreAC;
    END;
END IF;

-- CHECK INPUT pSchemaBilAC


IF pSchemaBilAC = '' OR pSchemaBilAC IS NULL OR (LENGTH(pSchemaBilAC) = 0)
 OR pSchemaBilAC IS NULL THEN
    BEGIN
    SET pSchemaBilAC  =  strSchemaBilAC;
    END;
ELSE
    BEGIN
    SET strSchemaBilAC  =  pSchemaBilAC;
    END;
END IF;

SET sqlStmt  =  '''
INSERT INTO `#PSCHEMA#.t_pit_str_dt_item_rcpt_tmp` (
    client_id,
    loc_sid_store,
    cal_dt,
    register_id,
    receipt_id,
    receipt_tmsp,
    receipt_total_sales_net_val,
    receipt_action_sales_net_val,
    receipt_pv_sales_net_val,
    heavy_buyer_fg,
    cherry_picker_fg,
    exclusive_buyer_fg,
    item_sid,
    adv_week_id,
    adv_period_id,
    adv_week_period_start_dt,
    adv_week_period_end_dt,
    orig_item_nr,
    action_type_id,
    adv_theme_sid,
    sub_item_grp_sid,
    item_grp_int_sid
) 
SELECT
    rcpt.client_id,
    rcpt.loc_sid,
    rcpt.dwh_cal_dt,
    rcpt.register_id,
    rcpt.receipt_id,
    rcpt.receipt_tmsp,
    rcpt.receipt_total_sales_net_val,
    rcpt.receipt_action_sales_net_val,
    rcpt.receipt_pv_sales_net_val,
    rcpt.heavy_buyer_fg,
    CASE 
        WHEN awi.action_type_id = 1 THEN rcpt.cherry_picker_fg
        ELSE CAST(0 AS INT64)
    END AS cherry_picker_fg,
    rcpt.exclusive_buyer_fg,
    rcpt.item_sid,
    awi.adv_week_id,
    awi.adv_period_id,
    awi.adv_week_period_start_dt,
    awi.adv_week_period_end_dt,
    awi.orig_item_nr,
    awi.action_type_id,
    awi.adv_theme_sid,
    awi.sub_item_grp_sid,
    awi.item_grp_int_sid
FROM (
    SELECT
        client_id,
        loc_sid,
        item_sid,
        dwh_cal_dt,
        register_id,
        receipt_id,
        receipt_tmsp,
        receipt_total_sales_net_val,
        receipt_action_sales_net_val,
        receipt_pv_sales_net_val,
        heavy_buyer_fg,
        cherry_picker_fg,
        exclusive_buyer_fg
    FROM (
        SELECT
            client_id,
            loc_sid,
            register_id,
            receipt_id,
            receipt_tmsp,
            dwh_cal_dt,
            item_sid,
            receipt_total_sales_net_val,
            receipt_action_sales_net_val,
            receipt_pv_sales_net_val,
            CASE
                WHEN receipt_action_sales_net_val >= 0.7 * (receipt_total_sales_net_val - receipt_ignore_sales_net_val)
                 AND receipt_action_piece_weight_qty >= 0.7 * (receipt_total_piece_weight_qty - receipt_ignore_piece_weight_qty) 
                THEN CAST(1 AS INT64)
                ELSE CAST(0 AS INT64) 
            END AS heavy_buyer_fg,
            CASE
                WHEN receipt_pv_sales_net_val >= 0.7 * (receipt_total_sales_net_val - receipt_ignore_sales_net_val) 
                THEN CAST(1 AS INT64)
                ELSE CAST(0 AS INT64) 
            END AS cherry_picker_fg,
            CASE
                WHEN receipt_action_sales_net_val >= (receipt_total_sales_net_val - receipt_ignore_sales_net_val)
                 AND receipt_action_piece_weight_qty >= (receipt_total_piece_weight_qty - receipt_ignore_piece_weight_qty) 
                THEN CAST(1 AS INT64)
                ELSE CAST(0 AS INT64) 
            END AS exclusive_buyer_fg
        FROM (
            -- Inner wrapper required for BigQuery to resolve Window aliases used in the CASE statements above
            SELECT
                client_id,
                loc_sid,
                register_id,
                receipt_id,
                receipt_tmsp,
                dwh_cal_dt,
                item_sid,
                SUM(sales_net_val) OVER (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_total_sales_net_val,
                SUM(piece_weight_qty) OVER (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_total_piece_weight_qty,
                SUM(action_fg * sales_net_val) OVER (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_action_sales_net_val,
                SUM(pv_fg * sales_net_val) OVER (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_pv_sales_net_val,
                SUM(ignore_fg * sales_net_val) OVER (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_ignore_sales_net_val,
                SUM(action_fg * piece_weight_qty) OVER (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_action_piece_weight_qty,
                SUM(ignore_fg * piece_weight_qty) OVER (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_ignore_piece_weight_qty
            FROM (
                SELECT
                    rln.client_id,
                    rln.loc_sid,
                    rln.register_id,
                    rln.receipt_id,
                    rln.receipt_tmsp,
                    rln.dwh_cal_dt,
                    CASE WHEN aci.pit_fg = 1 THEN rln.item_sid ELSE NULL END AS item_sid,
                    COALESCE(aci.action_fg, 0) AS action_fg,
                    COALESCE(aci.pv_fg, 0) AS pv_fg,
                    COALESCE(aci.ignore_fg, 0) AS ignore_fg,
                    /* Expression for lew_bil.t_agg_pos_store_item_day.sales_net_val */
                    SUM(COALESCE(rln.sales_val, 0) * 100 / COALESCE(NULLIF(rln.vat_pct_val + 100, 0), 100)) AS sales_net_val,
                    SUM(
                        CASE
                            WHEN rln.weight_item_fg != 1 THEN COALESCE(rln.sales_piece_qty, 0)
                            WHEN rln.weight_item_fg = 1 THEN COALESCE(rln.sales_weight_qty, 0) 
                        END
                    ) AS piece_weight_qty
                FROM (
                    SELECT
                        client_id,
                        loc_sid,
                        register_id,
                        receipt_id,
                        receipt_tmsp,
                        dwh_cal_dt,
                        item_sid,
                        sales_val,
                        vat_pct_val,
                        weight_item_fg,
                        sales_piece_qty,
                        sales_weight_qty
                    FROM `#PSCHEMACOREAC#.v_pos_receiptline_2`
                    WHERE client_id = #PCLIENTID#
                        AND dwh_cal_dt BETWEEN PARSE_DATE('%Y-%m-%d', '#DT_CAL_FROM#') AND PARSE_DATE('%Y-%m-%d', '#DT_CAL_TO#')
                        AND (transaction_type_cd BETWEEN '100' AND '109' OR transaction_type_cd BETWEEN '120' AND '129')
                ) AS rln
                LEFT OUTER JOIN (
                    /* All PIT action items (PV, NF, FA) and EJR action items (NF, FA) independently from advertising week. */
                    SELECT *
                    FROM `#PSCHEMA#.t_pit_str_dt_item_fg_tmp`
                    WHERE client_id = #PCLIENTID#
                        AND cal_dt BETWEEN PARSE_DATE('%Y-%m-%d', '#DT_CAL_FROM#') AND PARSE_DATE('%Y-%m-%d', '#DT_CAL_TO#')
                ) AS aci
                  ON rln.client_id = aci.client_id
                 AND rln.loc_sid = aci.loc_sid_store
                 AND rln.item_sid = aci.item_sid
                 AND rln.dwh_cal_dt = aci.cal_dt
                
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
            ) AS a
            QUALIFY SUM(CASE WHEN item_sid IS NOT NULL THEN 1 ELSE 0 END) OVER (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) > 0
        ) AS b_inner
    ) AS b
    WHERE item_sid IS NOT NULL
) AS rcpt

INNER JOIN (
    SELECT *
    FROM `#PSCHEMA#.t_pit_str_dt_item_hier_tmp`
    WHERE client_id = #PCLIENTID#
        AND cal_dt BETWEEN PARSE_DATE('%Y-%m-%d', '#DT_CAL_FROM#') AND PARSE_DATE('%Y-%m-%d', '#DT_CAL_TO#')
        AND adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
) AS awi
  ON rcpt.client_id = awi.client_id
 AND rcpt.dwh_cal_dt = awi.cal_dt
 AND rcpt.loc_sid = awi.loc_sid_store
 AND rcpt.item_sid = awi.item_sid;

''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PCLIENTID#', CAST(pClientId AS STRING));
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#DT_CAL_FROM#', pCalDtFrom);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#DT_CAL_TO#', pCalDtTo);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PADVWEEKIDFROM#', CAST(pAdvWeekIdFrom AS STRING));
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PADVWEEKIDTO#', CAST(pAdvWeekIdTo AS STRING));
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMACOREAC#', strSchemaCoreAC);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMABILAC#', strSchemaBilAC);
SET sqlStmtCnt  =  '''
SELECT COUNT(*) 
FROM `#PSCHEMA#.t_pit_str_dt_item_rcpt_tmp`
WHERE TRUE
    AND client_id = #PCLIENTID#
    AND cal_dt BETWEEN PARSE_DATE('%Y-%m-%d', '#DT_CAL_FROM#') AND PARSE_DATE('%Y-%m-%d', '#DT_CAL_TO#')
    AND adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
;
'''
;
-- Variable Substitution

SET sqlStmtCnt  =  REGEXP_REPLACE(sqlStmtCnt, '#PSCHEMA#', pSchema);
SET sqlStmtCnt  =  REGEXP_REPLACE(sqlStmtCnt, '#PCLIENTID#', CAST(pClientId AS STRING));
SET sqlStmtCnt  =  REGEXP_REPLACE(sqlStmtCnt, '#DT_CAL_FROM#', pCalDtFrom);
SET sqlStmtCnt  =  REGEXP_REPLACE(sqlStmtCnt, '#DT_CAL_TO#', pCalDtTo);
SET sqlStmtCnt  =  REGEXP_REPLACE(sqlStmtCnt, '#PADVWEEKIDFROM#', CAST(pAdvWeekIdFrom AS STRING));
SET sqlStmtCnt  =  REGEXP_REPLACE(sqlStmtCnt, '#PADVWEEKIDTO#', CAST(pAdvWeekIdTo AS STRING));
-- SET sqlStmtLogStart  =  '''
BEGIN
CALL `p_lew_mart_pit_onprem.sp_startcomponentlogging`(
    UPPER(pApplicationName),
    UPPER(pModuleName),
    '[BF] Extract: t_pit_str_dt_item_rcpt_tmp (' || CAST(pClientId AS STRING) || ',' || pCalDtFrom|| ',' || pCalDtTo|| ',' || CAST(pAdvWeekIdFrom AS STRING)|| ',' || CAST(pAdvWeekIdTo AS STRING) || ',' || strSchemaCoreAC || ',' || strSchemaBilAC || ')' ,
    strRunCluster,
    p_lew_mart_pit_onprem.querytag(UPPER(pApplicationName), UPPER(pModuleName), NULL),
    res
);
-- ''';
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PAPPLICATIONNAME#', UPPER(pApplicationName));
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PMODULENAME#', UPPER(pModuleName));
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#RUNCLUSTER#', strRunCluster);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PSCHEMA#', pSchema);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PCLIENTID#', CAST(pClientId AS STRING));
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#DT_CAL_FROM#', pCalDtFrom);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#DT_CAL_TO#', pCalDtTo);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PADVWEEKIDFROM#', CAST(pAdvWeekIdFrom AS STRING));
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PADVWEEKIDTO#', CAST(pAdvWeekIdTo AS STRING));
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PSCHEMACOREAC#', strSchemaCoreAC);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PSCHEMABILAC#', strSchemaBilAC);
-- Log Start


-- EXECUTE IMMEDIATE sqlStmtLogStart;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNBFEXECTUTIONEXTRACT: [' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
-- Extract Data

BEGIN

EXECUTE IMMEDIATE (sqlStmt) ;

EXECUTE IMMEDIATE (sqlStmtCnt)
INTO resExtract ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNBFEXECTUTIONEXTRACT: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCntExtract  =  resExtract;
SET sqlStmtLogEnd  =  '';
-- SET sqlStmtLogEnd  =  '''
BEGIN

CALL `p_lew_mart_pit_onprem.sp_endcomponentlogging`(
    UPPER(pApplicationName),
    UPPER(pModuleName),
    '[BF] Extract: t_pit_str_dt_item_rcpt_tmp (' || CAST(pClientId AS STRING) || ',' || pCalDtFrom|| ',' || pCalDtTo|| ',' || CAST(pAdvWeekIdFrom AS STRING)|| ',' || CAST(pAdvWeekIdTo AS STRING) || ',' || strSchemaCoreAC || ',' || strSchemaBilAC || ')' ,
    strRunCluster,
    _rowCntExtract,
    res
);
-- ''';
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PAPPLICATIONNAME#', UPPER(pApplicationName));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PMODULENAME#', UPPER(pModuleName));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#RUNCLUSTER#', strRunCluster);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PSCHEMA#', UPPER(pSchema));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PCLIENTID#', CAST(pClientId AS STRING));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#DT_CAL_FROM#', pCalDtFrom);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#DT_CAL_TO#', pCalDtTo);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PADVWEEKIDFROM#', CAST(pAdvWeekIdFrom AS STRING));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PADVWEEKIDTO#', CAST(pAdvWeekIdTo AS STRING));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#ROWCOUNT#', CAST(_rowCntExtract AS STRING));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PSCHEMACOREAC#', UPPER(strSchemaCoreAC));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PSCHEMABILAC#', UPPER(strSchemaBilAC));
-- Log End

EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNBFEXECTUTIONEXTRACT: [' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
-- Loop all results

SET _rowCnt  =  COALESCE(CAST(ARRAY_LENGTH(res) AS BIGNUMERIC), 0);
SET out_param  =  '' || CAST(_rowCnt AS STRING);
SELECT out_param;
RETURN;
END;




