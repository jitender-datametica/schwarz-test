CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_get_stored_ctx_load_id(IN PROCESS_GRP STRING, IN CTX_LID FLOAT64)
BEGIN
DECLARE cnt4setwaiting STRING;
DECLARE sql_stmt STRING;
DECLARE stmt STRING;
DECLARE res ARRAY<JSON>;
DECLARE iterator_res INT64 DEFAULT -1;
-- *******************************************************************************************************************************************
--Holt (bei Vorhandensein) die maximale vom Stager für den Dispatcher freigegebene Context-Load-ID as dem LC-Repository
--Reserviert ansonsten neue - noch vom Stager gelockte Contexte für die nächstmögliche Freigabe durch den Stager, mit der Bitte um Nicht-Weiterverwendung durch den Stager.
--process_grp: Dies ist die Prozessgruppe, unter welcher alle Prozesse laufen sollen, die die hier erzeugte context_load-id benutzen sollen.
--Nur für diese Prozesse stellt sie den Laufkontext dar. Aktuelle Beispiele sind POS (für die Gruppe_2 von Prozessen, welche sich
--um die Beladung der E-Journale=PointOfSales kümmern), TXJ (für die Gruppe_2 der Prozesse, welche die TXJ-Schnittstellen verarbeiten)
--Der Rezipientprozess dieser jeweiligen Gruppe_2 kann durch Aufruf dieser Prozedur - und eben für seine Prozessgruppe - seine Context-Load-id ermitteln
--ctx_lid: Rückgabewert: CONTEXT_LOAD_ID für den Dispatcher (0 bei keine gefunden)
--(c) Infomotion GmbH 20190606 Jens Thole
-- ********************************************************************************************************************************************

BEGIN
SET sql_stmt  =  '''SELECT COUNT(*) as cnt FROM p_lew_process.t_lc_prtcl_context_tasks_2 WHERE stager_plan_state = "locked"  AND context_country_cd <> "-"  AND processcontainer = '''|| PROCESS_GRP ;
SET stmt  =  sql_stmt;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'cnt',  stmt)
INTO res ;
SET iterator_res  =  iterator_res  + 1;
SET cnt4setwaiting  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');

IF CAST(cnt4setwaiting AS FLOAT64) > 0 THEN
    BEGIN
    --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.

    SET sql_stmt  =  '''UPDATE p_lew_process.t_lc_prtcl_context_tasks_2 SET  loader_plan_state = "waiting",  updated_ts = CAST(CURRENT_TIMESTAMP() AS DATETIME) WHERE stager_plan_state = "locked" AND context_country_cd <> "-" AND processcontainer = '''|| PROCESS_GRP ;
    
/*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
/*            COMMIT*/


    EXECUTE IMMEDIATE (sql_stmt);
    END;
END IF;

SET sql_stmt  =  '''SELECT COALESCE(MAX(context_load_id), 0) as t123  FROM (SELECT context_load_id   FROM p_lew_process.t_lc_prtcl_context_tasks_2   WHERE success_state IN ("raw", "reload")    AND stager_plan_state = "free"    AND processcontainer = '''||PROCESS_GRP  || ''' QUALIFY (ROW_NUMBER() OVER (ORDER BY created_ts IS NULL, created_ts)) = 1) AS x ''';
SET stmt  =  sql_stmt;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  't123',  stmt)
INTO res ;
SET iterator_res  =  iterator_res  + 1;

/*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
/*    commit*/

SET ctx_lid  =  CAST(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]') AS FLOAT64);
END;
END;



