CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_EK_KUN.MV_CRM_KUNDE_FACT_1
(
    CRM_KUNDE_ID,
	VORZUGSFILIALE_WUP_ID,
	NB_ID,
	VORZUGSFILIALE_MANDANT_ID,
	DAT_REGISTRIERUNG,
	DAT_ABMELDUNG,
	KUNDENHERKUNFT_ID,
	DAT,
	KJMO,
	CRM_KONTO_ID,
	KUNDE_MANDANT_ID,
	KJWO_WW
)
TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_EK_KUN

AS
SELECT
 v01.crm_kunde_id
,v01.vorzugsfiliale_wup_id
,v01.nb_id
,v01.vorzugsfiliale_mandant_id
,CAST(v01.zeit_registrierung AS DATE) AS dat_registrierung
,CAST(v01.zeit_abmeldung AS DATE) AS dat_abmeldung
,v01.kundenherkunft_cd AS kundenherkunft_id
,v02.dat
,v02.kjmo
,v03.crm_konto_id
,v01.kunde_mandant_id
,v04.kjwo_ww
FROM DBP_DATA.CRM_L_KUNDE_1 v01

JOIN DBP_DATA.TAG_1 v02 
ON (v02.dat BETWEEN CAST(v01.zeit_registrierung AS DATE) AND CAST(v01.zeit_abmeldung AS DATE))

JOIN DBP_DATA.CRM_L_KONTO_1 v03 
ON (v01.crm_kunde_id=v03.crm_kunde_id)

LEFT OUTER JOIN DBP_DATA.WERBEWOCHE_KL_1 v04
ON (v02.dat=v04.dat AND v01.kunde_mandant_id=v04.mandant_id)

WHERE v02.akt_tag<=0 AND akt_kj IN (-2,-1,0)
;