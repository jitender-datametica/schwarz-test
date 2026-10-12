CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_get_ctx_load_id(IN LOAD_ID FLOAT64, IN FORCE STRING, IN PROCESS_GRP STRING, IN CTX_LID FLOAT64)
BEGIN
DECLARE cnt4locking STRING;
DECLARE cnt4setfree STRING;
DECLARE last_active_ctx_lid STRING;
DECLARE sql_stmt STRING;
DECLARE stmt STRING;
DECLARE res ARRAY<JSON>;
DECLARE iterator_res INT64 DEFAULT -1;
-- *******************************************************************************************************************************************
--Ermittelt die zu verwendende CONTEXT_LOAD_ID für den Stager Plan. Gibt die Contexte frei, die vom Ladedispatcher zur BEladung angemeldet wurden,
--Erstellt bei Bedarf aus der übergebenen LOAD_ID eine neue CONTEXT-LOAD-ID
--load_id: Load-ID des aufrufenden AI-Prozesses
--force:   ["TRUE","FALSE"] (String!) kennzeichnet, ob der aufrufende AI-Prozess unter allen Umständen eine valide CONTEXT-LOAD-ID benötigt
--oder ob er auch den Dummywert 0 ertragen kann.
--(Letzteres ist sinnvoll, wenn der AI-Prozess selbst weiß (z.B wegen eines Parameters), ob er überhaupt aufwachen muß oder nicht.
--In diesem Falle kann er stumpf mittels dynamic Parameter, welcher dieses Routine aufruft, eine CTX-LID anfordern und die damit
--verbundene Freigabe von auf WAITING stehenden Contexten durchführen ohne selbst etwas durchzuführen)
--process_grp: Dies ist die Prozessgruppe, unter welcher alle Prozesse laufen sollen, die die hier erzeugte context_load-id benutzen sollen.
--Nur für diese Prozesse stellt sie den Laufkontext dar. Aktuelle Beispiele sind POS (für die Gruppe von Prozessen, welche sich
--um die Beladung der E-Journale=PointOfSales kümmern), TXJ (für die Gruppe der Prozesse, welche die TXJ-Schnittstellen verarbeiten)
--Der Startprozess dieser jeweiligen Gruppe von Prozessen hat die Hoheit, diese Prozedur aufzurufen und damit den Kontext für die
--Folger festzulegen.
--ctx_lid: Rückgabewert= ermittelte CONTEXT_LOAD_ID
--(c) Infomotion GmbH 20190606 Jens Thole
-- ********************************************************************************************************************************************

BEGIN
--Wäre etwas neues für den Stager zu locken?

SET sql_stmt  =  '''SELECT COUNT(*) as cnt FROM p_lew_process.t_lc_prtcl_context_tasks WHERE processcontainer = UPPER( '''|| PROCESS_GRP ||''' )  AND success_state = "raw"  AND loader_plan_state = "free" ''';
SET stmt  =  sql_stmt;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'cnt',  stmt)
INTO res ;
SET iterator_res  =  iterator_res  + 1;
SET cnt4locking  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');
SET sql_stmt  =  '''SELECT COUNT(*) as cnt1  FROM p_lew_process.t_lc_prtcl_context_tasks WHERE processcontainer = UPPER( '''||PROCESS_GRP||''' )  AND (success_state <> "raw" OR loader_plan_state <> "free")  AND stager_plan_state = "locked" ''';
SET stmt  =  sql_stmt;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'cnt1',  stmt)
INTO res ;
SET iterator_res  =  iterator_res  + 1;
SET cnt4setfree  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');
SET sql_stmt  =  '''SELECT COALESCE(MAX(context_load_id), 0) as cmax FROM (SELECT context_load_id   FROM p_lew_process.t_lc_prtcl_context_tasks   WHERE     -- Suchen aller Context-Zeilen, die noch vom Stager gelockt sind und damit nicht durch Ladeprozesse als in Arbeit markiert sind
      success_state = "raw"    AND loader_plan_state = "free"    AND stager_plan_state = "locked"    AND processcontainer = UPPER( '''|| PROCESS_GRP ||''' )   QUALIFY (ROW_NUMBER() OVER (ORDER BY created_ts IS NULL, created_ts)) = 1) AS x ''';
SET stmt  =  sql_stmt;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'cmax',  stmt)
INTO res ;
SET iterator_res  =  iterator_res  + 1;
SET last_active_ctx_lid  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');

/*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
/*    COMMIT*/


IF CAST(cnt4locking AS FLOAT64) > 0 OR CAST(cnt4setfree AS FLOAT64) > 0 OR CAST(last_active_ctx_lid AS FLOAT64) = 0 AND FORCE = 'TRUE' THEN
    BEGIN
    BEGIN
    --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
--LOCKING TABLE p_lew_process.t_lc_prtcl_context_tasks for WRITE
/* Locke (sicherheitshalber) die Zeilen für den Stager-Plan, die noch nicht durch den Loader in Arbeit sind 
	         Eigentlich kann der Fall nicht vorkommen, da neue Zeilen automatisch durch den Stager gelockt werden - aber man weiß nie, wer herumfingert...*/

    SET sql_stmt  =  '''UPDATE p_lew_process.t_lc_prtcl_context_tasks SET  stager_plan_state = "locked",  updated_ts = CAST(CURRENT_TIMESTAMP() AS DATETIME) WHERE processcontainer = UPPER( '''|| PROCESS_GRP ||''' ) AND success_state = "raw" AND loader_plan_state = "free" ''';

    EXECUTE IMMEDIATE (sql_stmt);
    --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
/* Gib alle durch den Stager gelockten Zeilen frei, deren Loader-Status durch den Loader auf "waiting" stehen - ergo angefordert für eine Freigabe durch den Stager wurden */

    SET sql_stmt  =  '''UPDATE p_lew_process.t_lc_prtcl_context_tasks SET  stager_plan_state = "free",  updated_ts = CAST(CURRENT_TIMESTAMP() AS DATETIME) WHERE processcontainer = UPPER( '''|| PROCESS_GRP ||''' ) AND (success_state <> "raw" OR loader_plan_state <> "free") AND   stager_plan_state = "locked" ''';

    EXECUTE IMMEDIATE (sql_stmt);
    -- Erzeuge im Bedarfsfalle eine neue CTX_LID durch die übergebene LID - sofern Files zum Shreddern detektiert wurden

/*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
/*            COMMIT*/


    IF CAST(last_active_ctx_lid AS FLOAT64) = 0 AND FORCE = 'TRUE' THEN
        BEGIN
        --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.

        SET sql_stmt  =  '''INSERT INTO p_lew_process.t_lc_prtcl_context_tasks (context_load_id, context_country_cd, processcontainer,  stager_plan_state, created_ts, updated_ts) (SELECT CAST(LOAD_ID AS INTEGER) AS context_load_id,   "-" AS context_country_cd,   '''|| PROCESS_GRP ||''' AS processcontainer,   "locked" AS stager_plan_state,   CAST(CURRENT_TIMESTAMP() AS DATETIME) AS created_ts,   CAST(CURRENT_TIMESTAMP() AS DATETIME) AS updated_ts) ''';

        EXECUTE IMMEDIATE (sql_stmt);
        END;
    END IF;

    END;
    /* hole die gelockte CTX-LID für den Stager-Prozess*/

    SET sql_stmt  =  '''SELECT MAX(context_load_id) as maxc FROM (SELECT context_load_id   FROM p_lew_process.t_lc_prtcl_context_tasks   WHERE processcontainer = UPPER( '''|| PROCESS_GRP ||''' )    AND success_state = "raw"    AND loader_plan_state = "free"    AND stager_plan_state = "locked"   QUALIFY (ROW_NUMBER() OVER (ORDER BY created_ts IS NULL, created_ts)) = 1) AS x ''';
    SET stmt  =  sql_stmt;

    EXECUTE IMMEDIATE format("""
    SELECT ARRAY_AGG(JSON_ARRAY(%s))
    FROM (%s)
    """,  'maxc',  stmt)
    INTO res ;
    SET iterator_res  =  iterator_res  + 1    ;
    SET ctx_lid  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    END;
ELSE
    BEGIN
    SET ctx_lid  =  CAST(last_active_ctx_lid as FLOAT64);
    END;
END IF;

END;
END;
