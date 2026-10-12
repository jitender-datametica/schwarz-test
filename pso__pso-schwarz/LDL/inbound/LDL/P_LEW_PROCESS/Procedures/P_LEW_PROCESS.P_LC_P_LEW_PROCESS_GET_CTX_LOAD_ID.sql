CREATE OR REPLACE PROCEDURE P_LEW_PROCESS.P_LC_P_LEW_PROCESS_GET_CTX_LOAD_ID(LOAD_ID FLOAT, FORCE VARCHAR, PROCESS_GRP VARCHAR, CTX_LID FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	// *******************************************************************************************************************************************
	//Ermittelt die zu verwendende CONTEXT_LOAD_ID für den Stager Plan. Gibt die Contexte frei, die vom Ladedispatcher zur BEladung angemeldet wurden,
	//Erstellt bei Bedarf aus der übergebenen LOAD_ID eine neue CONTEXT-LOAD-ID
	//load_id: Load-ID des aufrufenden AI-Prozesses
	//force:   ["TRUE","FALSE"] (String!) kennzeichnet, ob der aufrufende AI-Prozess unter allen Umständen eine valide CONTEXT-LOAD-ID benötigt
	//oder ob er auch den Dummywert 0 ertragen kann. 
	//(Letzteres ist sinnvoll, wenn der AI-Prozess selbst weiß (z.B wegen eines Parameters), ob er überhaupt aufwachen muß oder nicht. 
	//In diesem Falle kann er stumpf mittels dynamic Parameter, welcher dieses Routine aufruft, eine CTX-LID anfordern und die damit
	//verbundene Freigabe von auf WAITING stehenden Contexten durchführen ohne selbst etwas durchzuführen)
	//process_grp: Dies ist die Prozessgruppe, unter welcher alle Prozesse laufen sollen, die die hier erzeugte context_load-id benutzen sollen.
	//Nur für diese Prozesse stellt sie den Laufkontext dar. Aktuelle Beispiele sind POS (für die Gruppe von Prozessen, welche sich 
	//um die Beladung der E-Journale=PointOfSales kümmern), TXJ (für die Gruppe der Prozesse, welche die TXJ-Schnittstellen verarbeiten)
	//Der Startprozess dieser jeweiligen Gruppe von Prozessen hat die Hoheit, diese Prozedur aufzurufen und damit den Kontext für die 
	//Folger festzulegen.
	//ctx_lid: Rückgabewert= ermittelte CONTEXT_LOAD_ID
	//(c) Infomotion GmbH 20190606 Jens Thole
	// ********************************************************************************************************************************************
	{
	   var cnt4locking;
	   var cnt4setfree;
	   var last_active_ctx_lid;
	   //Wäre etwas neues für den Stager zu locken?    
	   var sql_stmt = `    SELECT count(*)
	    FROM p_lew_process.t_lc_prtcl_context_tasks
	    WHERE processcontainer=upper(` + PROCESS_GRP + `)
	      AND success_state=''raw''
	      AND loader_plan_state=''free''`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   res.next();
	   var cnt4locking = res.getColumnValue(1);
	   var sql_stmt = `    SELECT count(*)
	    FROM p_lew_process.t_lc_prtcl_context_tasks
	    WHERE processcontainer=upper(` + PROCESS_GRP + `)
	      AND (success_state<>''raw'' OR loader_plan_state<>''free'')
	      AND stager_plan_state=''locked''`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   res.next();
	   var cnt4setfree = res.getColumnValue(1);
	   var sql_stmt = `    SELECT coalesce(max(context_load_id),0)
	    FROM (SELECT context_load_id
	          FROM p_lew_process.t_lc_prtcl_context_tasks
	          WHERE --Suchen aller Context-Zeilen, die noch vom Stager gelockt sind und damit nicht durch Ladeprozesse als in Arbeit markiert sind
	                success_state=''raw''
	            AND loader_plan_state=''free''
	            AND stager_plan_state=''locked''
	            AND processcontainer=upper(` + PROCESS_GRP + `)
	          QUALIFY row_number() OVER (ORDER BY created_ts DESC NULLS LAST) = 1) x`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   res.next();
	   var last_active_ctx_lid = res.getColumnValue(1);
	   if (cnt4locking > 0 || cnt4setfree > 0 || last_active_ctx_lid == 0 && FORCE == `TRUE`) {
	      {
	         //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
	         //LOCKING TABLE p_lew_process.t_lc_prtcl_context_tasks for WRITE
	         /* Locke (sicherheitshalber) die Zeilen für den Stager-Plan, die noch nicht durch den Loader in Arbeit sind 
	         Eigentlich kann der Fall nicht vorkommen, da neue Zeilen automatisch durch den Stager gelockt werden - aber man weiß nie, wer herumfingert...*/
	         var sql_stmt = `UPDATE p_lew_process.t_lc_prtcl_context_tasks SET stager_plan_state=''locked'',
	updated_ts=current_timestamp
	WHERE processcontainer=upper(` + PROCESS_GRP + `)
	  AND success_state=''raw''
	  AND loader_plan_state=''free''`;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	         //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
	         /* Gib alle durch den Stager gelockten Zeilen frei, deren Loader-Status durch den Loader auf "waiting" stehen - ergo angefordert für eine Freigabe durch den Stager wurden */
	         var sql_stmt = `UPDATE p_lew_process.t_lc_prtcl_context_tasks SET stager_plan_state=''free'',
	updated_ts=current_timestamp
	WHERE processcontainer=upper(` + PROCESS_GRP + `)
	  AND (success_state<>''raw'' OR loader_plan_state<>''free'')
	  AND stager_plan_state=''locked''`;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	         // Erzeuge im Bedarfsfalle eine neue CTX_LID durch die übergebene LID - sofern Files zum Shreddern detektiert wurden 
	         if (last_active_ctx_lid == 0 && FORCE == `TRUE`) {
	            //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
	            var sql_stmt = `INSERT INTO p_lew_process.t_lc_prtcl_context_tasks (context_load_id,context_country_cd,processcontainer,stager_plan_state,created_ts,updated_ts) VALUES (` + LOAD_ID + `,''-'',` + PROCESS_GRP + `,''locked'',current_timestamp,current_timestamp)`;
	            snowflake.createStatement({
	               sqlText : sql_stmt
	            }).execute();
	         }
	         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	         /*            COMMIT*/
	         
	      }
	      /* hole die gelockte CTX-LID für den Stager-Prozess*/
	      var sql_stmt = `        select max(context_load_id)
	        from (SELECT context_load_id
	              FROM p_lew_process.t_lc_prtcl_context_tasks
	              WHERE processcontainer=upper(` + PROCESS_GRP + `)
	                AND success_state=''raw''
	                AND loader_plan_state=''free''
	                AND stager_plan_state=''locked''
	              QUALIFY row_number() OVER (ORDER BY created_ts DESC NULLS LAST) = 1) x`;
	      var stmt = snowflake.createStatement({
	         sqlText : sql_stmt
	      });
	      var res = stmt.execute();
	      res.next();
	      var ctx_lid = res.getColumnValue(1);
	   } else {
	      ctx_lid = last_active_ctx_lid;
	   }
	   /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	   /*    COMMIT*/
	   
	}
 
';