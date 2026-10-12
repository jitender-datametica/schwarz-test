CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_get_stored_ctx_areas_special (CTX_LID FLOAT, USED_AREA_GRP_TYPE STRING, USED_CLUSTER_TYPE STRING, FILTER_SPECIAL_SUCCESS_STATE STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$

/********************************************************************************************************************************************
Spezialroutine
Holt wie die Originalroutine p_lc_d_lew_process_get_stored_ctx_areas
(bei Vorhandensein) die Country-Liste aus der vom Stager zum Laden freigegebenen CONTEXT-COUNTRY-Gruppe - referenziert durch die
übergebene CONTEXT-LOAD-ID.
BESONDERHEIT: filtert dabei auf einen übergebenen success_state. Dieser sollte ein speziell durch Überschreiben gesicherter Status sein.
               Im allgemeinen sollte hier ein waiting_for[01...99] Status stehen, der extra für Zwischenstops und Wiederaufnahme designed wurde.
              Im Normalfall (also Originalroutine p_lc_d_lew_process_get_stored_ctx_areas) wird nur status "raw" oder "reload" gefiltert.
Übersetzt die Country-Gruppe in eine Liste von AREA-Codes, welche durch die Wahl der Clusterung (Übergabeparameter) bestimmt werden.

ctx_lid:            CONTEXT_LOAD_ID für den der Dispatcher laden möchte (sofern durch Stager freigegeben)
used_area_grp_type: Für die Übersetzung gewählter AREA_TYPE (= Level der Areale) [COUNTRY,CLUSTER,ALL]
used_cluster_type:  Wird in "used_area_grp_type" das Level CLUSTER verwendet, so muss bedacht werden, daß es verschiedene parallel
                        existente Clusterungen von Ländern gibt. Daher muss zusätzlich spezifiziert werden,
                        welche davon herangezogen werden soll - aktuell [SAP, POS]
                    Wird in "used_area_grp_type" das Level COUNTRY oder ALL verwendet, gibt es nur den CLUSTER-Type [-]
                        - also naturgemäß keine Unterscheidung
filter_special_success_state: der spezifisch geforderte WAITING-Status "waiting_for[01...99]"
area_cds:           Kommaseparierte Liste von CONTEXT_AREA_CODES für die angegebene CONTEXT_LOAD_ID des parametrisierten Hierarchielevels (used_area_grp_type) und
                    bei Hierarchielevel=CLUSTER des CLustertypes (used_cluster_type)

(c) Infomotion GmbH 20190606 Jens Thole
*********************************************************************************************************************************************/

var REAL_CLUSTER_TYPE;
var CNT4LOCKING_OR_UPDATE;
var AREA_CDS=[];
var RESULT = "";
var RES_OUT = "";
{REAL_CLUSTER_TYPE=USED_CLUSTER_TYPE}
/*--Sicherheitshalber wird ausgeschlossen, dass der Cluster-Type für die Level COUNTRY und ALL falsch gesetzt werden kann: */

{if (USED_AREA_GRP_TYPE!= "CLUSTER") REAL_CLUSTER_TYPE = '-'}

try{
	/* Wir haben eine CTX_LID zugeteilt bekommen und wollen diese locken - sofern sie nicht schon durch uns locked ist - müssen wir?
       Wir wollen außerdem den COUNTRY-Teil dessen übersetzen.
           Wir sollen dazu "used_area_grp_type" und "used_cluster_type" verwenden. Entspricht das schon dem Stand unserer Auftragsliste?*/
	
	//BUILD STATEMENT_1
	var sql_command = `SELECT count(*) 
	FROM p_lew_process.t_lc_prtcl_context_tasks
	WHERE context_load_id = ?
    AND stager_plan_state ='free'
    AND (loader_plan_state <> 'locked'
            OR context_area_type <> ?
            OR cluster_type <> ?)`;
      //RUN STATEMENT_1                              
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [CTX_LID,USED_AREA_GRP_TYPE,REAL_CLUSTER_TYPE]
        }
        );
        var res = stmt.execute();
        if(res.next()) {
        CNT4LOCKING_OR_UPDATE = res.getColumnValue(1);
        RES_OUT = res.getColumnValue(1);
        }
        var queryId = stmt.getQueryId();
        RESULT += `STATEMENT_1 output: ` + RES_OUT + ` QueryId: ` + queryId + `
`;
		
if (CNT4LOCKING_OR_UPDATE > 0) 
{
    //BUILD STATEMENT_2
  var sql_command = `UPDATE p_lew_process.t_lc_prtcl_context_tasks
            SET loader_plan_state = 'locked',
                context_area_type = ?,
                cluster_type = ?,
                updated_ts=current_timestamp
            WHERE context_load_id= ?
            AND stager_plan_state='free'
`;
  
      //RUN STATEMENT_2                               
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [USED_AREA_GRP_TYPE,REAL_CLUSTER_TYPE,CTX_LID]
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
  var sql_command = `SELECT LISTAGG(area_cd,',') WITHIN GROUP(ORDER BY area_cd)
            FROM p_lew_process.v_etl_context_orga_area a 
              JOIN p_lew_process.t_lc_prtcl_context_tasks t
               ON a.country_cd=t.context_country_cd
            WHERE a.area_grp_type = t.context_area_type
            AND a.cluster_type = t.cluster_type
            AND t.loader_plan_state='locked'
            AND t.success_state in (LOWER(?), 'reload')
            AND t.context_load_id= ?
            GROUP BY area_cd
`;
  
      //RUN STATEMENT_3                               
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [FILTER_SPECIAL_SUCCESS_STATE,CTX_LID]
        }
        );
        var res = stmt.execute();
        while (res.next()) {
        AREA_CDS.push(res.getColumnValue(1));
        }
        if (res.next()) {
        RES_OUT = res.getColumnValue(1);
        }
        var queryId = stmt.getQueryId();
        RESULT += `STATEMENT_3 output: ` + RES_OUT + ` QueryId: ` + queryId + `
`;
    	
}	
catch (err) {
        return RESULT + "Failed: " + err;   // Return a success/error indicator.
        }
return AREA_CDS;
$$
;