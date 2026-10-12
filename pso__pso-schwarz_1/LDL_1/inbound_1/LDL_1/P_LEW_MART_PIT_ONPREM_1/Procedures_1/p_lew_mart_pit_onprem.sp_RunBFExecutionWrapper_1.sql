CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunBFExecutionWrapper (
      pClientId				DOUBLE
	, pSchema      			STRING	
	, pApplicationName 		STRING 
	, pModuleName 			STRING 		
	, pRunClusteringDesc    STRING  
	, pMaxRuns				DOUBLE
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
// PROCEDURE	:	sp_RunBFExecutionWrapper(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pMaxRuns DOUBLE, pSchemaCoreAC STRING, pSchemaBilAC STRING)
// Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
// 				pSchema 				STRING
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
//     			pMaxRuns				DOUBLE
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Performance, there is a max Runs (:= 600) to prevent endless loops
// 				57 Weeks (12 weeks * 26 Pit Countries := 116) 
//                 Logging is also enables  but must be enabled! 
// Example		:	Call sp_RunBFExecutionWrapper('P_LEW_MART_PIT_ONPREM');
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version
// 

		var _rowCnt = 0, iCnt = 0, iMaxRuns = 600, strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmt = "", sqlStmtExtract = "", sqlStmtUpd = "";
		var strSchemaCoreAC = "P_LEW_CORE_AC", strSchemaBilAC = "P_LEW_BIL_AC";
		
		if ((PMAXRUNS == "") || (PMAXRUNS == null) || (Number.isNaN(PMAXRUNS) == true)) { 
			PMAXRUNS = iMaxRuns; 
		} else {
			iMaxRuns = PMAXRUNS;
		}
		
		if ((PCLIENTID == "") || (PCLIENTID == null) || (Number.isNaN(PCLIENTID) == true)) { 
			msg = "Missing Client ID or not a number";
				
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
				SELECT 
					fin.client_id
					, fin.ExecSeqNum
					, fin.Max_ExecSeqNum
					, fin.start_adv_week_reagg  --4 
					, fin.end_adv_week_reagg   --5
					, to_char(fin.cal_dt_from,'YYYY-MM_1-DD') AS cal_dt_from  --6
					, to_char(fin.cal_dt_to,'YYYY-MM_1-DD') 	AS cal_dt_to  --7
					, fin.adv_week_id_from  --8
					, fin.adv_week_id_to  --9
					, 'Exec Call: Client [' 
						|| fin.client_id 
						|| '] Step:' 
						|| to_char(fin.ExecSeqNum) 
						|| '/' || to_char(fin.Max_ExecSeqNum) 
						|| ' EJR Date From:<' 
						|| to_char(fin.cal_dt_from,'YYYY-MM_1-DD')  
						|| '>-<' 
						|| to_char(fin.cal_dt_to,'YYYY-MM_1-DD') 
						|| '>'
						|| ' Adv-Week From:<' 
						|| to_char(fin.adv_week_id_from)  
						|| '>-<' 
						|| to_char(fin.adv_week_id_to) 
						|| '>' 
						|| ' on Schema CORE_AC: #PSCHEMACOREAC# and BIL_AC: #PSCHEMABILAC#'
						AS  Log_display_descr
				 FROM ( 


					SELECT
						client_id
						, FLOOR(qry_seq1_num)+1::INTEGER ExecSeqNum
						, Max(ExecSeqNum) OVER (PARTITION BY CLIENT_ID) AS Max_ExecSeqNum       
						, Min(start_adv_week_reagg)   AS start_adv_week_reagg
						, Max(end_adv_week_reagg)     AS end_adv_week_reagg
						, Min(cal_dt)                 AS cal_dt_from
						, Max(cal_dt)                 AS cal_dt_to
						, Min(last_dt_of_adv_week_id) AS adv_week_id_from
						, Max(last_dt_of_adv_week_id) AS adv_week_id_to
					FROM
						(
						SELECT
							  client_id
							, cal_dt
							, start_adv_week_reagg
							, end_adv_week_reagg
							, last_dt_of_adv_week_id
							, Count(*) Over (PARTITION BY client_id) AS num_days
							, ((FLOOR(num_days / (nbr_of_adv_weeks_EJR*7::INTEGER)) + 1::INTEGER) * Row_Number() Over (PARTITION BY client_id ORDER BY cal_dt) - 1::INTEGER) / (num_days + 1)
									AS qry_seq1_num                
					
						FROM
							(
							SELECT
								  awk.client_id
								, cal.cal_dt
								, Min(pa.start_adv_week_reagg) AS start_adv_week_reagg
								, Max(pa.end_adv_week_reagg)   AS end_adv_week_reagg
								, MAX(pa.nbr_of_adv_weeks_EJR) AS nbr_of_adv_weeks_EJR                    
								, Max(CASE WHEN cal.cal_dt = awk.adv_week_end_dt + pa.end_dt_base_metric_nf_fa THEN awk.adv_week_id END) AS last_dt_of_adv_week_id
							FROM (
										SELECT client_id, adv_week_id, adv_week_start_dt, adv_week_end_dt, DWH_UPDATED 
										FROM  #PSCHEMA#.t_advert_week_1
										WHERE TRUE AND (  #PCLIENTID#  = -1 OR CLIENT_ID =  #PCLIENTID#  )
										GROUP BY 1,2,3,4,5 
										
										QUALIFY ROW_NUMBER() OVER(PARTITION BY CLIENT_ID, ADV_WEEK_ID ORDER BY DWH_UPDATED DESC) = 1
									) AS awk
							
							INNER JOIN #PSCHEMA#.t_pit_scope_country_param_normalized_1 AS pa
									ON  awk.client_id = pa.client_id
								AND awk.adv_week_id BETWEEN pa.start_adv_week_reagg AND pa.end_adv_week_reagg
							
							INNER JOIN #PSCHEMACOREAC#.v_cal_calendarday_1 AS cal
									ON  cal.cal_dt BETWEEN awk.adv_week_start_dt + pa.start_dt_base_metric_nf_fa
													AND awk.adv_week_end_dt   + pa.end_dt_base_metric_nf_fa
							GROUP BY 1,2
							) AS a
						WHERE TRUE AND (  #PCLIENTID#  = -1 OR a.CLIENT_ID =  #PCLIENTID#  ) ORDER BY a.cal_dt 
						) AS b
						GROUP BY 1, 2
						ORDER BY 1,2 
					)fin
				;  		
				 `;
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
		sqlStmt = sqlStmt.replace(/#PSCHEMACOREAC#/g,strSchemaCoreAC.toUpperCase());		
		sqlStmt = sqlStmt.replace(/#PSCHEMABILAC#/g,strSchemaBilAC.toUpperCase());	


        // Retrieve from all uses tables
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNBFEXECTUTIONWRAPPER: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		var _rowCnt = res.getRowCount();
	
		while (res.next() && iCnt < iMaxRuns) {
		       	   
        
			sqlStmtExtract = "";
			sqlStmtExtract = "CALL " + PSCHEMA + ".sp_RunBFExecutionExtract (" + res.getColumnValue(1) + ",'" + PSCHEMA + "','" +  res.getColumnValue(6) + "','" + res.getColumnValue(7) + "'," + res.getColumnValue(4) + "," + res.getColumnValue(5) 
			+ ",'"  + PAPPLICATIONNAME.toUpperCase() 
			+ "','" + PMODULENAME.toUpperCase() 
			+ "','" + strRunCluster 
			+ "','" + strSchemaCoreAC.toUpperCase() 	
			+ "','" + strSchemaBilAC.toUpperCase() 	
			+ "')";
						
			sqlStmtUpd = "";
			sqlStmtUpd = "CALL " + PSCHEMA + ".sp_RunBFExecutionUpdate (" 
			+ res.getColumnValue(1) + ",'" + PSCHEMA + "'," + res.getColumnValue(8) + "," + res.getColumnValue(9) 
			+ ")";
			
			sqlStmtLogStart = "";
			sqlStmtLogStart = "CALL " + PSCHEMA + ".sp_StartComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','" + res.getColumnValue(10) + "', '" + strRunCluster + "',QueryTag('" + PAPPLICATIONNAME + "','" + PMODULENAME + "',NULL));";

		    sqlStmtLogEnd = ""; 
		    sqlStmtLogEnd ="CALL " + PSCHEMA + ".sp_EndComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','"  + res.getColumnValue(10) + "', '"+ strRunCluster + "', to_char(1));";
	
		   
		   try{
				snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
			} catch (ERROR){
			
				msg = "P_RUNBFEXECTUTIONWRAPPER_LogStart: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}

		    try{
				snowflake.createStatement( { sqlText: sqlStmtExtract } ).execute();
			} catch (ERROR){
			
				msg = "P_RUNSEARCHOPTIMIZATION_Extract: [" + sqlStmtExtract + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}

	    	try{
				snowflake.createStatement( { sqlText: sqlStmtUpd } ).execute();
			} catch (ERROR){
			
				msg = "P_RUNSEARCHOPTIMIZATION_Extract: [" + sqlStmtUpd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}
			
		    try{
				snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
			} catch (ERROR){
			
				msg = "P_RUNBFEXECTUTIONWRAPPER_LogEnd: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}
			
			iCnt += 1;
			
		} // while result set

		return "" + _rowCnt;			
$$
;