CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_get_stored_ctx_load_id_special (PROCESS_GRP STRING, FILTER_SPECIAL_SUCCESS_STATE STRING, DATA_DEPENDENCY_FOR STRING, DEPENDENCY_CHECK_DATE STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
/********************************************************************************************************************************************
Spezialroutine
Holt wie die Originalroutine .p_lc_d_lew_process_get_stored_ctx_load_id
(bei Vorhandensein) die maximale vom Stager für den Dispatcher freigegebene Context-Load-ID as dem LC-Repository
Reserviert ansonsten neue - noch vom Stager gelockte Contexte für die nächstmögliche Freigabe durch den Stager, mit der Bitte um Nicht-Weiterverwendung durch den Stager.
BESONDERHEIT: filtert dabei auf einen übergebenen success_state. Dieser sollte ein speziell durch Überschreiben gesicherter Status sein.
               Im allgemeinen sollte hier ein waiting_for[01...99] Status stehen, der extra für Zwischenstops und Wiederaufnahme designed wurde.
              Im Normalfall (also Originalroutine p_lc_d_lew_process_get_stored_ctx_areas) wird nur status "raw" oder "reload" gefiltert.
Übersetzt die Country-Gruppe in eine Liste von AREA-Codes, welche durch die Wahl der Clusterung (Übergabeparameter) bestimmt werden.

process_grp: Dies ist die Prozessgruppe, unter welcher alle Prozesse laufen sollen, die die hier erzeugte context_load-id benutzen sollen.
             Nur für diese Prozesse stellt sie den Laufkontext dar. Aktuelle Beispiele sind POS (für die Gruppe von Prozessen, welche sich
             um die Beladung der E-Journale=PointOfSales kümmern), TXJ (für die Gruppe der Prozesse, welche die TXJ-Schnittstellen verarbeiten)
             Der Rezipientprozess dieser jeweiligen Gruppe kann durch Aufruf dieser Prozedur - und eben für seine Prozessgruppe - seine Context-Load-id ermitteln
filter_special_success_state: der spezifisch geforderte WAITING-Status "waiting_for[01...99]"

data_dependency_for: filter in interface log for the last processing of the given module e.g. HQ_MASTER, WH_MOVE etc.

dependency_check_date: check last process date of the given module against this date
ctx_lid: Rückgabewert: CONTEXT_LOAD_ID für den Dispatcher (0 bei keine gefunden)

(c) Infomotion GmbH 20190606 Jens Thole
*********************************************************************************************************************************************/
var CNT4SETWAITING;
var CTX_LID;


try {

  //BUILD STATEMENT_1
  var sql_command = `SELECT
	count(*)
	FROM p_lew_process.t_lc_prtcl_context_tasks
	   WHERE stager_plan_state='locked'
	     AND context_country_cd<>'-'
	     AND processcontainer= ?
`;
                    
  //RUN STATEMENT_1                               
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [PROCESS_GRP]
        }
        );
        var res = stmt.execute();
        if(res.next()) {
        CNT4SETWAITING = res.getColumnValue(1);
        }
        
 if (CNT4SETWAITING > 0) 
    {  
  
   //BUILD STATEMENT_2
  var sql_command = `UPDATE p_lew_process.t_lc_prtcl_context_tasks
	SET loader_plan_state='waiting',
	    updated_ts=current_timestamp
	WHERE stager_plan_state='locked'
	  AND context_country_cd<>'-'
	  AND processcontainer= ?
`;
                    
  //RUN STATEMENT_2                               
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [PROCESS_GRP]
        }
        );
        var res = stmt.execute();
    }
                  
   //BUILD STATEMENT_3
  var sql_command = `SELECT
	COALESCE(max(context_load_id),0)
	FROM (SELECT
	task.context_load_id
	, MIN(CASE WHEN prtcl.country_iso_cd IS NOT NULL THEN 1 ELSE 0 END) context_ready_for_processing
	, MAX(created_ts) max_ts
	FROM p_lew_process.t_lc_prtcl_context_tasks task
	LEFT OUTER JOIN p_lew_process.t_wawi_sys_dc_trans_dayend_int prtcl
		ON task.context_country_cd = prtcl.country_iso_cd
		AND prtcl.dat_dayend >= to_date(?, 'YYYYMMDD')
		AND prtcl.data_type= ?
	WHERE task.success_state IN (LOWER(?), 'reload')
	AND task.stager_plan_state='free'
	AND task.processcontainer= ?
	GROUP BY task.context_load_id
	QUALIFY ROW_NUMBER() OVER (ORDER BY context_ready_for_processing DESC NULLS LAST , max_ts DESC NULLS LAST) = 1
	) x`;
                    
  //RUN STATEMENT_3                               
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [DEPENDENCY_CHECK_DATE,DATA_DEPENDENCY_FOR,FILTER_SPECIAL_SUCCESS_STATE,PROCESS_GRP]
        }
        );
        var res = stmt.execute();
        if(res.next()) {
        CTX_LID = res.getColumnValue(1);
        }
	   
}
catch (err) {
        return + "Failed: " + err;   // Return a success/error indicator.
        }
return CTX_LID;
$$
;