/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reporteddimachangelog_kpi
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDDIMACHANGELOG_KPI(
  CLIENT_ID COMMENT 'Client id - calculated based on the country code'
 , LIDL_COUNTRY COMMENT 'Country code. Original field name bic_zmlila'
 , SOURCE_SYSTEM COMMENT 'Source system'
 , WH_ID COMMENT 'Warehouse ID'
 , CHANGED_ATTR COMMENT 'The attribute that was changed'
 , CHANGED_TMSP COMMENT 'Time when the ok button was pressed to trigger the change'
 , DELIVERY_DT COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
 , CHANGE_ID COMMENT 'Combination of AddressFrom To ResourceType and timeProfile'
 , NEW_VAL COMMENT 'The new value of the attribute'
 , OLD_VAL COMMENT 'The old value of the attribute'
 , USER_NR COMMENT 'Employee number of the user that made the change'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
 , ACTIVE_FG COMMENT 'Flag if record is active'
) COMMENT='QUINTIQ - view with final KPIs for FE'
 AS 
SELECT
   client_id
 , lidl_country
 , source_system
 , wh_id
 , changed_attr
 , changed_tmsp
 , delivery_dt
 , change_id
 , new_val
 , old_val
 , user_nr
 , dwh_load_id
 , dwh_created
 , dwh_updated
 , dwh_valid_from
 , dwh_valid_to
 , deleted_fg
 , IFF(dwh_valid_to = '9999-12-30', 1, 0) AS active_fg
FROM fe_mstr_logop.v_quintiq_reporteddimachangelog
;