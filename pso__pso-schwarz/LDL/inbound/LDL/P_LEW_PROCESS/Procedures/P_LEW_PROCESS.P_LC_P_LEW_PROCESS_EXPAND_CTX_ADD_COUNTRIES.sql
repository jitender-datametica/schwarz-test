CREATE OR REPLACE PROCEDURE P_LEW_PROCESS.P_LC_P_LEW_PROCESS_EXPAND_CTX_ADD_COUNTRIES("CTX_LID" FLOAT, "ADD_COUNTRY_LIST" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
/********************************************************************************************************************************************
Addiert zur übergebenen CONTEXT_LOAD_ID die übergebene Länderliste, so daß disjunkte CONTEXT_LOAD_ID - CONTEXT_COUNTRY - Paare entstehen
Ein möglicherweise vorab angelegter Dummysatz mit COUNTRY=''-'' (Dummy) wird bei real vorhandenen Ländern eliminiert.
Fuer die Übersetzung in CONTEXT-AREA-Codes muss der empfangene Prozess wissen, wie er die Länder gruppieren soll.
Daher benötigt er das Level der Clusterung(use_context_area_type) und die korrekte Auswahl der Clusterung selbst  (use_cluster_type)

ctx_lid:                CONTEXT_LOAD_ID für die die Länderliste angefügt werden soll
add_country_list:       Kommaseparierte Länderliste (zweistellige Pseudo-ISO Codes der LIDL--Länder)

(c) Infomotion GmbH 20190606 Jens Thole
*********************************************************************************************************************************************/
var RESULT = "";
var RES_OUT = "";

try
{
if ( CTX_LID > 0 && ADD_COUNTRY_LIST != '''')
{
  //BUILD STATEMENT_1
  var sql_command = ` MERGE INTO p_lew_process.t_lc_prtcl_context_tasks tgt
            USING (SELECT ctx.context_load_id,cntry.src_country_lidl_cd,ctx.processcontainer,ctx.stager_plan_state,ctx.loader_plan_state
                    FROM (--Projektion der Kontextattribute bisher auf die neue Zeile
                          SELECT context_load_id, 
                                 -- es kann nur einen Prozesscontainer zu einer CLID geben
                                 max(processcontainer) processcontainer, 
                                 --aufsteigend: ''free'' vor ''locked'' (= alphanumerisches max)
                                 max(stager_plan_state) stager_plan_state, 
                                 --aufsteigend: ''free'' vor ''locked'' vor ''waiting'' (= alphanumerisches max)
                                 max(loader_plan_state) loader_plan_state 
                          FROM p_lew_process.t_lc_prtcl_context_tasks
                          WHERE context_load_id=?
                          GROUP BY context_load_id
                          ) ctx
                     CROSS JOIN
                         (SELECT c.src_country_lidl_cd 
                          FROM p_lew_core_ac.v_client c
                            INNER JOIN (SELECT '',''||?||'','' countrylist) cl
                              ON countrylist like ''%,''||src_country_lidl_cd||'',%''
                         ) cntry
                  ) src
             ON tgt.context_load_id=src.context_load_id
                 AND tgt.context_country_cd=src.src_country_lidl_cd
            WHEN MATCHED THEN UPDATE 
                SET updated_ts=CURRENT_TIMESTAMP
            WHEN NOT MATCHED THEN INSERT (context_load_id,context_country_cd,processcontainer,stager_plan_state,loader_plan_state,created_ts,updated_ts)
                VALUES (src.context_load_id,src.src_country_lidl_cd,src.processcontainer,src.stager_plan_state,src.loader_plan_state,current_timestamp,current_timestamp)
`;
  
      //RUN STATEMENT_1                               
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [CTX_LID,ADD_COUNTRY_LIST]
        }
        );
        var res = stmt.execute();
        if(res.next()) {
        RES_OUT = res.getColumnValue(1);
        }
        var queryId = stmt.getQueryId();
        RESULT += `STATEMENT_1 output: ` + RES_OUT + ` QueryId: ` + queryId + `
`;


    //BUILD STATEMENT_2
  var sql_command = ` DELETE FROM p_lew_process.t_lc_prtcl_context_tasks
            WHERE context_load_id=?
            AND context_country_cd=''-''
`;
  
      //RUN STATEMENT_2                               
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [CTX_LID]
        }
        );
        var res = stmt.execute();
        if(res.next()) {
        RES_OUT = res.getColumnValue(1);
        }
        var queryId = stmt.getQueryId();
        RESULT += `STATEMENT_2 output: ` + RES_OUT + ` QueryId: ` + queryId + `
`;
  }      
  
}

catch (err) {
        return RESULT + "Failed: " + err;   // Return a success/error indicator.
        }
return "Success"
';