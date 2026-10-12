CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_get_stored_ctx_areas (
    IN CTX_LID FLOAT64,
    IN USED_AREA_GRP_TYPE STRING,
    IN USED_CLUSTER_TYPE STRING,
    OUT AREA_CDS STRING
)
BEGIN
    -- *******************************************************************************************************************************************
    -- Holt (bei Vorhandensein) die Country_2-Liste aus der vom Stager zum Laden freigegebenen CONTEXT-COUNTRY_2-Gruppe_2 - referenziert durch die 
    -- übergebene CONTEXT-LOAD-ID.
    -- Übersetzt die Country_2-Gruppe_2 in eine_2 Liste von AREA-Codes, welche durch die Wahl der Clusterung (Übergabeparameter) bestimmt werden.
    -- (c) Infomotion GmbH 20190606 Jens Thole
    -- ********************************************************************************************************************************************
    
    DECLARE real_cluster_type STRING;
    DECLARE cnt4locking_or_update INT64;
    DECLARE sql_stmt STRING DEFAULT '';

    SET real_cluster_type = USED_CLUSTER_TYPE;
    
    -- Sicherheitshalber wird ausgeschlossen, dass der Cluster-Type für die Level COUNTRY_2 und ALL falsch gesetzt werden kann:
    IF USED_AREA_GRP_TYPE != 'CLUSTER' THEN
        SET real_cluster_type = '-';
    END IF;

    -- Using double quotes for the outer string protects the inner single quotes from needing escapes
    SET sql_stmt = "SELECT count(*) AS cnt " ||
                   "FROM p_lew_process.t_lc_prtcl_context_tasks_2 " ||
                   "WHERE context_load_id = " || CAST(CTX_LID AS STRING) || " " ||
                   "AND stager_plan_state = 'free' " ||
                   "AND (loader_plan_state <> 'locked' OR context_area_type <> '" || USED_AREA_GRP_TYPE || "' OR cluster_type <> '" || real_cluster_type || "')";

    -- Directly fetch the scalar count into the variable
    EXECUTE IMMEDIATE sql_stmt INTO cnt4locking_or_update;

    IF cnt4locking_or_update > 0 THEN
        BEGIN
            SET sql_stmt = "UPDATE p_lew_process.t_lc_prtcl_context_tasks_2 SET loader_plan_state = 'locked', " ||
                           "context_area_type = '" || USED_AREA_GRP_TYPE || "', " ||
                           "cluster_type = '" || real_cluster_type || "', " ||
                           "updated_ts = current_timestamp() " ||
                           "WHERE context_load_id = " || CAST(CTX_LID AS STRING) || " " ||
                           "AND stager_plan_state = 'free'";

            EXECUTE IMMEDIATE sql_stmt;
        END;
    END IF;

    -- Using BigQuery's native STRING_AGG natively handles commas, removing the need for nested REPLACE functions
    SET sql_stmt = "SELECT STRING_AGG(TRIM(CAST(area_cd AS STRING)), ',' ORDER BY area_cd) AS area_cds_out " ||
                   "FROM (SELECT area_cd " ||
                   "        FROM p_lew_process.v_etl_context_orga_area_2 a " ||
                   "        JOIN p_lew_process.t_lc_prtcl_context_tasks_2 t " ||
                   "        ON a.country_cd = t.context_country_cd " ||
                   "        WHERE a.area_grp_type = t.context_area_type " ||
                   "        AND a.cluster_type = t.cluster_type " ||
                   "        AND t.loader_plan_state = 'locked' " ||
                   "        AND t.success_state in ('raw', 'reload') " ||
                   "        AND t.context_load_id = " || CAST(CTX_LID AS STRING) || " " ||
                   "        GROUP BY 1) x";

    -- Directly fetch the comma-separated string into the OUT parameter
    EXECUTE IMMEDIATE sql_stmt INTO AREA_CDS;

END;