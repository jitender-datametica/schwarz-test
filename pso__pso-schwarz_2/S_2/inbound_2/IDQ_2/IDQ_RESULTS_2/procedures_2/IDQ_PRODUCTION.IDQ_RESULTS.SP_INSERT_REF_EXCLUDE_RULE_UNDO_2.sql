CREATE OR REPLACE PROCEDURE IDQ_PRODUCTION.IDQ_RESULTS.SP_INSERT_REF_EXCLUDE_RULE_UNDO("EXCLUDE_ID" NUMBER(38,0), "INSERTED_BY" VARCHAR(200), "EXCLUDE_REASON" VARCHAR(1000), "EXCLUDE_FLAG" NUMBER(38,0))
RETURNS NUMBER(38,0)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'BEGIN
    let COUNT_INSERT := 0;
    let excluded INTEGER := NULL;
           -- @TEST_OBJECT_ID for the moment is a Dummy_2 value not used
        -- Stop process when Exclude Flag is not 1.

    -- get the excluded value
    SELECT top 1 EXCLUDE_FLAG INTO :excluded 
    FROM IDQ_RESULTS.REF_EXCLUDE_2
    WHERE ID = :EXCLUDE_ID;

    -- Already there and excluded, set EXCLUDE_FLAG = 0
    IF (excluded = 1 and :EXCLUDE_FLAG = 0) THEN
        UPDATE IDQ_RESULTS.REF_EXCLUDE_2
        SET EXCLUDE_FLAG = :EXCLUDE_FLAG,
            EXCLUDE_REASON = :EXCLUDE_REASON,
            INSERTED_BY = :INSERTED_BY,
            UNDONE_AT = SYSDATE()
                WHERE ID = :EXCLUDE_ID;
    END IF;

    -- Update - there, but exclude flag = 0
     IF (excluded = 0 and :EXCLUDE_FLAG = 1) THEN
        UPDATE IDQ_RESULTS.REF_EXCLUDE_2
        SET EXCLUDE_FLAG = 1,
            INSERTED_AT = SYSDATE(),
            EXCLUDE_REASON = :EXCLUDE_REASON,
            INSERTED_BY = :INSERTED_BY,
            UNDONE_AT = NULL
                WHERE ID = :EXCLUDE_ID;
    END IF;
        commit;
END';