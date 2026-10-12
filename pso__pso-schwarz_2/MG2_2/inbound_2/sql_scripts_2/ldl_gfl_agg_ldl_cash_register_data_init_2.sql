/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_data_init.sql
#----------------------------------------------------------------------------
# History:
# 1.0  07.11.2024  Andrzej Wandtke  - ZKP - intial version
# 1.1  30.12.2024  Kamil Roszczyk   - ZKP - enhancements: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/61727
#									Change log:
#										- adding store_selected_fg attribute to ETL.T_STORES_QUALIFIED_2 table to determine which stores were ordered explicitly and which were ordered using the parent sales_2 company
#											(this is for the purpose of qualifying the stores' data for ranking logic in ldl_cash_register_event_classification_man.sql script)
# 1.2  15.04.2025  Andrzej Wandtke  - ZKP - 60163 - schedule on daily base: 
#                                     PRD:
#                                       Companies: As before - the materialization takes place only on Sundays, independent from the day the GES was requested.
#                                       Stores:  Materialization takes place right after the materialization was requested, can be any day
#                                     Other environments: no restrictions
#
# 1.3  25.04.2025  Andrzej Wandtke  - ZKP - 69046 - Exclude Stores from Luxemburg - they belong technically do Belgium, but are based in Luxembourg
                                        They need to be excluded from order by company and sibling stores
#                                       Store selection: exclusion is done in front end
*/

!SET exit_on_error=True;
SET SV_MODE = (SELECT DECODE(UPPER(DAYNAME(CURRENT_DATE)), 'SUN', 'WEEKLY', 'DAILY'));
SET SV_ENVIRONMENT = (
 SELECT PARAM_VAL_TXT
 FROM   CORE_APP_FRAUD_DETECTION.T_ENVIRONMENT_CONFIG_2
 WHERE  PARAM_NAME = 'ENVIRONMENT');


-- Table with stores selected for current process and their siblings
CREATE OR REPLACE TRANSIENT TABLE ETL.T_STORES_QUALIFIED_2
DATA_RETENTION_TIME_IN_DAYS = 0
(
	STORE_SID
    ,BUS_DT
	
	,SALES_COMPANY_SID
	,COUNTRY_ORG_CD
	,STORE_SELECTED_FG
	,IS_DIRECTLY_ORDERED
)
AS
with 
directly_ordered_stores as
(
	-- If a company is ordered we get a set with all child stores and days for the ordered period
	SELECT
		io_st.INT_ORG_SID    		as STORE_SID
		,cd.CAL_DT
		,io_st.SALES_COMPANY_SID
		,io_st.COUNTRY_ORG_CD
		,0 AS STORE_SELECTED_FG		--company is ordered so the store_selected_fg = 0
	
	FROM core_app_fraud_detection.T_FRAUD_DETECTION_ORDER_2 oc
		join core_dim.T_DIM_INTERNAL_ORGANIZATION_2 io_st
			on oc.INT_ORG_SID = io_st.SALES_COMPANY_SID
		join core_dim.T_DIM_CALENDAR_DATE_2 cd
			on cd.CAL_DT >= oc.ANALYSIS_PERIOD_START_DT
			and cd.CAL_DT <= oc.ANALYSIS_PERIOD_END_DT
	WHERE 1=1
		and oc.INT_ORG_TYPE_CD = 'COMPANY'
		and oc.ORDER_PARAMETER_STATUS_CD = 'AP'
		and ($SV_MODE = 'WEEKLY' OR $SV_ENVIRONMENT <> 'PROD') -- materialize companies only in the weekly mode on prod or on any day on any environment other then prod

		and io_st.DWH_VALID_FG = TRUE
		and io_st.INT_ORG_TYPE_CD = 'STORE'
		and UPPER(SUBSTR(io_st.CURR_INT_ORG_NR,1,2)) <> 'LU'

	UNION ALL	--UNION ALL as we have the store_selected_fg so no point in aggregating this set 
				--we want to do the aggregation and keep the flag set to 1 for stores selected both explicitly and by sales_2 company selection but this will be made in the next steps

	--If a store is ordered we get 1 row for each day withing the ordered period for this store
	SELECT
		io_st.INT_ORG_SID        			as STORE_SID
		,cd.CAL_DT
		,io_st.SALES_COMPANY_SID
		,io_st.COUNTRY_ORG_CD
		,1 AS STORE_SELECTED_FG		--store is ordered so the store_selected_fg = 1
		
	FROM core_app_fraud_detection.T_FRAUD_DETECTION_ORDER_2 os -- ordered stores
		join core_dim.T_DIM_INTERNAL_ORGANIZATION_2 io_st
			ON os.INT_ORG_SID = io_st.INT_ORG_SID
		join core_dim.T_DIM_CALENDAR_DATE_2 cd
			on cd.CAL_DT >= os.ANALYSIS_PERIOD_START_DT
			and cd.CAL_DT <= os.ANALYSIS_PERIOD_END_DT
	WHERE 1=1
		and os.INT_ORG_TYPE_CD = 'STORE'
		and os.ORDER_PARAMETER_STATUS_CD = 'AP'	
		
		and io_st.DWH_VALID_FG = TRUE
		and io_st.INT_ORG_TYPE_CD = 'STORE'
)
, directly_ordered_store_parents as
(
	SELECT DISTINCT
		SALES_COMPANY_SID
		,CAL_DT
	FROM directly_ordered_stores

)
, directly_ordered_stores_agg as
(
	SELECT
		STORE_SID
		,CAL_DT
		,ANY_VALUE(SALES_COMPANY_SID)	AS SALES_COMPANY_SID
		,ANY_VALUE(COUNTRY_ORG_CD)		AS COUNTRY_ORG_CD
		,MAX(STORE_SELECTED_FG)			AS STORE_SELECTED_FG	--if the store is selected both explicitly (1) and by sales_2 company (0) the explicit store selection takes priority
	FROM directly_ordered_stores
	GROUP BY
		STORE_SID
		,CAL_DT
)
SELECT 
	dos.STORE_SID
	,dos.CAL_DT
	,dos.SALES_COMPANY_SID
	,dos.COUNTRY_ORG_CD
	,dos.STORE_SELECTED_FG
	,1 							as IS_DIRECTLY_ORDERED
	
FROM directly_ordered_stores_agg dos
GROUP BY
	dos.STORE_SID
	, dos.CAL_DT
	, dos.COUNTRY_ORG_CD
	, dos.SALES_COMPANY_SID
	, dos.STORE_SELECTED_FG

UNION ALL

-- "sibling stores" - All stores for which there is no order, but they belong to company that is a parent of an ordered store
SELECT
	io_sst.INT_ORG_SID			as STORE_SID
	,dos_p.CAL_DT
	,io_sst.SALES_COMPANY_SID
	,io_sst.COUNTRY_ORG_CD
	,0							as STORE_SELECTED_FG
	,0 							as IS_DIRECTLY_ORDERED
	
FROM directly_ordered_store_parents dos_p
	join core_dim.T_DIM_INTERNAL_ORGANIZATION_2 io_sst -- sibling store (same parent)
			on io_sst.SALES_COMPANY_SID = dos_p.SALES_COMPANY_SID
			and io_sst.INT_ORG_TYPE_CD = 'STORE'
			and io_sst.DWH_VALID_FG = TRUE
			and UPPER(SUBSTR(io_sst.REPORTING_COUNTRY_CD,1,2)) <> 'LU'
WHERE 1=1
	-- sibling store is NOT directly ordered on a given day
	and not EXISTS
	(
		SELECT 1
		FROM directly_ordered_stores_agg dos
		WHERE 1=1
			and dos.STORE_SID = io_sst.INT_ORG_SID
			and dos.CAL_DT = dos_p.CAL_DT
	)
;

-- Set status_2 as LO (loading) for requested and approved stores
UPDATE core_app_fraud_detection.t_fraud_detection_order_2
SET    order_parameter_status_cd = 'LO'
,      dwh_updated_tmsp          = current_timestamp()
WHERE  order_parameter_status_cd ilike 'AP'
AND    (  $SV_MODE = 'WEEKLY'
       OR $SV_ENVIRONMENT <> 'PROD'
       OR ($SV_MODE = 'DAILY' AND INT_ORG_TYPE_CD = 'STORE'))
;
