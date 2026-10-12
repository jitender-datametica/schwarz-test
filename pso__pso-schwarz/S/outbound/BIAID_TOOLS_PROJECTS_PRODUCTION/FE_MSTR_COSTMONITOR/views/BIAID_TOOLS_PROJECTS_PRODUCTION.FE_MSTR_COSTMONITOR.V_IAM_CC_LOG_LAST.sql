CREATE OR REPLACE VIEW biaid_tools_projects_production_fe_mstr_costmonitor.v_iam_cc_log_last AS
WITH LOG AS (
  SELECT content_date,
         environment,
         load_timestamp,
         status
  FROM (
    SELECT *
    FROM biaid_tools_projects_production_etl_process.t_iam_cc_log
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY content_date, environment
      ORDER BY load_timestamp IS NULL DESC, load_timestamp DESC
    ) = 1
  ) AS t
  WHERE status = 'SUCCESS'
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY environment
    ORDER BY content_date IS NULL DESC, content_date DESC
  ) = 1
)

SELECT content_date,
       environment,
       load_timestamp
FROM LOG;