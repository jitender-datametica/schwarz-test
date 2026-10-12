/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	V_QUINTIQ_RDCADDRESSPRODUCTTYPETIMEWINDOWKPI
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_RDCADDRESSPRODUCTTYPETIMEWINDOWKPI(
   CLIENT_ID COMMENT 'Client id - calculated based on the country code'
 , LIDL_COUNTRY COMMENT 'Country code. Original field name bic_zmlila'
 , WH_ID COMMENT 'Warehouse ID'
 , ADDRESSID COMMENT 'ID of the address'
 , DAYOFWEEK COMMENT 'Day of week indicator 67 means weekend (Saturday + Sunday) & 1 means Monday'
 , ENDTIME COMMENT 'Pattern: (d+ day(s)? )?d+:dd:dd'
 , ISTYPEPREFERRED COMMENT 'True if this time window is a time window of type preferred'
 , PRODUCTTYPEID COMMENT 'ID of the product type'
 , STARTTIME COMMENT 'Pattern: (d+ day(s)? )?d+:dd:dd'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
 , ACTIVE_FG COMMENT 'Flag if record is active'
) COMMENT='QUINTIQ - prepared view on raw data'
 AS SELECT
   CLIENT_ID
 , LIDL_COUNTRY
 , WH_ID
 , ADDRESSID
 , DAYOFWEEK
 , ENDTIME
 , ISTYPEPREFERRED
 , PRODUCTTYPEID
 , STARTTIME
 , DWH_LOAD_ID
 , DWH_CREATED
 , DWH_UPDATED
 , DWH_VALID_FROM 
 , DWH_VALID_TO
 , DELETED_FG
 , IFF(DWH_VALID_TO = '9999-12-30', 1, 0) AS ACTIVE_FG
FROM FE_MSTR_LOGOP.V_QUINTIQ_RDCADDRESSPRODUCTTYPETIMEWINDOW;