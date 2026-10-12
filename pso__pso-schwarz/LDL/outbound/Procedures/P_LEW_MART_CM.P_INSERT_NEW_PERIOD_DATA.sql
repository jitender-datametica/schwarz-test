CREATE OR REPLACE PROCEDURE p_lew_mart_cm.p_insert_new_period_data(OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
/* Insert new periods for clients and applications. */
INSERT INTO p_lew_mart_cm.t_lil_historical_periods_per_client_and_application (client_id, per_id, application_id, active_fg, transaction_tmsp)
(SELECT TD2.client_id, TD1.per_id, TD3.application_id, 1 AS active_fg, CURRENT_TIMESTAMP() AS a4
    FROM p_lew_mart_cm.v_lil_period AS TD1
        INNER JOIN p_lew_mart_cm.v_lil_client AS TD2 ON TRUE
        INNER JOIN p_lew_mart_cm.v_lil_application AS TD3 ON TRUE
    WHERE (TD3.application_id NOT IN (1, 2, 4, 5) OR TD1.per_id NOT IN (SELECT TT1.per_id
                        FROM p_lew_mart_cm.v_lil_period AS TT1
                            INNER JOIN p_lew_mart_cm.v_lil_period_type AS TT2 ON TT1.per_tp_id = TT2.per_tp_id
                        WHERE TT2.per_tp_desc IN ('Monat', 'Quartal', 'YTD'))) AND TD1.per_id NOT IN (SELECT per_id
                FROM p_lew_mart_cm.t_lil_historical_periods_per_client_and_application)
    ORDER BY TD2.client_id NULLS LAST, TD1.per_id NULLS LAST, TD3.application_id NULLS LAST);
/* Commit transaction. */
COMMIT TRANSACTION;
/* Return the number of changed rows and the query ID. */
SET out_param  =  'Inserted ' || CAST(@@row_count AS STRING) || ' rows. Query ID: ' ; --|| CAST(LAST_QUERY_ID(-2) AS STRING);
SELECT out_param;
RETURN;
END;
