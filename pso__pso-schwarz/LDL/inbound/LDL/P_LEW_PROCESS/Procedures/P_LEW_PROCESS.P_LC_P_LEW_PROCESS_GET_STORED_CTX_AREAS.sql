CREATE OR REPLACE PROCEDURE P_LEW_PROCESS.P_LC_P_LEW_PROCESS_GET_STORED_CTX_AREAS(CTX_LID FLOAT, USED_AREA_GRP_TYPE VARCHAR, USED_CLUSTER_TYPE VARCHAR, AREA_CDS VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	// *******************************************************************************************************************************************
	//Holt (bei Vorhandensein) die Country-Liste aus der vom Stager zum Laden freigegebenen CONTEXT-COUNTRY-Gruppe - referenziert durch die 
	//übergebene CONTEXT-LOAD-ID.
	//Übersetzt die Country-Gruppe in eine Liste von AREA-Codes, welche durch die Wahl der Clusterung (Übergabeparameter) bestimmt werden.
	//ctx_lid:            CONTEXT_LOAD_ID für den der Dispatcher laden möchte (sofern durch Stager freigegeben)
	//used_area_grp_type: Für die Übersetzung gewählter AREA_TYPE (= Level der Areale) [COUNTRY,CLUSTER,ALL]
	//used_cluster_type:  Wird in "used_area_grp_type" das Level CLUSTER verwendet, so muss bedacht werden, daß es verschiedene parallel 
	//existente Clusterungen von Ländern gibt. Daher muss zusätzlich spezifiziert werden, 
	//welche davon herangezogen werden soll - aktuell [SAP, POS]
	//Wird in "used_area_grp_type" das Level COUNTRY oder ALL verwendet, gibt es nur den CLUSTER-Type [-] 
	//- also naturgemäß keine Unterscheidung
	//area_cds:           Kommaseparierte Liste von CONTEXT_AREA_CODES für die angegebene CONTEXT_LOAD_ID des parametrisierten Hierarchielevels (used_area_grp_type) und 
	//bei Hierarchielevel=CLUSTER des CLustertypes (used_cluster_type)
	//(c) Infomotion GmbH 20190606 Jens Thole
	// ********************************************************************************************************************************************
	{
	   var real_cluster_type;
	   var cnt4locking_or_update;
	   real_cluster_type = USED_CLUSTER_TYPE;
	   //Sicherheitshalber wird ausgeschlossen, dass der Cluster-Type für die Level COUNTRY und ALL falsch gesetzt werden kann:
	   if (USED_AREA_GRP_TYPE != `CLUSTER`) {
	      real_cluster_type = `-`;
	   }
	   /* Wir haben eine CTX_LID zugeteilt bekommen und wollen diese locken - sofern sie nicht schon durch uns locked ist - müssen wir?
	   Wir wollen außerdem den COUNTRY-Teil dessen übersetzen.
	   Wir sollen dazu "used_area_grp_type" und "used_cluster_type" verwenden. Entspricht das schon dem Stand unserer Auftragsliste?*/
	   var sql_stmt = `    SELECT count(*)
	    FROM p_lew_process.t_lc_prtcl_context_tasks
	    WHERE context_load_id = ` + CTX_LID + `
	    AND stager_plan_state =''free''
	    AND (loader_plan_state <> ''locked'' OR context_area_type <> ` + USED_AREA_GRP_TYPE + ` OR cluster_type <> ` + real_cluster_type + `)`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   res.next();
	   var cnt4locking_or_update = res.getColumnValue(1);
	   if (cnt4locking_or_update > 0) {
	      {
	         //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
	         var sql_stmt = `UPDATE p_lew_process.t_lc_prtcl_context_tasks SET loader_plan_state = ''locked'',
	context_area_type = ` + USED_AREA_GRP_TYPE + `,
	cluster_type = ` + real_cluster_type + `,
	updated_ts=current_timestamp
	WHERE context_load_id= ` + CTX_LID + `
	AND stager_plan_state=''free''`;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	         /*            COMMIT*/
	         
	      }
	   }
	   var sql_stmt = `    SELECT CAST(LTRIM(
	    TRIM(TRAILING '','' FROM
	          OREPLACE(OREPLACE(OREPLACE(CAST(XMLAGG(TRIM(cast(area_cd as varchar(5)))|| '','' ORDER BY area_cd) as VARCHAR(300)),'' '',''''),'',,'','',''),'',,'','','')
	        ), '','') AS VARCHAR(300))
	    from (SELECT area_cd
	            FROM p_lew_process.v_etl_context_orga_area a
	            JOIN p_lew_process.t_lc_prtcl_context_tasks t
	            ON a.country_cd=t.context_country_cd
	            WHERE a.area_grp_type = t.context_area_type
	            AND a.cluster_type = t.cluster_type
	            AND t.loader_plan_state=''locked''
	            AND t.success_state in (''raw'', ''reload'')
	            AND t.context_load_id= ` + CTX_LID + `
	            GROUP BY 1) x`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   res.next();
	   var area_cds = res.getColumnValue(1);
	   /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	   /*    COMMIT*/
	   
	}
 
';