CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IT_PROJ_PROJLEITER_ZU_2
(
	IT_PROJEKT_ID,
	IT_PL_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 09.04.2013 AL Init

   SELECT
   it_projekt_id,
   ma_id AS  it_pl_id
  FROM dbp_view.v_it_projekt_ma_zu_2 v01
   WHERE v01.mandant_id=1 AND     ma_funktion_id='CLPL'
;