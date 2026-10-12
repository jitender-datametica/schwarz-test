CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_get_stored_ctx_areas_special(IN CTX_LID FLOAT64, IN USED_AREA_GRP_TYPE STRING, IN USED_CLUSTER_TYPE STRING, IN FILTER_SPECIAL_SUCCESS_STATE STRING, OUT out_param STRING)
BEGIN
/********************************************************************************************************************************************
Spezialroutine
Holt wie die Originalroutine p_lc_d_lew_process_get_stored_ctx_areas
(bei Vorhandensein) die Country_2-Liste aus der vom Stager zum Laden freigegebenen CONTEXT-COUNTRY_2-Gruppe_2 - referenziert durch die
übergebene CONTEXT-LOAD-ID.
BESONDERHEIT: filtert dabei auf einen übergebenen success_state. Dieser sollte ein speziell durch Überschreiben gesicherter Status_2 sein.
               Im allgemeinen sollte hier ein waiting_for[01...99] Status_2 stehen, der extra für Zwischenstops und Wiederaufnahme designed wurde.
              Im Normalfall (also Originalroutine p_lc_d_lew_process_get_stored_ctx_areas) wird nur status_2 "raw" oder "reload" gefiltert.
Übersetzt die Country_2-Gruppe_2 in eine_2 Liste von AREA-Codes, welche durch die Wahl der Clusterung (Übergabeparameter) bestimmt werden.

ctx_lid:            CONTEXT_LOAD_ID für den der Dispatcher laden möchte (sofern durch Stager freigegeben)
used_area_grp_type: Für die Übersetzung gewählter AREA_TYPE (= Level der Areale) [COUNTRY_2,CLUSTER,ALL]
used_cluster_type:  Wird in "used_area_grp_type" das Level CLUSTER verwendet, so muss bedacht werden, daß es verschiedene parallel
                        existente Clusterungen von Ländern gibt. Daher muss zusätzlich spezifiziert werden,
                        welche davon herangezogen werden soll - aktuell [SAP, POS]
                    Wird in "used_area_grp_type" das Level COUNTRY_2 oder ALL verwendet, gibt es nur den CLUSTER-Type [-]
                        - also naturgemäß keine Unterscheidung
filter_special_success_state: der spezifisch geforderte WAITING-Status_2 "waiting_for[01...99]"
area_cds:           Kommaseparierte Liste von CONTEXT_AREA_CODES für die angegebene CONTEXT_LOAD_ID des parametrisierten Hierarchielevels (used_area_grp_type) und
                    bei Hierarchielevel=CLUSTER des CLustertypes (used_cluster_type)

(c) Infomotion GmbH 20190606 Jens Thole
*********************************************************************************************************************************************/

DECLARE REAL_CLUSTER_TYPE STRING;
DECLARE CNT4LOCKING_OR_UPDATE STRING;
DECLARE AREA_CDS ARRAY<STRING(16777216)>;
DECLARE RESULT STRING;
DECLARE RES_OUT STRING;
DECLARE sql_command STRING;
DECLARE stmt STRING;
DECLARE res ARRAY<JSON>;
DECLARE queryId STRING;
DECLARE iterator_res INT64 DEFAULT 0;
SET AREA_CDS  =  [];
SET RESULT  =  '';
SET RES_OUT  =  '';
BEGIN
SET REAL_CLUSTER_TYPE  =  USED_CLUSTER_TYPE;
END;
/*--Sicherheitshalber wird ausgeschlossen, dass der Cluster-Type für die Level COUNTRY_2 und ALL falsch gesetzt werden kann: */

BEGIN

IF USED_AREA_GRP_TYPE <> 'CLUSTER' THEN
    BEGIN
    SET REAL_CLUSTER_TYPE  =  '-';
    END;
END IF;

END;
BEGIN
/* Wir haben eine_2 CTX_LID zugeteilt bekommen und wollen diese locken - sofern sie nicht schon durch uns locked ist - müssen wir?
       Wir wollen außerdem den COUNTRY_2-Teil dessen übersetzen.
           Wir sollen dazu "used_area_grp_type" und "used_cluster_type" verwenden. Entspricht das schon dem Stand unserer Auftragsliste?*/

--BUILD STATEMENT_1

SET sql_command  =  '''SELECT COUNT(*) as c1 FROM p_lew_process.t_lc_prtcl_context_tasks_2 WHERE context_load_id = @CTX_LID  AND stager_plan_state = "free"  AND (loader_plan_state <> "locked" OR context_area_type <> @USED_AREA_GRP_TYPE OR cluster_type <>     @REAL_CLUSTER_TYPE) ''';
--RUN STATEMENT_1

SET stmt  =  sql_command;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'c1',  stmt)
INTO res  USING USED_AREA_GRP_TYPE AS USED_AREA_GRP_TYPE, REAL_CLUSTER_TYPE AS REAL_CLUSTER_TYPE,  CTX_LID AS CTX_LID;

SET queryId  =  @@current_job_id;
IF res IS NOT NULL THEN
    BEGIN
    SET CNT4LOCKING_OR_UPDATE  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    SET RES_OUT  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    END;
END IF;


SET RESULT  =  RESULT || 'STATEMENT_1 output: ' || RES_OUT || ' QueryId: ' || queryId || '''
''';

IF CAST(CNT4LOCKING_OR_UPDATE AS FLOAT64) > 0 THEN
    BEGIN
    --BUILD STATEMENT_2

    SET sql_command  =  '''UPDATE p_lew_process.t_lc_prtcl_context_tasks_2 SET  loader_plan_state = "locked",  context_area_type = @USED_AREA_GRP_TYPE,  cluster_type = @REAL_CLUSTER_TYPE,  updated_ts = CAST(CURRENT_TIMESTAMP() AS DATETIME) WHERE context_load_id = @CTX_LID AND stager_plan_state = "free" ''';
    --RUN STATEMENT_2

    SET stmt  =  sql_command;

    EXECUTE IMMEDIATE (stmt)
    INTO res  USING USED_AREA_GRP_TYPE AS USED_AREA_GRP_TYPE, REAL_CLUSTER_TYPE AS REAL_CLUSTER_TYPE,  CTX_LID AS CTX_LID;
    SET queryId  =  @@current_job_id;
    IF res IS NOT NULL THEN
        BEGIN
        SET RES_OUT  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')        ;
        END;
    END IF;

    
    SET RESULT  =  RESULT || 'STATEMENT_2 output: ' || RES_OUT || ' QueryId: ' || queryId || '''
''';
    END;
END IF;

SET sql_command  =  '''SELECT STRING_AGG(A.area_cd, "," ORDER BY A.area_cd IS NULL, A.area_cd)  as c2 FROM p_lew_process.v_etl_context_orga_area_2 AS A  INNER JOIN p_lew_process.t_lc_prtcl_context_tasks_2 AS T ON A.country_cd = T.context_country_cd WHERE A.area_grp_type = T.context_area_type  AND A.cluster_type = T.cluster_type  AND T.loader_plan_state = "locked"  AND T.success_state IN (LOWER(@FILTER_SPECIAL_SUCCESS_STATE), "reload")  AND T.context_load_id = @CTX_LID GROUP BY A.area_cd ''';
--RUN STATEMENT_3

SET stmt  =  sql_command;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'c2',  stmt)
INTO res  USING FILTER_SPECIAL_SUCCESS_STATE AS FILTER_SPECIAL_SUCCESS_STATE,  CTX_LID AS CTX_LID;
SET queryId  =  @@current_job_id;
WHILE (iterator_res  < ARRAY_LENGTH(res)) DO
    BEGIN
    SET AREA_CDS  =  ARRAY_CONCAT(AREA_CDS, [JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')]);
    SET iterator_res  =  iterator_res  + 1    ;
    END;
END WHILE;

IF res IS NOT NULL THEN
    BEGIN
    SET RES_OUT  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    END;
END IF;


SET RESULT  =  RESULT || 'STATEMENT_3 output: ' || RES_OUT || ' QueryId: ' || queryId || '''
''';
EXCEPTION
WHEN ERROR THEN
-- Return a success/error indicator.

SET out_param  =  RESULT || 'Failed: ' || @@ERROR.MESSAGE;
SELECT out_param;
RETURN;
END;
SET out_param  =  CAST(AREA_CDS AS STRING);
SELECT out_param;
RETURN;
END;




