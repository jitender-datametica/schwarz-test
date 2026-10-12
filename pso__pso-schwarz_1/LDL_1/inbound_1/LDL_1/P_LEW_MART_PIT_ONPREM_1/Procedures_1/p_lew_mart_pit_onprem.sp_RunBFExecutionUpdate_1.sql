CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunBFExecutionUpdate (
      pClientId				DOUBLE
	, pSchema      			STRING 
	, pAdvWeekIdFrom    	DOUBLE  
	, pAdvWeekIdTo			DOUBLE
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  EXECUTE AS CALLER
  AS
  $$

// ---------------------------------------------------------------------
// PROCEDURE	:	sp_RunBFExecutionUpdate(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pMaxRuns DOUBLE)
// Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
// 				pSchema 				STRING
// 				pAdvWeekIdFrom    		DOUBLE --> Mandatory Format YYYYWW
// 				pAdvWeekIdTo			DOUBLE --> Mandatory Format YYYYWW
// Return		:	Error + Error Msg or in success case number of overall processed records
// Convert		:	None    
// Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
//                 Logging is also enables  but must be enabled! 
// Example		:	CALL P_LEW_MART_PIT_ONPREM.sp_RunBFExecutionUpdate (4,'P_LEW_MART_PIT_ONPREM', 202130,202135);
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version




		var _rowCnt = 0, msg = "", sqlStmt = "";
               
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
				
		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_item_period_1
			/* Update 1 / 13 ==> t_advert_week_item_period_1 */
			SET
				receipts_cnt                          = src.receipts_cnt
				, heavy_buy_receipts_cnt                = src.heavy_buy_receipts_cnt
				, cherry_pick_receipts_cnt              = CASE
					WHEN #PSCHEMA#.t_advert_week_item_period.action_type_id = 1 THEN src.cherry_pick_receipts_cnt
					ELSE NULL END
				, exclusive_buy_receipts_cnt            = src.exclusive_buy_receipts_cnt
				, receipt_total_sales_net_val           = src.receipt_total_sales_net_val
				, receipt_action_sales_net_val          = src.receipt_action_sales_net_val 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					adv_period_id,
					adv_week_period_start_dt,
					adv_week_period_end_dt,
					item_sid,
					Count(*) AS receipts_cnt,
					Sum(CASE
					WHEN heavy_buyer_fg     = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS heavy_buy_receipts_cnt,
					Sum(CASE
					WHEN cherry_picker_fg   = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS cherry_pick_receipts_cnt,
					Sum(CASE
					WHEN exclusive_buyer_fg = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS exclusive_buy_receipts_cnt,
					Sum( receipt_total_sales_net_val )   AS receipt_total_sales_net_val,
					Sum( receipt_action_sales_net_val )  AS receipt_action_sales_net_val
				FROM
				(
					SELECT
						client_id,
						loc_sid_store,
						cal_dt,
						register_id,
						receipt_id,
						receipt_tmsp,
						adv_week_id,
						adv_period_id,
						adv_week_period_start_dt,
						adv_week_period_end_dt,
						item_sid,
						Max(heavy_buyer_fg)                AS heavy_buyer_fg,
						Max(cherry_picker_fg)              AS cherry_picker_fg,
						Max(exclusive_buyer_fg)            AS exclusive_buyer_fg,
						Max(receipt_total_sales_net_val)   AS receipt_total_sales_net_val,
						Max(receipt_action_sales_net_val)  AS receipt_action_sales_net_val
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
			
					WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
			
					GROUP BY 1,2,3,4,5,6,7,8,9,10,11
				) AS x
				GROUP BY 1,2,3,4,5,6
			) AS src
			WHERE #PSCHEMA#.t_advert_week_item_period.client_id                = src.client_id
				AND #PSCHEMA#.t_advert_week_item_period.adv_week_id              = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_item_period.adv_period_id            = src.adv_period_id
				AND #PSCHEMA#.t_advert_week_item_period.adv_week_period_start_dt = src.adv_week_period_start_dt
				AND #PSCHEMA#.t_advert_week_item_period.adv_week_period_end_dt   = src.adv_week_period_end_dt
				AND #PSCHEMA#.t_advert_week_item_period.item_sid                 = src.item_sid
				AND #PSCHEMA#.t_advert_week_item_period.client_id                = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_item_period.adv_week_id        BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 1
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();
	
		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_period_action_type_1
			/* Update 2 / 13 ==> t_advert_week_period_action_type_1 */
			SET
				receipts_cnt                          = src.receipts_cnt
				, heavy_buy_receipts_cnt                = src.heavy_buy_receipts_cnt
				, cherry_pick_receipts_cnt              = CASE
				WHEN #PSCHEMA#.t_advert_week_period_action_type.action_type_id = 1 THEN src.cherry_pick_receipts_cnt
				ELSE NULL END
				, exclusive_buy_receipts_cnt            = src.exclusive_buy_receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					adv_period_id,
					action_type_id,
					Count(*) AS receipts_cnt,
					Sum(CASE
					WHEN heavy_buyer_fg     = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS heavy_buy_receipts_cnt,
					Sum(CASE
					WHEN cherry_picker_fg   = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS cherry_pick_receipts_cnt,
					Sum(CASE
					WHEN exclusive_buyer_fg = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS exclusive_buy_receipts_cnt
				FROM
				(
					SELECT
						client_id,
						loc_sid_store,
						cal_dt,
						register_id,
						receipt_id,
						receipt_tmsp,
						adv_week_id,
						adv_period_id,
						action_type_id,
						Max(heavy_buyer_fg) AS heavy_buyer_fg,
						Max(cherry_picker_fg) AS cherry_picker_fg,
						Max(exclusive_buyer_fg) AS exclusive_buyer_fg
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
			
					WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
			
					GROUP BY 1,2,3,4,5,6,7,8,9
				) AS x
				GROUP BY 1,2,3,4
			) AS src
			WHERE #PSCHEMA#.t_advert_week_period_action_type.client_id          = src.client_id
				AND #PSCHEMA#.t_advert_week_period_action_type.adv_week_id        = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_period_action_type.adv_period_id      = src.adv_period_id
				AND #PSCHEMA#.t_advert_week_period_action_type.action_type_id     = src.action_type_id
				AND #PSCHEMA#.t_advert_week_period_action_type.client_id          = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_period_action_type.adv_week_id  BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#		
			`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 2
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_action_type_1
			/* Update 3 / 13 ==> t_advert_week_action_type_1 */
			SET
				receipts_cnt                          = src.receipts_cnt
				, heavy_buy_receipts_cnt                = src.heavy_buy_receipts_cnt
				, cherry_pick_receipts_cnt              = CASE
					WHEN #PSCHEMA#.t_advert_week_action_type.action_type_id = 1 THEN src.cherry_pick_receipts_cnt
					ELSE NULL END
				, exclusive_buy_receipts_cnt            = src.exclusive_buy_receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					action_type_id,
					Count(*) AS receipts_cnt,
					Sum(CASE
					WHEN heavy_buyer_fg     = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS heavy_buy_receipts_cnt,
					Sum(CASE
					WHEN cherry_picker_fg   = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS cherry_pick_receipts_cnt,
					Sum(CASE
					WHEN exclusive_buyer_fg = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS exclusive_buy_receipts_cnt
				FROM
				(
					SELECT
						client_id,
						loc_sid_store,
						cal_dt,
						register_id,
						receipt_id,
						receipt_tmsp,
						adv_week_id,
						action_type_id,
						Max(heavy_buyer_fg) AS heavy_buyer_fg,
						Max(cherry_picker_fg) AS cherry_picker_fg,
						Max(exclusive_buyer_fg) AS exclusive_buyer_fg
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
		
					WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		
					GROUP BY 1,2,3,4,5,6,7,8
				) AS x
				GROUP BY 1,2,3
			) AS src
			WHERE #PSCHEMA#.t_advert_week_action_type.client_id         = src.client_id
				AND #PSCHEMA#.t_advert_week_action_type.adv_week_id       = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_action_type.action_type_id    = src.action_type_id
				AND #PSCHEMA#.t_advert_week_action_type.client_id         = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_action_type.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 3
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();
		
		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_total_1
			/* Update 4 / 13 ==> t_advert_week_total_1 */
			SET
				receipts_cnt                            = src.receipts_cnt
				, heavy_buy_receipts_cnt                = src.heavy_buy_receipts_cnt
				, cherry_pick_receipts_cnt              = src.cherry_pick_receipts_cnt
				, exclusive_buy_receipts_cnt            = src.exclusive_buy_receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					Count(*) AS receipts_cnt,
					Sum(CASE
					WHEN heavy_buyer_fg     = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS heavy_buy_receipts_cnt,
					Sum(CASE
					WHEN cherry_picker_fg   = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS cherry_pick_receipts_cnt,
					Sum(CASE
					WHEN exclusive_buyer_fg = 1 THEN 1::SMALLINT
					ELSE 0::SMALLINT END) AS exclusive_buy_receipts_cnt
				FROM
				(
					SELECT
						client_id,
						loc_sid_store,
						cal_dt,
						register_id,
						receipt_id,
						receipt_tmsp,
						adv_week_id,
						Max(heavy_buyer_fg) AS heavy_buyer_fg,
						Max(cherry_picker_fg) AS cherry_picker_fg,
						Max(exclusive_buyer_fg) AS exclusive_buyer_fg
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
			
					WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
			
					GROUP BY 1,2,3,4,5,6,7
				) AS x
				GROUP BY 1,2
			) AS src
			WHERE #PSCHEMA#.t_advert_week_total.client_id         = src.client_id
				AND #PSCHEMA#.t_advert_week_total.adv_week_id       = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_total.client_id         = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_total.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 4
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_subitemgroup_1
			/* Update 5 / 13 ==> t_advert_week_subitemgroup_1 */
			SET
				receipts_cnt                          = src.receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					sub_item_grp_sid,
					Count(*) AS receipts_cnt
				FROM
				(
					SELECT
						client_id,
						loc_sid_store,
						cal_dt,
						register_id,
						receipt_id,
						receipt_tmsp,
						adv_week_id,
						sub_item_grp_sid
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
			
					WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
			
					GROUP BY 1,2,3,4,5,6,7,8
				) AS x
				GROUP BY 1,2,3
			) AS src
			WHERE #PSCHEMA#.t_advert_week_subitemgroup.client_id         = src.client_id
				AND #PSCHEMA#.t_advert_week_subitemgroup.adv_week_id       = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_subitemgroup.sub_item_grp_sid  = src.sub_item_grp_sid
				AND #PSCHEMA#.t_advert_week_subitemgroup.client_id         = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_subitemgroup.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 5
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_itemgroup_int_1
			/* Update 6 / 13 ==> t_advert_week_itemgroup_int_1 */
			SET
				receipts_cnt                          = src.receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					item_grp_int_sid,
					Count(*) AS receipts_cnt
				FROM
				(
					SELECT
						client_id,
						loc_sid_store,
						cal_dt,
						register_id,
						receipt_id,
						receipt_tmsp,
						adv_week_id,
						item_grp_int_sid
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
			
					WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
			
					GROUP BY 1,2,3,4,5,6,7,8
				) AS x
				GROUP BY 1,2,3
			) AS src
			WHERE #PSCHEMA#.t_advert_week_itemgroup_int.client_id         = src.client_id
				AND #PSCHEMA#.t_advert_week_itemgroup_int.adv_week_id       = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_itemgroup_int.item_grp_int_sid  = src.item_grp_int_sid
				AND #PSCHEMA#.t_advert_week_itemgroup_int.client_id         = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_itemgroup_int.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 6
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_theme_1
			/* Update 7 / 13 ==> t_advert_week_theme_1 */
			SET
				receipts_cnt                          = src.receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					adv_theme_sid,
					Count(*) AS receipts_cnt
				FROM
				(
					SELECT
						client_id,
						loc_sid_store,
						cal_dt,
						register_id,
						receipt_id,
						receipt_tmsp,
						adv_week_id,
						adv_theme_sid
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
			
					WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
						/* AND   adv_theme_sid IS NOT NULL */ /* removed to update receipts_cnt for undefined theme */
					GROUP BY 1,2,3,4,5,6,7,8
				) AS x
				GROUP BY 1,2,3
			) AS src
			WHERE #PSCHEMA#.t_advert_week_theme.client_id         = src.client_id
				AND #PSCHEMA#.t_advert_week_theme.adv_week_id       = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_theme.adv_theme_sid     = src.adv_theme_sid
				AND #PSCHEMA#.t_advert_week_theme.client_id         = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_theme.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 7
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_theme_total_1
			/* Update 8 / 13 ==> t_advert_week_theme_total_1 */
			SET
				receipts_cnt                          = src.receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					Count(*) AS receipts_cnt
				FROM
				(
					SELECT
						client_id,
						loc_sid_store,
						cal_dt,
						register_id,
						receipt_id,
						receipt_tmsp,
						adv_week_id
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp
			
					WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
						AND   adv_theme_sid > 0
			
					GROUP BY 1,2,3,4,5,6,7
				) AS x
				GROUP BY 1,2
			) AS src
			WHERE #PSCHEMA#.t_advert_week_theme_total.client_id         = src.client_id
				AND #PSCHEMA#.t_advert_week_theme_total.adv_week_id       = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_theme_total.client_id         = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_theme_total.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 8
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_medium_1
			/* Update 9 / 13 ==> t_advert_week_medium_1 */
			SET
				receipts_cnt                          = src.receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					adv_medium_sid,
					Count(*) AS receipts_cnt
				FROM
				(
					SELECT
						rln.client_id,
						rln.loc_sid_store,
						rln.cal_dt,
						rln.register_id,
						rln.receipt_id,
						rln.receipt_tmsp,
						rln.adv_week_id,
						med.adv_medium_sid
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp AS rln
			
					INNER JOIN #PSCHEMA#.t_advert_week_item_medium_1 AS med
					ON rln.client_id   = med.client_id
						AND rln.adv_week_id = med.adv_week_id
						AND rln.item_sid    = med.item_sid
					
					WHERE rln.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
						AND med.client_id = #PCLIENTID#
						AND med.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
					
					GROUP BY 1,2,3,4,5,6,7,8
				) AS x
				GROUP BY 1,2,3
			) AS src
			WHERE #PSCHEMA#.t_advert_week_medium.client_id         = src.client_id
				AND #PSCHEMA#.t_advert_week_medium.adv_week_id       = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_medium.adv_medium_sid    = src.adv_medium_sid
				AND #PSCHEMA#.t_advert_week_medium.client_id         = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_medium.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 9
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			CREATE OR REPLACE TEMPORARY TABLE t_advert_week_item_med_grp_vtmp
			/* Create TMP Table 10 / 13 ==> t_advert_week_item_med_grp_vtmp */
			(
				client_id             INTEGER    NOT NULL,
				adv_week_id           INTEGER    NOT NULL,
				item_sid              INTEGER    NOT NULL,
				adv_medium_grp_sid    INTEGER    NOT NULL
			)
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 10
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			INSERT INTO t_advert_week_item_med_grp_vtmp (
			/* Insert Into Table 11 / 13 ==> t_advert_week_item_med_grp_vtmp */
				client_id
				, adv_week_id
				, item_sid
				, adv_medium_grp_sid
			)
			/*AR:15-12-2020 Code modified to join on advertising start date between promotion start and end dates*/
			SELECT
				src.client_id,
				src.adv_week_id,
				src.item_sid,
				src.adv_medium_grp_sid
			FROM
			(
				SELECT  DISTINCT
					awi.client_id,
					awi.adv_week_id,
					awi.item_sid,
					awi.orig_item_nr,
					awi.action_type_id,
					awi.adv_week_period_start_dt,
					awi.adv_week_period_end_dt,
					Coalesce( mdg.promotion_end_dt, Cast( NULL AS DATE ) )   AS promotion_end_dt,
					Coalesce( mdg.promotion_start_dt, Cast( NULL AS DATE ) ) AS promotion_start_dt,
					(mdg.promotion_end_dt - mdg.promotion_start_dt) AS apt_number_of_days,
					CASE
					WHEN awi.adv_week_period_start_dt = mdg.promotion_start_dt OR mdg.promotion_start_dt IS NULL 
						THEN 1::SMALLINT
						ELSE 0::SMALLINT 
					END AS apt_fg,
					Coalesce(mdg.advert_medium_group_sid, (-1::INTEGER * awi.client_id )) AS adv_medium_grp_sid
				FROM #PSCHEMA#.t_advert_week_item_period_1 awi
		
				LEFT JOIN #PSCHEMA#.t_pit_apt_medium_client_promotionperiod_item_1 AS mdg
				ON awi.client_id = mdg.client_id
					AND awi.item_sid = mdg.item_sid
					AND awi.adv_week_period_start_dt BETWEEN mdg.promotion_start_dt AND  mdg.promotion_end_dt
		
				INNER JOIN #PSCHEMA#.t_pit_scope_country_param_normalized_1 pa
				ON awi.client_id = pa.client_id
					AND mdg.adv_week_id BETWEEN pa.start_adv_week_reagg AND pa.end_adv_week_reagg
		
				WHERE mdg.medium_deleted_fg = 0
			)    AS src
			QUALIFY Row_Number() Over(
				PARTITION BY  src.client_id
					, src.adv_week_id
					, src.item_sid
					, src.orig_item_nr
					, src.adv_week_period_start_dt
					, src.adv_week_period_end_dt
					, src.adv_medium_grp_sid
			ORDER BY src.apt_fg DESC NULLS LAST, src.apt_number_of_days DESC NULLS LAST, src.promotion_start_dt DESC NULLS LAST) = 1
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 11
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			UPDATE #PSCHEMA#.t_advert_week_medium_grp_1
			/* Update 12 / 13 ==> t_advert_week_medium_grp_1 */
			SET
				receipts_cnt                          = src.receipts_cnt 
			FROM
			(
				SELECT
					client_id,
					adv_week_id,
					adv_medium_grp_sid,
					Count(*) AS receipts_cnt
				FROM
				(
					SELECT
						rln.client_id,
						rln.loc_sid_store,
						rln.cal_dt,
						rln.register_id,
						rln.receipt_id,
						rln.receipt_tmsp,
						rln.adv_week_id,
						mdg.adv_medium_grp_sid
					FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp AS rln
					
					INNER JOIN t_advert_week_item_med_grp_vtmp AS mdg
					ON rln.client_id   = mdg.client_id
						AND rln.adv_week_id = mdg.adv_week_id
						AND rln.item_sid    = mdg.item_sid
					
					WHERE rln.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
						AND mdg.client_id = #PCLIENTID#
						AND mdg.adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
					GROUP BY 1,2,3,4,5,6,7,8
				) AS x
				GROUP BY 1,2,3
			) AS src
			WHERE #PSCHEMA#.t_advert_week_medium_grp.client_id          = src.client_id
				AND #PSCHEMA#.t_advert_week_medium_grp.adv_week_id        = src.adv_week_id
				AND #PSCHEMA#.t_advert_week_medium_grp.adv_medium_grp_sid = src.adv_medium_grp_sid
				AND #PSCHEMA#.t_advert_week_medium_grp.client_id          = #PCLIENTID#
				AND #PSCHEMA#.t_advert_week_medium_grp.adv_week_id  BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 12
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		sqlStmt = ""
		sqlStmt = `
			DELETE FROM #PSCHEMA#.t_pit_str_dt_item_rcpt_tmp 
			/* Delete Tmp Table 13 / 13 ==> t_pit_str_dt_item_rcpt_tmp */
				WHERE adv_week_id BETWEEN #PADVWEEKIDFROM# AND #PADVWEEKIDTO#
			`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_FROM#/g,dt_cal_from);
		//sqlStmt = sqlStmt.replace(/#DT_CAL_TO#/g,dt_cal_to);		
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDFROM#/g,PADVWEEKIDFROM.toString());	
		sqlStmt = sqlStmt.replace(/#PADVWEEKIDTO#/g,PADVWEEKIDTO.toString());			
		

        // Update Stmt 13
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECUTIONUPDATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		_rowCnt += res.getRowCount();

		
		return "" + _rowCnt;			
$$
;