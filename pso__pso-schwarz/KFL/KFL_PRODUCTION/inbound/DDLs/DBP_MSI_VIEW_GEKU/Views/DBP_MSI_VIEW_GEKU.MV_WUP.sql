CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_WUP
(
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
) AS

-- 16.08.2013 twie: Dummyfiliale 0 hinzugefügt
-- 04.09.2013 twie: vw_id auf Dummy 0 setzen, wenn nicht in Lookup vorhanden
-- 19.09.2013 twie: wup_standort bei Dummyfiliale mit (unbekannt) ausgeben
-- 05.09.2014 twie: Filterung geändert, da vf_id nicht immer gepflegt
-- 10.05.2017 twie: SPEC0023528 Geoinfos einbinden
-- 29.05.2017 twie: SPEC0024346 Logistik und FLW auswerten, nicht nur Filialen
-- 31.01.2018 twie: SPEC0023579 Erweiterung Filter um 6 Dummyfilialen für DE (pro Region) aus Datenschutzgründen Gfk
-- 08.05.2018 twie: SPEC0037245 Erweiterung Filter um Dummyfilialen für DE pro GF für Maritz
-- 27.07.2023 twie: NSR3795018 Ergänzung Filter Umzugsfiliale für Angleichung an VIS. Entfernen obsoleter K-VISIT Filter
-- 14.08.2024 twie: SPEC0261627 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--								somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 
--								Deshalb in der Lookupview mv_wup ein Filter auf wup_id = aktuell_wup_id damit auch hier nur die aktuell gültige ID angezeigt wird

SELECT
wup_id, --entspricht hier aktuell_wup_id
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
-- C&C Märkte ausschließen
-- AND vf_id <> 6) -- nicht mehr mittels vf_id, da nicht immer gepflegt
AND dat_eroeffnung < CURRENT_DATE -- sondern über dat_eroeffnung, ist NULL bei C&C
AND umzugsfiliale_fg = 0)	-- Filter von VIS übernommen, damit vergleichbare Daten
OR wup_id = 0
-- Dummyfilialen pro GF, auf die in DE die Maritz Prüfungen gemappt sind
OR (nb_id = -1 AND vkl_id = wup_id AND mandant_id = 1)
)
AND wup_id = aktuell_wup_id
;