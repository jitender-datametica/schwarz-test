create or replace view BIAID_TOOLS_PROJECTS_PRODUCTION.FE_MSTR_COSTMONITOR.V_IAM_CC_LOG_LAST(
	CONTENT_DATE,
	ENVIRONMENT,
	LOAD_TIMESTAMP
) as
with log as (select
  "CONTENT_DATE",
   ENVIRONMENT,
  "LOAD_TIMESTAMP",
  "STATUS"
from "ETL_PROCESS".T_IAM_CC_LOG
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
where status = 'SUCCESS'
qualify row_number() over (
     partition by
      ENVIRONMENT
     order by "CONTENT_DATE" desc
   ) = 1;