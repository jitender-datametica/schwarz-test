/********************************************************************************************************************************************
Spezialroutine
Holt wie die Originalroutine .p_lc_d_lew_process_get_stored_ctx_load_id
(bei Vorhandensein) die maximale vom Stager für den Dispatcher freigegebene Context-Load-ID as dem LC-Repository
Reserviert ansonsten neue - noch vom Stager gelockte Contexte für die nächstmögliche Freigabe durch den Stager, mit der Bitte um Nicht-Weiterverwendung durch den Stager.
BESONDERHEIT: filtert dabei auf einen übergebenen success_state. Dieser sollte ein speziell durch Überschreiben gesicherter Status_1 sein.
               Im allgemeinen sollte hier ein waiting_for[01...99] Status_1 stehen, der extra für Zwischenstops und Wiederaufnahme designed wurde.
              Im Normalfall (also Originalroutine p_lc_d_lew_process_get_stored_ctx_areas) wird nur status_1 "raw" oder "reload" gefiltert.
Übersetzt die Country_1-Gruppe_1 in eine_1 Liste von AREA-Codes, welche durch die Wahl der Clusterung (Übergabeparameter) bestimmt werden.

process_grp: Dies ist die Prozessgruppe, unter welcher alle Prozesse laufen sollen, die die hier erzeugte context_load-id benutzen sollen.
             Nur für diese Prozesse stellt sie den Laufkontext dar. Aktuelle Beispiele sind POS (für die Gruppe_1 von Prozessen, welche sich
             um die Beladung der E-Journale=PointOfSales kümmern), TXJ (für die Gruppe_1 der Prozesse, welche die TXJ-Schnittstellen verarbeiten)
             Der Rezipientprozess dieser jeweiligen Gruppe_1 kann durch Aufruf dieser Prozedur - und eben für seine Prozessgruppe - seine Context-Load-id ermitteln
filter_special_success_state: der spezifisch geforderte WAITING-Status_1 "waiting_for[01...99]"

data_dependency_for: filter in interface log for the last processing of the given module e.g. HQ_MASTER, WH_MOVE etc.

dependency_check_date: check last process date of the given module against this date
ctx_lid: Rückgabewert: CONTEXT_LOAD_ID für den Dispatcher (0 bei keine gefunden)

(c) Infomotion GmbH 20190606 Jens Thole
*********************************************************************************************************************************************/

CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_get_stored_ctx_load_id_special(IN PROCESS_GRP STRING, IN FILTER_SPECIAL_SUCCESS_STATE STRING, IN DATA_DEPENDENCY_FOR STRING, IN DEPENDENCY_CHECK_DATE STRING, OUT out_param STRING)
BEGIN
DECLARE CNT4SETWAITING STRING;
DECLARE CTX_LID STRING;
DECLARE sql_command STRING;
DECLARE stmt STRING;
DECLARE res ARRAY<JSON>;
DECLARE iterator_res INT64 DEFAULT 0;
BEGIN
--BUILD STATEMENT_1

SET sql_command  =  '''SELECT COUNT(*) as c1 FROM p_lew_process.t_lc_prtcl_context_tasks_1 WHERE stager_plan_state = "locked"  AND context_country_cd <> "-"  AND processcontainer = @PROCESS_GRP ''';
--RUN STATEMENT_1

SET stmt  =  sql_command;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'c1',  stmt)
INTO res  USING PROCESS_GRP AS PROCESS_GRP;

IF res IS NOT NULL THEN
    BEGIN
    SET CNT4SETWAITING  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    END;
END IF;


IF CAST(CNT4SETWAITING AS FLOAT64) > 0 THEN
    BEGIN
    --BUILD STATEMENT_2

    SET sql_command  =  '''UPDATE p_lew_process.t_lc_prtcl_context_tasks_1 SET  loader_plan_state = "waiting",  updated_ts = CAST(CURRENT_TIMESTAMP() AS DATETIME) WHERE stager_plan_state = "locked" AND context_country_cd <> "-" AND processcontainer = @PROCESS_GRP ''';
    --RUN STATEMENT_2

    SET stmt  =  sql_command;

    EXECUTE IMMEDIATE  (stmt)
     USING PROCESS_GRP AS PROCESS_GRP;
    END;
END IF;

--BUILD STATEMENT_3

SET sql_command  =  '''SELECT COALESCE(MAX(t2.context_load_id), 0) AS T123 FROM (SELECT TASK.context_load_id,    MIN(CASE      WHEN PRTCL.country_iso_cd IS NOT NULL      THEN 1      ELSE 0      END) AS context_ready_for_processing,    MAX(TASK.created_ts) AS max_ts   FROM p_lew_process.t_lc_prtcl_context_tasks_1 AS TASK    LEFT JOIN p_lew_process.t_wawi_sys_dc_trans_dayend_int_1 AS PRTCL ON TASK.context_country_cd = PRTCL.country_iso_cd        AND PRTCL.dat_dayend >= PARSE_DATE("%Y%m%d", @DEPENDENCY_CHECK_DATE) AND PRTCL.data_type =      @DATA_DEPENDENCY_FOR   WHERE TASK.success_state IN (LOWER(@FILTER_SPECIAL_SUCCESS_STATE), "reload")    AND TASK.stager_plan_state = "free"    AND TASK.processcontainer = @PROCESS_GRP   GROUP BY TASK.context_load_id   QUALIFY (ROW_NUMBER() OVER (ORDER BY context_ready_for_processing IS NULL, context_ready_for_processing, max_ts         IS NULL, max_ts)) = 1) AS t2 ''';
--RUN STATEMENT_3

SET stmt  =  sql_command;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'T123',  stmt)
INTO res  USING DEPENDENCY_CHECK_DATE AS DEPENDENCY_CHECK_DATE,  DATA_DEPENDENCY_FOR AS DATA_DEPENDENCY_FOR,  FILTER_SPECIAL_SUCCESS_STATE AS FILTER_SPECIAL_SUCCESS_STATE,  PROCESS_GRP AS PROCESS_GRP;

IF res IS NOT NULL THEN
    BEGIN
    SET CTX_LID  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    END;
END IF;

EXCEPTION
WHEN ERROR THEN
-- Return a success/error indicator.

SET out_param  =  'Failed: ' || @@ERROR.MESSAGE;
SELECT out_param;
RETURN;
END;
SET out_param  =  CTX_LID;
SELECT out_param;
RETURN;
END;