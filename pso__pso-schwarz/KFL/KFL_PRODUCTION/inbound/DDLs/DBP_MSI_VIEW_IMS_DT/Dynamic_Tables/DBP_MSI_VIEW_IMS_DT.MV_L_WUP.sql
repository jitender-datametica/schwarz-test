CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_L_WUP
(
	WUP_ID,
	MANDANT_ID,
	NB_ID,
	WUP_STANDORT,
	VKL_ID,
	VS_ID,
	LAENGENGRAD,
	BREITENGRAD
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 11.04.2013 twie Erstellung Lookup Filiale
-- 03.06.2013 twie wup_name_v durch wup_standort als bez ersetzt
-- 14.06.2013 twie VKL und VS (=GL) hinzugefügt
-- 10.05.2017 twie SPEC0023705 Geoattribut

   SELECT
   wup_id,
   mandant_id,
   nb_id,
   CASE WHEN wup_id IN (0,-1) THEN ''
   ELSE wup_standort
   END AS wup_standort,
   COALESCE(vkl_id, -1) AS vkl_id,
   COALESCE(vs_id, 0) AS vs_id,
   laengengrad,
   breitengrad

   FROM dbp_view.v_wup
;