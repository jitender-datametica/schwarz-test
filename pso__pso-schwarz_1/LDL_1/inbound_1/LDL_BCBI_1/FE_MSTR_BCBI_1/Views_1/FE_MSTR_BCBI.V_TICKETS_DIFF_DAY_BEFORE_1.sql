CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_TICKETS_DIFF_DAY_BEFORE_1 AS 
(-- ausgehende Tickets
    SELECT 
        TICKET_ID
        ,TEAM
        ,ASSIGNED_TO_GROUP_ID
        ,ASSIGNED_TO_GROUP
        ,TOPIC
        ,STATUS_ID
        ,STATUS_DESC
        ,CREATED_ON_DATE
        ,CHANGED_ON
        ,SUBJECT
        ,TYPE_ID
        ,TYPE_DESC
        ,'Bearbeitete Tickets' AS PROGRESS
    FROM FE_MSTR_BCBI.V_TICKETS_IT4YOU_1
    WHERE UPLOAD_DATE = (
                CASE
                    WHEN DAYOFWEEK(CURRENT_DATE) = 1 THEN CURRENT_DATE -3
                    ELSE CURRENT_DATE - 1
                END
            )
      AND EXPORT_FG = 'Morgen'
    MINUS
    (
        SELECT
            t1.TICKET_ID
            ,t1.TEAM
            ,t1.ASSIGNED_TO_GROUP_ID
            ,t1.ASSIGNED_TO_GROUP
            ,t1.TOPIC
            ,t1.STATUS_ID
            ,t1.STATUS_DESC
            ,t1.CREATED_ON_DATE
            ,t1.CHANGED_ON
            ,t1.SUBJECT
            ,t1.TYPE_ID
            ,t1.TYPE_DESC
            ,'Bearbeitete Tickets' AS PROGRESS
        FROM
            (
                SELECT *
                FROM
                    FE_MSTR_BCBI.V_TICKETS_IT4YOU_1
                WHERE
                    UPLOAD_DATE = (
                        CASE
                            WHEN DAYOFWEEK(CURRENT_DATE) = 1 THEN CURRENT_DATE -3
                            ELSE CURRENT_DATE - 1
                        END
                    )
                AND EXPORT_FG = 'Morgen'
            ) AS t1_1
        INNER JOIN 
            (
                SELECT  *
                FROM
                    FE_MSTR_BCBI.V_TICKETS_IT4YOU_1
                WHERE
                    UPLOAD_DATE = CURRENT_DATE
                    AND EXPORT_FG = 'Morgen'
            ) AS t2 
            ON t1.TICKET_ID = t2.TICKET_ID
    )
)
UNION 
(-- eingehende Tickets
    SELECT
        TICKET_ID
        ,TEAM
        ,ASSIGNED_TO_GROUP_ID
        ,ASSIGNED_TO_GROUP
        ,TOPIC
        ,STATUS_ID
        ,STATUS_DESC
        ,CREATED_ON_DATE
        ,CHANGED_ON
        ,SUBJECT
        ,TYPE_ID
        ,TYPE_DESC
        ,'Eingegangene Tickets' AS PROGRESS
    FROM FE_MSTR_BCBI.V_TICKETS_IT4YOU_1
    WHERE UPLOAD_DATE = CURRENT_DATE --AND status_ = '14 Offen'
      AND EXPORT_FG = 'Morgen'
    MINUS
    (
        SELECT
            t1.TICKET_ID
            ,t1.TEAM
            ,t1.ASSIGNED_TO_GROUP_ID
            ,t1.ASSIGNED_TO_GROUP
            ,t1.TOPIC
            ,t1.STATUS_ID
            ,t1.STATUS_DESC
            ,t1.CREATED_ON_DATE
            ,t1.CHANGED_ON
            ,t1.SUBJECT
            ,t1.TYPE_ID
            ,t1.TYPE_DESC
            ,'Eingegangene Tickets' AS PROGRESS
        FROM
            (
                SELECT *
                FROM FE_MSTR_BCBI.V_TICKETS_IT4YOU_1
                WHERE UPLOAD_DATE = CURRENT_DATE
                  AND EXPORT_FG = 'Morgen'
            ) AS t1_1
        INNER JOIN 
            (
                SELECT *
                FROM FE_MSTR_BCBI.V_TICKETS_IT4YOU_1
                WHERE UPLOAD_DATE = (
                        CASE
                            WHEN DAYOFWEEK(CURRENT_DATE) = 1 THEN CURRENT_DATE - 3
                            ELSE CURRENT_DATE - 1
                        END
                        )
                AND EXPORT_FG = 'Morgen'
            ) AS t2 
            ON t1.TICKET_ID = t2.TICKET_ID
    )
);