/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedchangelog
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDCHANGELOG(
  CLIENT_ID COMMENT 'Client id - calculated based on the country code'
 , LIDL_COUNTRY COMMENT 'Country code. Original field name bic_zmlila'
 , SOURCE_SYSTEM COMMENT 'Source system'
 , WH_ID COMMENT 'Warehouse ID'
 , CHANGED_ATTR COMMENT 'attribute which has been changed'
 , CHANGE_TMSP COMMENT 'date and time user have made change'
 , DELIVERY_DT COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
 , NEW_VAL COMMENT 'new value of attribute'
 , OLD_VAL COMMENT 'old value of attribute'
 , CHANGE_REASON COMMENT 'reason to change the value'
 , ROUTE_GID COMMENT 'GID is to have a unique identifier of a Route across different delivery days for the same RDC.'
 , TOUR_GID COMMENT 'GID is to have a unique identifier of a tour across different delivery days for the same RDC.'
 , USER_NAME COMMENT 'user name'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
 , CHANGEDOBJECT COMMENT 'The name of the object that was changed'
 , CHANGEDOBJECTID COMMENT 'The ID of the object that has been changed'
 , HAULIERNAME COMMENT 'The name of the haulier which is set when a tour was changed'
) COMMENT='QUINTIQ - prepared view on raw data'
AS 
SELECT
   CLIENT_ID
 , LIDL_COUNTRY
 , SOURCE_SYSTEM
 , WH_ID
 , CHANGED_ATTR
 , CHANGE_TMSP
 , DELIVERY_DT
 , NEW_VAL
 , OLD_VAL
 , CHANGE_REASON
 , ROUTE_GID
 , TOUR_GID
 , USER_NAME
 , DWH_LOAD_ID
 , DWH_CREATED
 , DWH_UPDATED
 , DWH_VALID_FROM
 , DWH_VALID_TO
 , DELETED_FG
 , CHANGEDOBJECT
 , CHANGEDOBJECTID
 , HAULIERNAME
FROM DATA.T_QUINTIQ_REPORTEDCHANGELOG;