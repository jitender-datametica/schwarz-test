CREATE OR REPLACE FUNCTION LDL_PRODUCTION.P_LEW_MART_PIT.F_QUERYTAG(""P_QUERYLOG"" VARCHAR(16777216), ""P_APPLICATIONNAME"" VARCHAR(16777216), ""P_RUNCLUSTERINGDESC"" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS '
        SELECT
            SUBSTRING(COALESCE(a.queryLog,''N/A - Error''),1,250) 
        FROM
        (
            SELECT
                                        ''<LOGGING ''
                                        || ''CLUSTER=""'' || COALESCE(SUBSTRING(P_RUNCLUSTERINGDESC,1,25),''[0]'') || ''"" ''   
                                        || ''APP=""'' || COALESCE(SUBSTRING(P_APPLICATIONNAME,1,25),''N/A'') || ''"" ''                         
                                        || ''SESSION=""'' || CURRENT_SESSION() || ''"" ''                                                                                 
                                        || ''ROLE=""'' || CURRENT_ROLE() || ''"" ''                                           
                                        || ''DB=""'' || CURRENT_DATABASE() || ''"" ''                                     
                                        || ''USER=""'' || CURRENT_USER() || ''"" ''   
                                        || ''WH=""'' || CURRENT_WAREHOUSE() || ''"" ''                                                                                
                                        || ''CLIENT=""'' || CURRENT_CLIENT() || ''"">''
                                        || COALESCE(SUBSTRING(P_QUERYLOG,1,30),''N/A'')
                                        || ''</LOGGING>''
            AS queryLog 
        ) a
        GROUP BY 1
    ';