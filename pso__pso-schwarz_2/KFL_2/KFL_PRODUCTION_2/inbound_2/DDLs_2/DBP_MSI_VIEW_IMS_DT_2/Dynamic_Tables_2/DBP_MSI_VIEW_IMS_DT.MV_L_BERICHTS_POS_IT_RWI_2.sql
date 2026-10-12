CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_BERICHTS_POS_IT_RWI_2
(
	BERICHTS_POSITION_IT_RWI_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
--17.09.2013 AL neu erstellt analog mv_berichts_pos_it_rwi

   SELECT
   berichts_position_it_id AS  berichts_position_it_rwi_id

   FROM dbp_view.v_l_berichts_pos_it_2
;