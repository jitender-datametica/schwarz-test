CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunBFExecutionExtract (
      pClientId				DOUBLE
	, pSchema      			STRING 
	, pCalDtFrom 			STRING
	, pCalDtTo 				STRING 		
	, pAdvWeekIdFrom    	DOUBLE  
	, pAdvWeekIdTo			DOUBLE
	, pApplicationName 		STRING 
	, pModuleName 			STRING 		
	, pRunClusteringDesc    STRING 
	, pSchemaCoreAC 		STRING
	, pSchemaBilAC 			STRING		
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  EXECUTE AS CALLER
  AS
  $$
	
	
// ---------------------------------------------------------------------
// PROCEDURE	:	sp_RunBFExecutionWrapper(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pMaxRuns DOUBLE)
// Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
// 				pSchema 				STRING
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
//     			pMaxRuns				DOUBLE
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
//                 Logging is also enables  but must be enabled! 
// Example		:	CALL P_LEW_MART_PIT_ONPREM.sp_RunBFExecutionExtract (4,'P_LEW_MART_PIT_ONPREM', '2021-07-30','2021-09-01',202130,202135);
// ------------------------------------------------------------------------	
// 
// # History:
// #  1.0  2021-07-01 Andreas Kurz    	Initial version
// #  1.3  2021-11-08 Andreas Kurz		Added additional logging

   
   var _rowCnt = 0, _rowCntExtract = 0,  msg = "", strRunCluster = "[0]", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmtCheck = "", sqlStmtCnt = "", sqlStmt = "";
   		var strSchemaCoreAC = "P_LEW_CORE_AC", strSchemaBilAC = "P_LEW_BIL_AC";

		if ((PCLIENTID == "") || (PCLIENTID == null) || (Number.isNaN(PCLIENTID) == true)) { 
			msg = "Missing parameter Client ID or not a number: Mandatory Parameter)";
				
			throw new Error(msg);
			return msg ;  
		} 		
		
		if ((PADVWEEKIDFROM == "") || (PADVWEEKIDFROM == null) || (Number.isNaN(PADVWEEKIDFROM) == true)) { 
			msg = "Missing Parameter Adv-Week ID From or not a number";
				
			throw new Error(msg);
			return msg ;  
		} 	

		if ((PADVWEEKIDTO == "") || (PADVWEEKIDTO == null) || (Number.isNaN(PADVWEEKIDTO) == true)) { 
			msg = "Missing Parameter Adv-Week ID To or not a number";
				
			throw new Error(msg);
			return msg ;  
		} 
		
		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}		
		
		// CHECK INPUT pSchemaCoreAC 
		if ((PSCHEMACOREAC === "") || (typeof(PSCHEMACOREAC) === "undefined") || (PSCHEMACOREAC.length === 0) || (PSCHEMACOREAC === null)) { 
			PSCHEMACOREAC = strSchemaCoreAC; 
		} else {
			strSchemaCoreAC = PSCHEMACOREAC.toUpperCase();
		}			

		// CHECK INPUT pSchemaBilAC 
		if ((PSCHEMABILAC === "") || (typeof(PSCHEMABILAC) === "undefined") || (PSCHEMABILAC.length === 0) || (PSCHEMABILAC === null)) { 
			PSCHEMABILAC = strSchemaBilAC; 
		} else {
			strSchemaBilAC = PSCHEMABILAC.toUpperCase();
		}			

		sqlStmt = `
			INSERT INTO #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp (
				client_id
				, loc_sid_store
				, cal_dt
				, register_id
				, receipt_id
				, receipt_tmsp
				, receipt_total_sales_net_val
				, receipt_action_sales_net_val
				, receipt_pv_sales_net_val
				, heavy_buyer_fg
				, cherry_picker_fg
				, exclusive_buyer_fg
				, item_sid
				, adv_week_id
				, adv_period_id
				, adv_week_period_start_dt
				, adv_week_period_end_dt
				, orig_item_nr
				, action_type_id
				, adv_theme_sid
				, sub_item_grp_sid
				, item_grp_int_sid
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
				CASE WHEN awi.action_type_id = 1 
					THEN rcpt.cherry_picker_fg
					ELSE 0::SMALLINT 
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
			FROM
			(
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
				FROM
				(
					SELECT
						client_id,
						loc_sid,
						register_id,
						receipt_id,
						receipt_tmsp,
						dwh_cal_dt,
						item_sid,
						Sum(sales_net_val)             		Over (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_total_sales_net_val,
						Sum (piece_weight_qty )        		Over (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_total_piece_weight_qty,
						Sum(action_fg * sales_net_val) 		Over (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_action_sales_net_val,
						Sum(pv_fg     * sales_net_val) 		Over (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_pv_sales_net_val,
						Sum(ignore_fg * sales_net_val) 		Over (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_ignore_sales_net_val,
						Sum(action_fg * piece_weight_qty) 	Over (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_action_piece_weight_qty,
						Sum(ignore_fg * piece_weight_qty) 	Over (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) AS receipt_ignore_piece_weight_qty,
						CASE
						WHEN      receipt_action_sales_net_val    >= 0.7 * (receipt_total_sales_net_val    - receipt_ignore_sales_net_val)
							AND receipt_action_piece_weight_qty >= 0.7 * (receipt_total_piece_weight_qty - receipt_ignore_piece_weight_qty) 
						THEN 1::SMALLINT
						ELSE 0::SMALLINT 
						END AS heavy_buyer_fg,
						CASE
						WHEN receipt_pv_sales_net_val     >= 0.7 * (receipt_total_sales_net_val-receipt_ignore_sales_net_val) THEN 1::SMALLINT
						ELSE 0::SMALLINT END AS cherry_picker_fg,
						CASE
						WHEN    receipt_action_sales_net_val     >= (receipt_total_sales_net_val-receipt_ignore_sales_net_val)
						AND receipt_action_piece_weight_qty >= (receipt_total_piece_weight_qty-receipt_ignore_piece_weight_qty) THEN 1::SMALLINT
						ELSE 0::SMALLINT END AS exclusive_buyer_fg
					FROM
					(
						SELECT
						rln.client_id,
						rln.loc_sid,
						rln.register_id,
						rln.receipt_id,
						rln.receipt_tmsp,
						rln.dwh_cal_dt,
						CASE
						WHEN aci.pit_fg = 1 THEN rln.item_sid
						ELSE NULL END AS item_sid,
						Coalesce(aci.action_fg, 0) AS action_fg,
						Coalesce(aci.pv_fg    , 0) AS pv_fg,
						Coalesce(aci.ignore_fg, 0) AS ignore_fg,
						/* Expression for lew_bil.t_agg_pos_store_item_day.sales_net_val */
						Sum(ZeroIfNull(rln.sales_val) * 100::INTEGER / Coalesce(CASE
						WHEN rln.vat_pct_val +100::INTEGER = 0 THEN null
						ELSE rln.vat_pct_val +100::INTEGER END,100::INTEGER)) AS sales_net_val,
						Sum(CASE
						WHEN rln.weight_item_fg <> 1 THEN ZeroIfNull ( rln.sales_piece_qty )
						WHEN rln.weight_item_fg  = 1 THEN ZeroIfNull ( rln.sales_weight_qty ) END) AS piece_weight_qty
						FROM
						(
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
						FROM #PSCHEMACOREAC#.v_pos_receiptline_1
						WHERE client_id = #PCLIENTID#
							AND dwh_cal_dt BETWEEN to_date('#DT_CAL_FROM#','YYYY-MM_1-DD') AND to_date('#DT_CAL_TO#','YYYY-MM_1-DD')
							AND (transaction_type_cd BETWEEN '100' AND '109' OR transaction_type_cd BETWEEN '120' AND '129')
						) AS rln
			
						LEFT OUTER JOIN
						(
						/* All PIT action items (PV, NF, FA) and EJR action items (NF, FA) independently from advertising week. */
						SELECT
							*
						FROM #PSCHEMA#.t_pit_str_dt_item_fg_tmp
						WHERE client_id = #PCLIENTID#
							AND cal_dt BETWEEN to_date('#DT_CAL_FROM#','YYYY-MM_1-DD') AND to_date('#DT_CAL_TO#','YYYY-MM_1-DD')
						) AS aci
						ON rln.client_id     = aci.client_id
						AND rln.loc_sid       = aci.loc_sid_store
						AND rln.item_sid      = aci.item_sid
						AND rln.dwh_cal_dt    = aci.cal_dt
						
						GROUP BY 1,2,3,4,5,6,7,8,9,10
			
					) AS a
					QUALIFY Sum(CASE
						WHEN item_sid IS NOT NULL THEN 1
						ELSE 0 END) Over (PARTITION BY client_id, loc_sid, register_id, receipt_id, receipt_tmsp, dwh_cal_dt) > 0
			
				) AS b
				WHERE item_sid IS NOT NULL
			
			) AS rcpt
			
			INNER JOIN
			(
				SELECT
					*
				FROM #PSCHEMA#.t_pit_str_dt_item_hier_tmp
				WHERE client_id = #PCLIENTID#
					AND cal_dt BETWEEN to_date('#DT_CAL_FROM#','YYYY-MM_1-DD') AND to_date('#DT_CAL_TO#','YYYY-MM_1-DD')
					AND adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
			) AS awi
			ON  rcpt.client_id  = awi.client_id
				AND rcpt.dwh_cal_dt = awi.cal_dt
				AND rcpt.loc_sid    = awi.loc_sid_store
				AND rcpt.item_sid   = awi.item_sid
				;
			`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,PCALDTFROM);
		sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,PCALDTTO);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		sqlStmt = sqlStmt.replace(/#PSCHEMACOREAC#/g,strSchemaCoreAC.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PSCHEMABILAC#/g,strSchemaBilAC.toUpperCase());		

		sqlStmtCnt = `	
			SELECT COUNT(*) FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
			WHERE TRUE
				AND client_id = #PCLIENTID#
				AND cal_dt  BETWEEN to_date('#DT_CAL_FROM#','YYYY-MM_1-DD') AND to_date('#DT_CAL_TO#','YYYY-MM_1-DD')
				AND adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
				;
			`;

		// Variable Substitution
		sqlStmtCnt = sqlStmtCnt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmtCnt = sqlStmtCnt.replace(/#PCLIENTID#/g,PCLIENTID);
		sqlStmtCnt = sqlStmtCnt.replace(/#DT_CAL_FROM#/g,PCALDTFROM);
		sqlStmtCnt = sqlStmtCnt.replace(/#DT_CAL_TO#/g,PCALDTTO);		
		sqlStmtCnt = sqlStmtCnt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmtCnt = sqlStmtCnt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());	
		
		sqlStmtLogStart = `
			CALL #PSCHEMA#.sp_StartComponentLogging(
				 '#PAPPLICATIONNAME#'
				,'#PMODULENAME#'
				,'[BF] Extract: t_pit_str_dt_item_rcpt_tmp ( #PCLIENTID#, #DT_CAL_FROM#, #DT_CAL_TO#, #PADVWEEKIDFROM#, #PADVWEEKIDTO#, #PSCHEMACOREAC#, #PSCHEMABILAC#)'
				,'#RUNCLUSTER#'
				,QueryTag('#PAPPLICATIONNAME#','#PMODULENAME#',NULL)
				);
		`;
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PMODULENAME#/g,PMODULENAME.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#RUNCLUSTER#/g,strRunCluster);		
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PCLIENTID#/g,PCLIENTID);
		sqlStmtLogStart = sqlStmtLogStart.replace(/#DT_CAL_FROM#/g,PCALDTFROM);
		sqlStmtLogStart = sqlStmtLogStart.replace(/#DT_CAL_TO#/g,PCALDTTO);		
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());	
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PSCHEMACOREAC#/g,strSchemaCoreAC.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PSCHEMABILAC#/g,strSchemaBilAC.toUpperCase());			
		
        // Log Start
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECTUTIONEXTRACT: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }

        // Extract Data
        try{
            
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
            var resExtract = snowflake.createStatement( { sqlText: sqlStmtCnt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECTUTIONEXTRACT: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        resExtract.next()
		var _rowCntExtract = resExtract.getColumnValue(1);
		
		sqlStmtLogEnd = "";
		sqlStmtLogEnd = `		
			CALL #PSCHEMA#.sp_EndComponentLogging(
				 '#PAPPLICATIONNAME#'
				,'#PMODULENAME#'
				,'[BF] Extract: t_pit_str_dt_item_rcpt_tmp ( #PCLIENTID#, #DT_CAL_FROM#, #DT_CAL_TO#, #PADVWEEKIDFROM#, #PADVWEEKIDTO#, #PSCHEMACOREAC#, #PSCHEMABILAC#)'
				,'#RUNCLUSTER#'
				,'#ROWCOUNT#'
				);
		`;
	
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PMODULENAME#/g,PMODULENAME.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#RUNCLUSTER#/g,strRunCluster);		
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PCLIENTID#/g,PCLIENTID);
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#DT_CAL_FROM#/g,PCALDTFROM);
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#DT_CAL_TO#/g,PCALDTTO);		
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#ROWCOUNT#/g,_rowCntExtract.toString());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PSCHEMACOREAC#/g,strSchemaCoreAC.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PSCHEMABILAC#/g,strSchemaBilAC.toUpperCase());			
		
		
        // Log End
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECTUTIONEXTRACT: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		
		// Loop all results
		var _rowCnt = res.getRowCount();
	

		return "" + _rowCnt;			
$$
;