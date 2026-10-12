CREATE OR REPLACE PROCEDURE P_LEW_PROCESS.P_LC_P_LEW_PROCESS_GET_STORED_CTX_LOAD_ID(PROCESS_GRP VARCHAR, CTX_LID FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	// *******************************************************************************************************************************************
	//Holt (bei Vorhandensein) die maximale vom Stager für den Dispatcher freigegebene Context-Load-ID as dem LC-Repository
	//Reserviert ansonsten neue - noch vom Stager gelockte Contexte für die nächstmögliche Freigabe durch den Stager, mit der Bitte um Nicht-Weiterverwendung durch den Stager.
	//process_grp: Dies ist die Prozessgruppe, unter welcher alle Prozesse laufen sollen, die die hier erzeugte context_load-id benutzen sollen.
	//Nur für diese Prozesse stellt sie den Laufkontext dar. Aktuelle Beispiele sind POS (für die Gruppe_1 von Prozessen, welche sich 
	//um die Beladung der E-Journale=PointOfSales kümmern), TXJ (für die Gruppe_1 der Prozesse, welche die TXJ-Schnittstellen verarbeiten)
	//Der Rezipientprozess dieser jeweiligen Gruppe_1 kann durch Aufruf dieser Prozedur - und eben für seine Prozessgruppe - seine Context-Load-id ermitteln
	//ctx_lid: Rückgabewert: CONTEXT_LOAD_ID für den Dispatcher (0 bei keine gefunden)
	//(c) Infomotion GmbH 20190606 Jens Thole
	// ********************************************************************************************************************************************
	{
	   var cnt4setwaiting;
	   var sql_stmt = `    SELECT count(*)
	    FROM p_lew_process.t_lc_prtcl_context_tasks_1
	    WHERE stager_plan_state=''locked''
	      AND context_country_cd<>''-''
	      AND processcontainer= ` + PROCESS_GRP;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   res.next();
	   var cnt4setwaiting = res.getColumnValue(1);
	   if (cnt4setwaiting > 0) {
	      {
	         //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
	         var sql_stmt = `UPDATE p_lew_process.t_lc_prtcl_context_tasks_1 SET loader_plan_state=''waiting'',
	updated_ts=current_timestamp
	WHERE stager_plan_state=''locked''
	  AND context_country_cd<>''-''
	  AND processcontainer= ` + PROCESS_GRP;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	         /*            COMMIT*/
	         
	      }
	   }
	   var sql_stmt = `    SELECT COALESCE(max(context_load_id),0)
	    FROM (SELECT context_load_id
	          FROM p_lew_process.t_lc_prtcl_context_tasks_1
	          WHERE success_state in (''raw'', ''reload'')
	            AND stager_plan_state=''free''
	            AND processcontainer= ` + PROCESS_GRP + `
	          QUALIFY row_number() OVER (ORDER BY created_ts DESC NULLS LAST) = 1) x`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   res.next();
	   var ctx_lid = res.getColumnValue(1);
	   /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	   /*    commit*/
	   
	}
 
';