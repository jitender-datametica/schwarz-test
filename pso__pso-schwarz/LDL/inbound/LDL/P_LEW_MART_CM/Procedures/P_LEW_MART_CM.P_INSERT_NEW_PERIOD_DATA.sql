CREATE OR REPLACE PROCEDURE P_LEW_MART_CM.P_INSERT_NEW_PERIOD_DATA()
RETURNS VARCHAR(100)
LANGUAGE SQL
EXECUTE AS CALLER
AS 
$$
BEGIN
    BEGIN TRANSACTION;
        /* Insert new periods for clients and applications. */
        INSERT INTO P_LEW_MART_CM.T_LIL_HISTORICAL_PERIODS_PER_CLIENT_AND_APPLICATION(CLIENT_ID, PER_ID, APPLICATION_ID, ACTIVE_FG, TRANSACTION_TMSP)
		    SELECT 
                    TD2.CLIENT_ID
                    , TD1.PER_ID
                    , TD3.APPLICATION_ID
                    , 1 AS ACTIVE_FG
                    , CURRENT_TIMESTAMP()
            FROM P_LEW_MART_CM.V_LIL_PERIOD TD1
            CROSS JOIN P_LEW_MART_CM.V_LIL_CLIENT TD2
            CROSS JOIN P_LEW_MART_CM.V_LIL_APPLICATION TD3
            WHERE TD1.PER_ID NOT IN (SELECT PER_ID FROM P_LEW_MART_CM.T_LIL_HISTORICAL_PERIODS_PER_CLIENT_AND_APPLICATION)
            AND NOT (APPLICATION_ID IN (1,2,4,5) AND PER_ID IN (SELECT PER_ID 
                                                                FROM P_LEW_MART_CM.V_LIL_PERIOD TT1 JOIN P_LEW_MART_CM.V_LIL_PERIOD_TYPE TT2 
                                                                ON TT1.PER_TP_ID = TT2.PER_TP_ID WHERE PER_TP_DESC IN ('Monat', 'Quartal','YTD')
                                                                )
                    )
            ORDER BY 
                        TD2.CLIENT_ID
                        , TD1.PER_ID 
                        , TD3.APPLICATION_ID;
    /* Commit transaction. */
    COMMIT;
    /* Return the number of changed rows and the query ID. */
	RETURN 'Inserted '  || SQLROWCOUNT || ' rows. Query ID: '||LAST_QUERY_ID(-2);
END;
$$
;