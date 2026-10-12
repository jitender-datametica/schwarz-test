create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_WUP(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	LAND_ID,
	DAT_VON,
	WUP_TYP_ID,
	WUP_NAME_V,
	WUP_NAME_E,
	WUP_STANDORT,
	WUP_PLZ,
	WUP_STR,
	VF_ID,
	VKL_ID,
	HL_ID,
	DAT_BIS,
	UEBERNAHME_VON,
	BREAKEVENUMSATZ,
	SYSTEMRENTABILITAET,
	VERKAUFSFLAECHE,
	BETRIEBSFLAECHE,
	FLEISCHSYSTEM,
	PREISKATEGORIE_FOOD,
	PREISKATEGORIE_NONFOOD,
	SORTKATEGORIE_FOOD,
	SORTKATEGORIE_NONFOOD,
	SONDERMARKT,
	REF_WUP_ID,
	WM_ID,
	KASSENTYP,
	DAT_QBM_UMSTELLUNG,
	LEAD_MWST,
	REGION_ID,
	KUNDENFAKTOR,
	VZ_WUP_ID,
	MARKT,
	GETRAENKEMARKT_FG,
	VW_ID,
	VS_ID,
	VERKAUFSORGANISATION_ID,
	LAENGENGRAD,
	BREITENGRAD
) as














SELECT
wup_id, 
nb_id,
mandant_id,
land_id,
dat_von,
wup_typ_id,
wup_name_v,
wup_name_e,
CASE WHEN wup_id = 0
THEN land_id || ' (unbekannt)'
ELSE wup_standort
END AS wup_standort,
wup_plz,
wup_str,
vf_id,
vkl_id,
hl_id,
dat_bis,
uebernahme_von,
breakevenumsatz,
systemrentabilitaet,
verkaufsflaeche,
betriebsflaeche,
fleischsystem,
preiskategorie_food,
preiskategorie_nonfood,
sortkategorie_food,
sortkategorie_nonfood,
sondermarkt,
ref_wup_id,
wm_id,
kassentyp,
dat_qbm_umstellung,
lead_mwst,
region_id,
kundenfaktor,
vz_wup_id,
TRIM(wup_id || ' ' || wup_standort)  AS Markt,
getraenkemarkt_fg,
CASE WHEN mandant_id = 1 AND vw_id NOT IN (1,2,3)
THEN 0
WHEN mandant_id <> 1 THEN 0
ELSE vw_id
END AS vw_id,
vs_id,
verkaufsorganisation_id,
laengengrad,
breitengrad

FROM dbp_view.v_wup

WHERE ((nb_id = 0
AND dat_von < CURRENT_DATE


AND dat_eroeffnung < CURRENT_DATE 
AND umzugsfiliale_fg = 0)	
OR wup_id = 0

OR (nb_id = -1 AND vkl_id = wup_id AND mandant_id = 1)
)
AND wup_id = aktuell_wup_id
;