/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_data_init.sql
#----------------------------------------------------------------------------
# History:
# 1.0  07.11.2024  Andrzej Wandtke  - ZKP - intial version
# 1.1  30.12.2024  Kamil Roszczyk   - ZKP - enhancements: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/61727
#									Change log:
#										- adding store_selected_fg attribute to ETL.T_STORES_QUALIFIED table to determine which stores were ordered explicitly and which were ordered using the parent sales company
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
-- !SET exit_on_error=True;
DECLARE SV_MODE STRING;
DECLARE SV_ENVIRONMENT ERROR_TYPE(Error<error-type>);
SET SV_MODE = (
  SELECT
      CASE
         upper(format_date('%a', current_date()))
        WHEN 'SUN' THEN 'WEEKLY'
        ELSE 'DAILY'
      END
);
SET SV_ENVIRONMENT = (
  SELECT
      T_ENVIRONMENT_CONFIG.PARAM_VAL_TXT
    FROM
      LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_ENVIRONMENT_CONFIG
    WHERE T_ENVIRONMENT_CONFIG.PARAM_NAME = 'ENVIRONMENT'
);
-- Table with stores selected for current process and their siblings
CREATE OR REPLACE TABLE ETL.T_STORES_QUALIFIED
  (
    STORE_SID ERROR_TYPE(Error<error-type>),
    BUS_DT ERROR_TYPE(Error<error-type>),
    SALES_COMPANY_SID BIGNUMERIC,
    COUNTRY_ORG_CD BIGNUMERIC,
    STORE_SELECTED_FG BIGNUMERIC,
    IS_DIRECTLY_ORDERED NUMERIC(29)
  )
  AS
    WITH DIRECTLY_ORDERED_STORES AS (
      SELECT
          -- If a company is ordered we get a set with all child stores and days for the ordered period
          IO_ST.INT_ORG_SID AS STORE_SID,
          CD.CAL_DT,
          IO_ST.SALES_COMPANY_SID,
          IO_ST.COUNTRY_ORG_CD,
          NUMERIC '0' /*company is ordered so the store_selected_fg = 0*/ AS STORE_SELECTED_FG
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER AS OC
          INNER JOIN LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_INTERNAL_ORGANIZATION AS IO_ST ON OC.INT_ORG_SID = IO_ST.SALES_COMPANY_SID
          INNER JOIN LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_CALENDAR_DATE AS CD ON CD.CAL_DT >= OC.ANALYSIS_PERIOD_START_DT
           AND CD.CAL_DT <= OC.ANALYSIS_PERIOD_END_DT
        WHERE NUMERIC '1' = NUMERIC '1'
         AND OC.INT_ORG_TYPE_CD = 'COMPANY'
         AND OC.ORDER_PARAMETER_STATUS_CD = 'AP'
         AND (SV_MODE = 'WEEKLY'
         OR SV_ENVIRONMENT <> 'PROD') /* materialize companies only in the weekly mode on prod or on any day on any environment other then prod*/
         AND IO_ST.DWH_VALID_FG = true
         AND IO_ST.INT_ORG_TYPE_CD = 'STORE'
         AND upper(substr(IO_ST.CURR_INT_ORG_NR, 1, 2)) <> 'LU'
      UNION ALL
      SELECT
          -- UNION ALL as we have the store_selected_fg so no point in aggregating this set
          -- we want to do the aggregation and keep the flag set to 1 for stores selected both explicitly and by sales company selection but this will be made in the next steps
          -- If a store is ordered we get 1 row for each day withing the ordered period for this store
          IO_ST.INT_ORG_SID AS STORE_SID,
          CD.CAL_DT,
          IO_ST.SALES_COMPANY_SID,
          IO_ST.COUNTRY_ORG_CD,
          NUMERIC '1' /*store is ordered so the store_selected_fg = 1*/ AS STORE_SELECTED_FG
        FROM
          LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER AS OS /* ordered stores*/
          INNER JOIN LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_INTERNAL_ORGANIZATION AS IO_ST ON OS.INT_ORG_SID = IO_ST.INT_ORG_SID
          INNER JOIN LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_CALENDAR_DATE AS CD ON CD.CAL_DT >= OS.ANALYSIS_PERIOD_START_DT
           AND CD.CAL_DT <= OS.ANALYSIS_PERIOD_END_DT
        WHERE NUMERIC '1' = NUMERIC '1'
         AND OS.INT_ORG_TYPE_CD = 'STORE'
         AND OS.ORDER_PARAMETER_STATUS_CD = 'AP'
         AND IO_ST.DWH_VALID_FG = true
         AND IO_ST.INT_ORG_TYPE_CD = 'STORE'
    ), DIRECTLY_ORDERED_STORES_AGG AS (
      SELECT
          DIRECTLY_ORDERED_STORES.STORE_SID,
          DIRECTLY_ORDERED_STORES.CAL_DT,
          any_value(DIRECTLY_ORDERED_STORES.SALES_COMPANY_SID) AS SALES_COMPANY_SID,
          any_value(DIRECTLY_ORDERED_STORES.COUNTRY_ORG_CD) AS COUNTRY_ORG_CD,
          max(DIRECTLY_ORDERED_STORES.STORE_SELECTED_FG) /*if the store is selected both explicitly (1) and by sales company (0) the explicit store selection takes priority*/ AS STORE_SELECTED_FG
        FROM
          DIRECTLY_ORDERED_STORES
        GROUP BY 1, 2
    ), DIRECTLY_ORDERED_STORE_PARENTS AS (
      SELECT DISTINCT
          DIRECTLY_ORDERED_STORES.SALES_COMPANY_SID,
          DIRECTLY_ORDERED_STORES.CAL_DT
        FROM
          DIRECTLY_ORDERED_STORES
    )
    SELECT
        DOS.STORE_SID,
        DOS.CAL_DT AS BUS_DT,
        DOS.SALES_COMPANY_SID,
        DOS.COUNTRY_ORG_CD,
        DOS.STORE_SELECTED_FG,
        NUMERIC '1' AS IS_DIRECTLY_ORDERED
      FROM
        DIRECTLY_ORDERED_STORES_AGG AS DOS
      GROUP BY 1, 2, 4, 3, 5
    UNION ALL
    SELECT
        -- "sibling stores" - All stores for which there is no order, but they belong to company that is a parent of an ordered store
        IO_SST.INT_ORG_SID AS STORE_SID,
        DOS_P.CAL_DT AS BUS_DT,
        IO_SST.SALES_COMPANY_SID,
        IO_SST.COUNTRY_ORG_CD,
        NUMERIC '0' AS STORE_SELECTED_FG,
        NUMERIC '0' AS IS_DIRECTLY_ORDERED
      FROM
        DIRECTLY_ORDERED_STORE_PARENTS AS DOS_P
        INNER JOIN LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_INTERNAL_ORGANIZATION AS IO_SST /* sibling store (same parent)*/ ON IO_SST.SALES_COMPANY_SID = DOS_P.SALES_COMPANY_SID
         AND IO_SST.INT_ORG_TYPE_CD = 'STORE'
         AND IO_SST.DWH_VALID_FG = true
         AND upper(substr(IO_SST.REPORTING_COUNTRY_CD, 1, 2)) <> 'LU'
      WHERE NUMERIC '1' = NUMERIC '1'
      -- sibling store is NOT directly ordered on a given day
       AND NOT EXISTS (
        SELECT
            NUMERIC '1'
          FROM
            DIRECTLY_ORDERED_STORES_AGG AS DOS
          WHERE NUMERIC '1' = NUMERIC '1'
           AND DOS.STORE_SID = IO_SST.INT_ORG_SID
           AND DOS.CAL_DT = DOS_P.CAL_DT
      )
;
-- Set status as LO (loading) for requested and approved stores
UPDATE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER SET ORDER_PARAMETER_STATUS_CD = 'LO', DWH_UPDATED_TMSP = current_timestamp() WHERE upper(T_FRAUD_DETECTION_ORDER.ORDER_PARAMETER_STATUS_CD) LIKE 'AP'
 AND (SV_MODE = 'WEEKLY'
 OR SV_ENVIRONMENT <> 'PROD'
 OR SV_MODE = 'DAILY'
 AND T_FRAUD_DETECTION_ORDER.INT_ORG_TYPE_CD = 'STORE');
