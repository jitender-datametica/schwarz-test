CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_snowflake_performance_bcbid_1 
AS
SELECT
    DATE(start_time) AS date_start_time,
    EXTRACT(YEAR FROM start_time) AS year_start_time,
    EXTRACT(MONTH FROM start_time) AS monat_start_time,
    EXTRACT(WEEK FROM start_time) AS week_start_time,
    EXTRACT(DAY FROM start_time) AS day_start_time,
    FORMAT_TIMESTAMP('%A', start_time) AS dayname_start_time,
    EXTRACT(HOUR FROM start_time) AS stunde_start_time,
    EXTRACT(MINUTE FROM start_time) AS minute_start_time,
    cluster_number,
    CASE 
        WHEN query_type = 'ALTER_SESSION' THEN 'Query_Tag'
        ELSE 'Rest'
    END AS typ,
    COUNT(query_id) AS anzahl_queries,
    CAST(SUM(queued_provisioning_time) / 1000 AS NUMERIC) AS prov_time_sec,
    CAST(SUM(queued_overload_time) / 1000 AS NUMERIC) AS overload_time_sec
FROM region_1-us.INFORMATION_SCHEMA.JOBS_BY_PROJECT
WHERE warehouse_name = 'WH_LDL_P_MSTR_LEAD'
AND DATE(start_time) >= DATE_SUB(CURRENT_DATE(), INTERVAL 400 DAY)
GROUP BY
    date_start_time,
    year_start_time,
    monat_start_time,
    week_start_time,
    day_start_time,
    dayname_start_time,
    stunde_start_time,
    minute_start_time,
    cluster_number,
    typ;