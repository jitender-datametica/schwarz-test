 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_PRICE_LABEL_SENSOR_STATE_HIST
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ESL_PRICE_LABEL_SENSOR_STATE_HIST
(
   CLIENT_ID
  ,PRICE_LABEL_SID
  ,PRICE_LABEL_SENSOR_NAME
  ,PRICE_LABEL_METRIC_MEAS
  ,DELETED_FG
  ,DWH_VALID_FROM
  ,DWH_VALID_TO
) AS
SELECT 
   CLIENT_ID
  ,PRICE_LABEL_SID
  ,PRICE_LABEL_SENSOR_NAME
  ,PRICE_LABEL_METRIC_MEAS
  ,DELETED_FG
  ,DWH_VALID_FROM
  ,DWH_VALID_TO	
FROM P_LEW_CORE_AC.V_ESL_PRICE_LABEL_SENSOR_STATE_HIST
;