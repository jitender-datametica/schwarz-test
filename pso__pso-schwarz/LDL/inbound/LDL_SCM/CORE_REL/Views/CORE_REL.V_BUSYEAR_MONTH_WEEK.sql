CREATE OR REPLACE VIEW CORE_REL.V_BUSYEAR_MONTH_WEEK AS
SELECT
     LAND
    ,BA_NR
    ,IAN
    ,BUSYEAR
    ,START_MONTH
    ,END_MONTH
    ,WI.CY_MONTH
    ,CM.CY_MONTH_SEQUENCE
    ,CY_WEEK
FROM
    CORE_REL.T_BUSYEAR_LOOKUP bl
    INNER JOIN (
        SELECT
             CY_MONTH
            ,CY_WEEK
        FROM
            (
                SELECT
                     CY_MONTH
                    ,CY_WEEK
                    ,COUNT(*) DAY_CNT_IN_WEEK
                FROM
                    CORE_REL.V_CAL_CALENDARDAY
                GROUP BY
                    CY_MONTH
                   ,CY_WEEK QUALIFY ROW_NUMBER() OVER (
                        PARTITION BY CY_WEEK
                        ORDER BY
                             CY_WEEK
                            ,DAY_CNT_IN_WEEK DESC ROWS BETWEEN UNBOUNDED PRECEDING
                            AND UNBOUNDED FOLLOWING
                    ) = 1
            )
    ) wi ON wi.CY_MONTH BETWEEN bl.START_MONTH
    AND bl.END_MONTH
    INNER JOIN CORE_REL.V_CAL_MONTH CM ON CM.CY_MONTH = wi.CY_MONTH
ORDER BY
     LAND
    ,BA_NR
    ,IAN
    ,BUSYEAR
    ,START_MONTH
    ,END_MONTH
    ,CY_MONTH
    ,CY_WEEK
	;