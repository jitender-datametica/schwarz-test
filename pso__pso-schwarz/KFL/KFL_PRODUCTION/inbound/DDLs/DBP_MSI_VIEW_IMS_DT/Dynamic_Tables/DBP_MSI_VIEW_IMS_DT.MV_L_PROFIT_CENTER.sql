CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_PROFIT_CENTER
(
	KRK_ID,
	MANDANT_ID,
	PC_ID,
	WUP_ID,
	NB_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 23.08.2013 twie: Lookup Profit Center
-- 10.11.2015 twie: pc_verantwortlicher entfernt
   SELECT
  krk_id,
   mandant_id,
   pc_id,
   wup_id,
   nb_id
   FROM dbp_view.v_profit_center
;