CREATE OR REPLACE FUNCTION SNOWCONVERT.PUBLIC.ROUND_DATE_UDF("INPUT" TIMESTAMP_LTZ(9), "FMT" VARCHAR(5))
RETURNS DATE
LANGUAGE SQL
AS '
CAST(
CASE 
    WHEN FMT IN (''CC'',''SCC'') THEN 
        CASE 
            WHEN RIGHT(CAST(YEAR(INPUT) as CHAR(4)),2) >=51 
                THEN DATE_FROM_PARTS(CAST(LEFT(CAST(YEAR(INPUT) as CHAR(4)),2) || ''01'' as INTEGER) +100,1,1)
            ELSE DATE_FROM_PARTS(CAST(LEFT(CAST(YEAR(INPUT) as CHAR(4)),2) || ''01'' as INTEGER),1,1)
        END    
    WHEN FMT IN (''SYYYY'',''YYYY'',''YEAR'',''SYEAR'',''YYY'',''YY'',''Y'') THEN 
        CASE WHEN MONTH(INPUT) >= 7 THEN DATE_FROM_PARTS(YEAR(INPUT)+1,1,1)
             ELSE DATE_FROM_PARTS(YEAR(INPUT),1,1)
        END
    WHEN FMT IN (''IYYY'',''IYY'',''IY'',''I'') THEN 
        CASE WHEN MONTH(INPUT) >= 7 THEN CASE DAYOFWEEK(DATE_FROM_PARTS(YEAR(INPUT),12,31))
                                                                  WHEN 0 THEN DATEADD(DAY, 1, DATE_FROM_PARTS(YEAR(INPUT),12,31))
                                                                  WHEN 1 THEN DATEADD(DAY, 0, DATE_FROM_PARTS(YEAR(INPUT),12,31))
                                                                  WHEN 2 THEN DATEADD(DAY, -1, DATE_FROM_PARTS(YEAR(INPUT),12,31))
                                                                  WHEN 3 THEN DATEADD(DAY, -2, DATE_FROM_PARTS(YEAR(INPUT),12,31))
                                                                  WHEN 4 THEN DATEADD(DAY, -3, DATE_FROM_PARTS(YEAR(INPUT),12,31))
                                                                  WHEN 5 THEN DATEADD(DAY, 3, DATE_FROM_PARTS(YEAR(INPUT),12,31))
                                                                  WHEN 6 THEN DATEADD(DAY, 2, DATE_FROM_PARTS(YEAR(INPUT),12,31))
                                                              END
             ELSE CASE DAYOFWEEK(DATE_FROM_PARTS(YEAR(INPUT),1,1))
                      WHEN 0 THEN DATEADD(DAY, 1, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                      WHEN 1 THEN DATEADD(DAY, 0, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                      WHEN 2 THEN DATEADD(DAY, -1, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                      WHEN 3 THEN DATEADD(DAY, -2, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                      WHEN 4 THEN DATEADD(DAY, -3, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                      WHEN 5 THEN DATEADD(DAY, 3, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                      WHEN 6 THEN DATEADD(DAY, 2, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                  END  
        END
    WHEN FMT IN (''MONTH'',''MON'',''MM'',''RM'') THEN 
        CASE WHEN DAYOFMONTH(INPUT) >15 THEN TIMESTAMPADD(MONTH, 1, DATE_FROM_PARTS(YEAR(INPUT),MONTH(INPUT),1))
             ELSE DATE_FROM_PARTS(YEAR(INPUT),MONTH(INPUT),1)
        END
    WHEN FMT IN (''Q'') THEN 
        CASE WHEN (MOD(MONTH(INPUT),3)=2 AND DAYOFMONTH(INPUT) >15) OR MOD(MONTH(INPUT),3)=0 
                THEN TIMESTAMPADD(MONTH, 3, DATE_FROM_PARTS(YEAR(INPUT),(QUARTER(INPUT)-1)*3+1,1)) 
             ELSE DATE_FROM_PARTS(YEAR(INPUT),(QUARTER(INPUT)-1)*3+1,1)
        END
    WHEN FMT IN (''WW'') THEN 
        CASE WHEN MOD(TIMESTAMPDIFF(DAY,DATE_FROM_PARTS(YEAR(INPUT),1,1),INPUT),7) < 4 
                THEN DATEADD(DAY, 0-MOD(TIMESTAMPDIFF(DAY,DATE_FROM_PARTS(YEAR(INPUT),1,1),INPUT),7), INPUT)
             ELSE DATEADD(DAY, 7-MOD(TIMESTAMPDIFF(DAY,DATE_FROM_PARTS(YEAR(INPUT),1,1),INPUT),7), INPUT)
        END
    WHEN FMT IN (''IW'') THEN 
        CASE WHEN MOD(TIMESTAMPDIFF(DAY,(CASE DAYOFWEEK(DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                             WHEN 0 THEN DATEADD(DAY, 1, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                             WHEN 1 THEN DATEADD(DAY, 0, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                             WHEN 2 THEN DATEADD(DAY, -1, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                             WHEN 3 THEN DATEADD(DAY, -2, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                             WHEN 4 THEN DATEADD(DAY, -3, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                             WHEN 5 THEN DATEADD(DAY, 3, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                             WHEN 6 THEN DATEADD(DAY, 2, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                         END
                   ), INPUT),7) >=4 THEN DATEADD(DAY,7-MOD(TIMESTAMPDIFF(DAY,(CASE DAYOFWEEK(DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                                                    WHEN 0 THEN DATEADD(DAY, 1, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                                                    WHEN 1 THEN DATEADD(DAY, 0, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                                                    WHEN 2 THEN DATEADD(DAY, -1, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                                                    WHEN 3 THEN DATEADD(DAY, -2, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                                                    WHEN 4 THEN DATEADD(DAY, -3, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                                                    WHEN 5 THEN DATEADD(DAY, 3, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                                                    WHEN 6 THEN DATEADD(DAY, 2, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                                                END), INPUT),7), INPUT)
             ELSE DATEADD(DAY,0-MOD(TIMESTAMPDIFF(DAY,(CASE DAYOFWEEK(DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                           WHEN 0 THEN DATEADD(DAY, 1, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                           WHEN 1 THEN DATEADD(DAY, 0, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                           WHEN 2 THEN DATEADD(DAY, -1, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                           WHEN 3 THEN DATEADD(DAY, -2, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                           WHEN 4 THEN DATEADD(DAY, -3, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                           WHEN 5 THEN DATEADD(DAY, 3, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                           WHEN 6 THEN DATEADD(DAY, 2, DATE_FROM_PARTS(YEAR(INPUT),1,1))
                                                       END), INPUT),7), INPUT)
        END
    WHEN FMT IN (''W'') THEN 
        CASE WHEN MOD(TIMESTAMPDIFF(DAY,DATE_FROM_PARTS(YEAR(INPUT),MONTH(INPUT),1),INPUT),7) < 4 
                THEN DATEADD(DAY, 0-MOD(TIMESTAMPDIFF(DAY,DATE_FROM_PARTS(YEAR(INPUT),MONTH(INPUT),1),INPUT),7), INPUT)
            ELSE DATEADD(DAY, 7-MOD(TIMESTAMPDIFF(DAY,DATE_FROM_PARTS(YEAR(INPUT),MONTH(INPUT),1),INPUT),7), INPUT)
        END
    WHEN FMT IN (''DDD'', ''DD'',''J'') THEN INPUT
    WHEN FMT IN (''DAY'', ''DY'',''D'') THEN 
        CASE WHEN DAYOFWEEK(INPUT) > 3 THEN DATEADD(DAY, 7-DAYOFWEEK(INPUT), INPUT)
             ELSE DATEADD(DAY, 0-DAYOFWEEK(INPUT), INPUT)
        END
    WHEN FMT IN (''HH'', ''HH12'',''HH24'') THEN INPUT
    WHEN FMT IN (''MI'') THEN INPUT
END AS DATE)
';