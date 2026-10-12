CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_BERICHTS_POS_IT_RWI_SPR_ZU_1
(
	BERICHTS_POSITION_IT_RWI_ID,
	BERICHTS_POSITION_IT_CHAR_ID,
	BERICHTS_POSITION_IT_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
--17.09.2013 AL neu erstellt analog .mv_berichts_pos_it_spr_zu_1

   SELECT

   berichts_position_it_id AS  berichts_position_it_rwi_id,
   CASE WHEN berichts_position_it_id < 10
   THEN '0' || CAST (berichts_position_it_id AS CHAR(1))
   ELSE CAST(berichts_position_it_id AS CHAR(2))
   END   AS berichts_position_it_char_id,
   berichts_position_it_bez

   FROM dbp_view.v_berichts_pos_it_spr_zu_1

   WHERE  spr_id=22
   ;