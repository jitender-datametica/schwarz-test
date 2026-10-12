CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_TICKETS_IT4YOU_2 AS 
SELECT DISTINCT
    FE_MSTR_BCBI.V_TICKETS_DAILY.upload_date AS upload_date_ts
    ,TO_DATE(FE_MSTR_BCBI.V_TICKETS_DAILY.upload_date) AS upload_date
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.id AS Ticket_id
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.Priority
    ,FE_MSTR_BCBI.T_TICKETS_STATUS.ID AS Status_id
    ,FE_MSTR_BCBI.T_TICKETS_STATUS.Status_desc
    ,FE_MSTR_BCBI.t_tickets_it4you_groups.id AS assigned_to_group_id 
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.assigned_to_group
    ,FE_MSTR_BCBI.t_tickets_it4you_groups.team
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.subject
    ,FE_MSTR_BCBI.T_TICKETS_TYPE.ID AS TYPE_ID
    ,FE_MSTR_BCBI.T_TICKETS_TYPE.TYPE_DESC
    ,Country.client_id
    ,Country.country_name
    ,Country.country_cluster_id
    ,Country.country_cluster_name
    ,Country.country_flag_img
    ,Country.country_flag_img_name
    ,Topics.topic
    ,Topics.category
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.assignment_group_history
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.solution
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.ci
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.created_on AS created_on_ts
    ,TO_DATE(FE_MSTR_BCBI.V_TICKETS_DAILY.created_on) AS created_on_date
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.changed_on
    ,CASE 
        WHEN Time(FE_MSTR_BCBI.V_TICKETS_DAILY.upload_date) < '13:30:00.000' THEN 'Morgen'
        ELSE 'Mittag'
    END AS Export_FG
    ,FE_MSTR_BCBI.T_DIM_CAL_DAY.CY AS YEAR
    ,FE_MSTR_BCBI.T_DIM_CAL_DAY.BUS_YEAR
    ,FE_MSTR_BCBI.T_DIM_CAL_DAY.CY_MONTH AS year_month_id
    ,FE_MSTR_BCBI.T_DIM_CAL_DAY.MONTH_OF_YEAR AS month_nr
    ,FE_MSTR_BCBI.T_DIM_CAL_DAY.MONTH_OF_YEAR_NAME AS month_name
    ,FE_MSTR_BCBI.T_DIM_CAL_DAY.WEEK_OF_YEAR AS week_nr
    ,FE_MSTR_BCBI.T_DIM_CAL_WEEK.CY_WEEK_SHORT_NAME AS kw_week_nr
    ,FE_MSTR_BCBI.T_DIM_CAL_DAY.CY_WEEK AS year_week_id
    ,FE_MSTR_BCBI.T_DIM_CAL_WEEK.CY_WEEK_NAME AS year_kw_nr
    ,DATEDIFF(
        DAY
        ,created_on_date
        ,V_TICKETS_DAILY.upload_date
    ) AS delta_created
    ,DATEDIFF(
        DAY
        ,FE_MSTR_BCBI.V_TICKETS_DAILY.changed_on
        ,V_TICKETS_DAILY.upload_date
    ) AS delta_changed
    ,REGEXP_COUNT(
        FE_MSTR_BCBI.V_TICKETS_DAILY.assignment_group_history
        ,','
        ,1
    ) + 1 AS Amount_groups_in
--    ,split_part(FE_MSTR_BCBI.V_TICKETS_DAILY.subject, '_',  2) AS Prio
--    ,split_part(FE_MSTR_BCBI.V_TICKETS_DAILY.subject, '_',  3) AS Laender
--    ,split_part(FE_MSTR_BCBI.V_TICKETS_DAILY.subject, '_',  4) AS Problem_Status
--    ,split_part(FE_MSTR_BCBI.V_TICKETS_DAILY.subject, '_',  5) AS Children
    ,FE_MSTR_BCBI.V_TICKETS_DAILY.opened_by_group
    ,ABS(datediff(DAY, V_TICKETS_DAILY.upload_date, created_on_date)) AS days_since_creation
    ,FLOOR(days_since_creation / 7) AS weeks_since_creation
    ,FLOOR(days_since_creation / 30) AS months_since_creation
    ,CASE
        WHEN days_since_creation >= 84 THEN 85
        WHEN days_since_creation >= 56
        AND days_since_creation < 84 THEN 84
        WHEN days_since_creation >= 28
        AND days_since_creation < 56 THEN 56
        WHEN days_since_creation >= 14
        AND days_since_creation < 28 THEN 28
        WHEN days_since_creation >= 7
        AND days_since_creation < 14 THEN 14
        WHEN days_since_creation < 7 THEN 7
    END AS age_tickets_id
    ,CASE
        WHEN days_since_creation >= 84 THEN ' >=12 Wochen'
        WHEN days_since_creation >= 56
        AND days_since_creation < 84 THEN '8-12 Wochen'
        WHEN days_since_creation >= 28
        AND days_since_creation < 56 THEN '4-8 Wochen'
        WHEN days_since_creation >= 14
        AND days_since_creation < 28 THEN '2-4 Wochen'
        WHEN days_since_creation >= 7
        AND days_since_creation < 14 THEN '1-2 Wochen'
        WHEN days_since_creation < 7 THEN '1-7 Tage'
    END AS age_tickets_week
FROM
    FE_MSTR_BCBI.V_TICKETS_DAILY_2
    INNER JOIN FE_MSTR_BCBI.T_DIM_CAL_DAY_2 
        ON TO_DATE(V_TICKETS_DAILY.upload_date) = T_DIM_CAL_DAY.cal_dt
    INNER JOIN FE_MSTR_BCBI.T_DIM_CAL_WEEK_2 
        ON T_DIM_CAL_DAY.cy_week = T_DIM_CAL_WEEK.cy_week
    INNER JOIN FE_MSTR_BCBI.T_TICKETS_STATUS_2 
        ON V_TICKETS_DAILY.status_ = T_TICKETS_STATUS.status_desc
    INNER JOIN FE_MSTR_BCBI.T_TICKETS_TYPE_2 
        ON V_TICKETS_DAILY.TYPE = T_TICKETS_TYPE.type_desc
    INNER JOIN FE_MSTR_BCBI.t_tickets_it4you_groups_2 
        ON V_TICKETS_DAILY.assigned_to_group = t_tickets_it4you_groups.gruppe_2
    LEFT JOIN FE_MSTR_BCBI.V_TICKETS_COUNTRY_ALL_2 AS Country_2 
        ON V_TICKETS_DAILY.COUNTRY_TICKET_ID = Country.COUNTRY_TICKET_ID 
        AND V_TICKETS_DAILY.opened_by_group = Country.opened_by_group 
    INNER JOIN FE_MSTR_BCBI.V_TICKETS_TOPICS_2 AS Topics 
        ON V_TICKETS_DAILY.ID = Topics.id 
        AND V_TICKETS_DAILY.upload_date = topics.upload_date;