CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.SECONDS2INTERVAL_UDF("INPUT_PART" VARCHAR(30), "INPUT_VALUE" NUMBER(38,0))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS '
DECODE(INPUT_PART,
                ''DAY'',                TRUNC((INPUT_VALUE/(86400)))::varchar,
                ''DAY TO HOUR'',        TRUNC(INPUT_VALUE/(86400))::varchar || '' '' || 
                                            CASE WHEN ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) = 0 THEN ''00'' WHEN ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) > -10 AND ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) < 10 THEN ''0'' ELSE '''' END || ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600))::varchar,
                ''DAY TO MINUTE'',      TRUNC(INPUT_VALUE/(86400))::varchar || '' '' || 
                                            CASE WHEN ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) = 0 THEN ''00'' WHEN ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) > -10 AND ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) < 10 THEN ''0'' ELSE '''' END || ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600))::varchar || '':'' || 
                                                CASE WHEN ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) = 0 THEN ''00'' WHEN ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) > -10 AND ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) < 10 THEN ''0'' ELSE '''' END || ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60))::varchar,
                ''DAY TO SECOND'',      TRUNC(INPUT_VALUE/(86400))::varchar || '' '' || 
                                            CASE WHEN ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) = 0 THEN ''00'' WHEN ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) > -10 AND ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600)) < 10 THEN ''0'' ELSE '''' END || ABS(TRUNC(MOD(INPUT_VALUE,86400)/3600))::varchar || '':'' || 
                                                CASE WHEN ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) = 0 THEN ''00'' WHEN ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) > -10 AND ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) < 10 THEN ''0'' ELSE '''' END || ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60))::varchar,
                                                    CASE WHEN ABS(MOD(INPUT_VALUE, 60)) = 0 THEN ''00'' WHEN ABS(MOD(INPUT_VALUE, 60)) > -10 AND ABS(MOD(INPUT_VALUE, 60)) < 10 THEN ''0'' ELSE '''' END || ABS(MOD(INPUT_VALUE, 60))::varchar,
                ''HOUR'',               TRUNC((INPUT_VALUE/3600))::varchar,     
                ''HOUR TO MINUTE'',     TRUNC(INPUT_VALUE/3600)::varchar || '':'' || 
                                            CASE WHEN ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) = 0 THEN ''00'' WHEN ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) > -10 AND ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) < 10 THEN ''0'' ELSE '''' END || ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60))::varchar,
                ''HOUR TO SECOND'',     TRUNC(INPUT_VALUE/3600)::varchar || '':'' || 
                                            CASE WHEN ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) = 0 THEN ''00'' WHEN ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) > -10 AND ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60)) < 10 THEN ''0'' ELSE '''' END || ABS(TRUNC(MOD(INPUT_VALUE, 3600)/60))::varchar,
                                                CASE WHEN ABS(MOD(INPUT_VALUE, 60)) = 0 THEN ''00'' WHEN ABS(MOD(INPUT_VALUE, 60)) > -10 AND ABS(MOD(INPUT_VALUE, 60)) < 10 THEN ''0'' ELSE '''' END || ABS(MOD(INPUT_VALUE, 60))::varchar,
                ''MINUTE'',             TRUNC((INPUT_VALUE/60))::varchar,                
                ''MINUTE TO SECOND'',   TRUNC(INPUT_VALUE/60)::varchar || '':'' || 
                                            CASE WHEN ABS(MOD(INPUT_VALUE, 60)) = 0 THEN ''00'' WHEN ABS(MOD(INPUT_VALUE, 60)) > -10 AND ABS(MOD(INPUT_VALUE, 60)) < 10 THEN ''0'' ELSE '''' END || ABS(MOD(INPUT_VALUE, 60))::varchar,
                ''SECOND'',             INPUT_VALUE::varchar
)
';