CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_expand_ctx_add_countries(IN CTX_LID FLOAT64, IN ADD_COUNTRY_LIST STRING, OUT out_param STRING)
BEGIN
DECLARE RESULT STRING;
DECLARE RES_OUT STRING;
DECLARE sql_command STRING;
DECLARE stmt STRING;
DECLARE res STRING;
DECLARE queryId STRING;

/********************************************************************************************************************************************
Addiert zur übergebenen CONTEXT_LOAD_ID die übergebene Länderliste, so daß disjunkte CONTEXT_LOAD_ID - CONTEXT_COUNTRY - Paare entstehen
Ein möglicherweise vorab angelegter Dummysatz mit COUNTRY_1=''-'' (Dummy_1) wird bei real vorhandenen Ländern eliminiert.
Fuer die Übersetzung in CONTEXT-AREA-Codes muss der empfangene Prozess wissen, wie er die Länder gruppieren soll.
Daher benötigt er das Level der Clusterung(use_context_area_type) und die korrekte Auswahl der Clusterung selbst  (use_cluster_type)

ctx_lid:                CONTEXT_LOAD_ID für die die Länderliste angefügt werden soll
add_country_list:       Kommaseparierte Länderliste (zweistellige Pseudo-ISO Codes der LIDL--Länder)

(c) Infomotion GmbH 20190606 Jens Thole
*********************************************************************************************************************************************/

SET RESULT  =  '';
SET RES_OUT  =  '';
BEGIN

IF CTX_LID > 0 AND ADD_COUNTRY_LIST <> '' THEN
    BEGIN
    --BUILD STATEMENT_1

    SET sql_command  =  '''
    -- aufsteigend: "free" vor "locked" (= alphanumerisches max)  -- Projektion der Kontextattribute bisher auf die neue Zeile  -- es kann nur einen Prozesscontainer zu einer CLID geben  -- aufsteigend: "free" vor "locked" vor "waiting" (= alphanumerisches max)  

    MERGE INTO p_lew_process.t_lc_prtcl_context_tasks_1 AS TGT USING (SELECT ctx.context_load_id,   cntry.src_country_lidl_cd,   ctx.processcontainer,   ctx.stager_plan_state,   ctx.loader_plan_state  FROM (SELECT context_load_id,     MAX(processcontainer) AS processcontainer,     MAX(stager_plan_state) AS stager_plan_state,     MAX(loader_plan_state) AS loader_plan_state    FROM p_lew_process.t_lc_prtcl_context_tasks_1    WHERE context_load_id = @CTX_LID    GROUP BY context_load_id) AS ctx   INNER JOIN (SELECT C.src_country_lidl_cd    FROM p_lew_core_ac.v_client_1 AS C     INNER JOIN (SELECT "," || @ADD_COUNTRY_LIST || "," AS countrylist) AS cl ON cl.countrylist LIKE "%," || C.src_country_lidl_cd         || ",%") AS cntry ON TRUE) AS src ON TGT.context_load_id = src.context_load_id AND TGT.context_country_cd = src.src_country_lidl_cd WHEN MATCHED THEN UPDATE SET  updated_ts = CURRENT_TIMESTAMP() WHEN NOT MATCHED THEN INSERT VALUES(src.context_load_id, src.src_country_lidl_cd, src.processcontainer  , src.stager_plan_state, src.loader_plan_state , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()) ''';
    --RUN STATEMENT_1

    SET stmt  =  sql_command;

    EXECUTE IMMEDIATE (stmt)
    INTO res  USING CTX_LID AS CTX_LID;

    IF res IS NOT NULL THEN
        BEGIN
        SET RES_OUT  =  res;
        END;
    END IF;

    SET queryId  =  @@current_job_id;
    SET RESULT  =  RESULT || 'STATEMENT_1 output: ' || RES_OUT || ' QueryId: ' || queryId || '''
''';
    --BUILD STATEMENT_2

    SET sql_command  =  '''DELETE FROM p_lew_process.t_lc_prtcl_context_tasks_1 WHERE context_load_id = @CTX_LID AND context_country_cd = "-" ''';
    --RUN STATEMENT_2

    SET stmt  =  sql_command;

    EXECUTE IMMEDIATE (stmt)
    INTO res  USING CTX_LID AS CTX_LID;
    SET queryId  =  @@current_job_id;
    IF res IS NOT NULL THEN
        BEGIN
        SET RES_OUT  =  CAST(@@row_count AS STRING);
        END;
    END IF;

    
    SET RESULT  =  RESULT || 'STATEMENT_2 output: ' || RES_OUT || ' QueryId: ' || queryId || '''
''';
    END;
END IF;

EXCEPTION
WHEN ERROR THEN
-- Return a success/error indicator.

SET out_param  =  RESULT || 'Failed: ' || @@ERROR.MESSAGE;
SELECT out_param;
RETURN;
END;
SET out_param  =  'Success';
SELECT out_param;
RETURN;
END;






