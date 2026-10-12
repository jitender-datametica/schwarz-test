CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_MONAT
(
	KJMO,
	KJMO_VJ,
	GJMO,
	GJMO_VJ,
	KJQU,
	GJQU,
	KJ,
	GJ,
	AKT_MO,
	AKT_MO_KOMPLETT,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	MO_GJ,
	MO_KJ,
	MIN_DAT,
	MAX_DAT,
	KJMO_VM
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
--23.05.2013 AL initial
   SELECT kjmo,
   kjmo_vj,
   gjmo,
   gjmo_vj,
   kjqu,
   gjqu,
   kj,
   gj,
   akt_mo,
   akt_mo_komplett,
   akt_gjqu,
   akt_gjqu_komplett,
   akt_kjqu,
   akt_kjqu_komplett,
   akt_gj,
   akt_gj_komplett,
   akt_kj,
   akt_kj_komplett,
   mo_gj,
   mo_kj,
   min_dat,
   max_dat,
   TO_NUMBER(TO_CHAR(DATEADD(MONTH,-1,TO_DATE(TO_CHAR(kjmo),'YYYYMM')),'YYYYMM'))
   FROM  dbp_view.v_monat
;