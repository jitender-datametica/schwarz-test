CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_IT_PROJEKT_PLAN_1
(
	PLAN_VERSION_ID,
	IT_PROJEKT_ID,
	SONSTIGER_AUFWAND,
	AKTIVIERUNGSQUOTE_INTERN,
	AKTIVIERUNGSQUOTE_EXTERN,
	DAT_VON,
	DAT_BIS
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 04.04.2013 AL Init
-- 19.10.2017 twie: RITM0414617aktivierungsquote_intern in Tabelle ersetzt durch aktivierungsquote_intern_plan, ebenso bei extern
-- 03.01.2019 twie: SPEC0046436 Umbau der Stuktur auf neue Tabelle, befüllt aus Clarity

   SELECT
   plan_revision_id AS plan_version_id,
   it_projekt_id,
   sonstiger_aufwand,
   aktivierungsquote_intern_plan AS aktivierungsquote_intern,
   aktivierungsquote_extern_plan AS aktivierungsquote_extern,
   dat_von,
   dat_bis

  FROM dbp_view.v_it_projekt_plan_1
;