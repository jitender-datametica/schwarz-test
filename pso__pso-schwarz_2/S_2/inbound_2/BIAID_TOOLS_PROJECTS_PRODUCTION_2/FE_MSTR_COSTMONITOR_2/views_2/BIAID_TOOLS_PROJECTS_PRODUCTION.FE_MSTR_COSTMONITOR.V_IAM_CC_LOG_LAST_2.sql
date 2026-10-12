create or replace view BIAID_TOOLS_PROJECTS_PRODUCTION.FE_MSTR_COSTMONITOR.V_IAM_CC_LOG_LAST_2(
	CONTENT_DATE,
	ENVIRONMENT,
	LOAD_TIMESTAMP
) as
with log as (select
  "CONTENT_DATE",
   ENVIRONMENT,
  "LOAD_TIMESTAMP",
  "STATUS_2"
from "ETL_PROCESS".T_IAM_CC_LOG_2
qualify row_number() over (
     partition by
      "CONTENT_DATE",
       ENVIRONMENT
     order by "LOAD_TIMESTAMP" desc
   ) = 1
)
select
  "CONTENT_DATE",
   ENVIRONMENT,
  "LOAD_TIMESTAMP"
from log
where status_2 = 'SUCCESS'
qualify row_number() over (
     partition by
      ENVIRONMENT
     order by "CONTENT_DATE" desc
   ) = 1;