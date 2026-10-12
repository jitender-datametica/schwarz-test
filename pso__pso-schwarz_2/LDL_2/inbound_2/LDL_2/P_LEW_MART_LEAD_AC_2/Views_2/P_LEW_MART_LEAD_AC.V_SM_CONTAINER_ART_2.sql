CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_SM_CONTAINER_ART_2 
AS (
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL
#----------------------------------------------------------------------------
# History:
#  1.0  19.05.2022    Bialek, Aleksander       Initial Version Part of SOMO AP2, Ek-Wa_SoMo_AP2_SF_objects, BBT-3832, AD Work Item_2: 291570
#----------------------------------------------------------------------------
*/
SELECT 
  CONT_ART_ID 
, CONTAINER_ART 
FROM P_LEW_MART_LEAD.T_SM_CONTAINER_ART_2
)
;
