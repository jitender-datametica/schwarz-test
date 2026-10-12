CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IT_GREMIUM
(
	IT_GREMIUM_ID,
	IT_GREMIUM_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 15.04.2013 AL Init

   SELECT
   it_gremium_id,
   it_gremium_bez
  FROM dbp_view.v_l_it_gremium
;