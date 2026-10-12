CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_IN_KOSTENSTELLE_SPR_ZU_SK_2
(
	MANDANT_ID,
	KOSTENSTELLE_ID,
	KRK_ID,
	KOSTENSTELLE_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 21.08.2013 twie: Sprachzuordung für Kostenarten

   SELECT

   mandant_id,
   kostenstelle_id,
   krk_id,
   kostenstelle_bez

   FROM dbp_view.v_in_kostenstelle_spr_zu_per_2

   WHERE spr_id = 108

   QUALIFY ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id  ORDER BY dat_bis DESC NULLS LAST) =1
;