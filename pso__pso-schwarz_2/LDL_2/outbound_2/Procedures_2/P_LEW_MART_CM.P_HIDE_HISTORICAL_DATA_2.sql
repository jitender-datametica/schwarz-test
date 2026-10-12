CREATE OR REPLACE PROCEDURE p_lew_mart_cm.p_hide_historical_data(IN CLIENT_ID INT64, IN PER_ID INT64, IN APPLICATION_ID INT64, IN ACTIVE_FG INT64, OUT out_param STRING)
BEGIN
DECLARE captured_row_count INT64;
DECLARE query_id STRING(16777216);
BEGIN TRANSACTION;

/* Update the flag to either deactivate (hide) or activate (show) a period for a client and an application. */
UPDATE p_lew_mart_cm.t_lil_historical_periods_per_client_and_application_2 SET
    active_fg = ACTIVE_FG,
    transaction_tmsp = CURRENT_TIMESTAMP()
WHERE client_id = CLIENT_ID AND per_id = PER_ID AND application_id = APPLICATION_ID;

SET captured_row_count = @@row_count;
SET query_id = @@last_job_id;

/* Commit transaction. */
COMMIT TRANSACTION;
/* Return the number of changed rows and the query ID. */
SET out_param  =  'Updated ' || CAST(captured_row_count AS STRING) || ' rows. Query ID: ' || query_id;
SELECT out_param;
RETURN;
END;