CREATE OR REPLACE VIEW FE_MSTR_SCM.V_ARTIKEL_YEAR_MONTH_WEEK(
	 BA_NR
	,BUSYEAR
	,CAL_MONTH
	,CAL_WEEK
	,MONTH_SEQ
) AS
(SELECT DISTINCT B.BA_NR 
            ,(MON.BUSYEAR)
            ,MON.CY_MONTH
            ,MON.CY_WEEK
            ,MON.CY_MONTH_SEQUENCE
         
        FROM 
            CORE_REL.V_BUSYEAR_MONTH_WEEK AS MON
        JOIN 
            (
                SELECT 
                 BA_NR
                    ,BUSYEAR 
                    ,MIN(START_MONTH) AS SM 
                    ,MAX(END_MONTH) AS EM              
                   ,CY_MONTH_SEQUENCE
                    
            FROM 
                    CORE_REL.V_BUSYEAR_MONTH_WEEK
                    
                GROUP BY 
                    CY_MONTH_SEQUENCE,BA_NR,BUSYEAR) AS B ON (MON.BUSYEAR=B.BUSYEAR) AND (MON.CY_MONTH BETWEEN B.SM AND B.EM))
                    
                    
                    
;