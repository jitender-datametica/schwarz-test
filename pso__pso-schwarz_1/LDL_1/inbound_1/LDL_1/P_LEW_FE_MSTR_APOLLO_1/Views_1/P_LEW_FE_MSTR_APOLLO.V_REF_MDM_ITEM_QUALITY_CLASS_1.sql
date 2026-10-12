/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_REF_MDM_ITEM_QUALITY_CLASS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski, Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_REF_MDM_ITEM_QUALITY_CLASS_1
(
   item_quality_class_cd  
  ,item_quality_class_descr
  ,dwh_load_id                
  ,dwh_created            
  ,dwh_updated            
)
AS
   SELECT

   item_quality_class_cd  
  ,item_quality_class_descr
  ,dwh_load_id                
  ,dwh_created            
  ,dwh_updated            
FROM P_LEW_CORE_AC.V_REF_MDM_ITEM_QUALITY_CLASS_1;