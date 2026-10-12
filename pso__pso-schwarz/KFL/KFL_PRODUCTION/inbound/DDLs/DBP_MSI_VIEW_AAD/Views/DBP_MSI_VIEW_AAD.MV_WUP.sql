CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_WUP
(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	WUP_STANDORT,
	DAT_VON,
	VF_ID,
	VKL_ID,
	HL_ID,
	DAT_BIS,
	DAT_EROEFFNUNG,
	BREITENGRAD,
	LAENGENGRAD,
	VS_ID,
	LAND_ID
)
AS

-- 15.06.2023 snik: SPEC0200542 Lookup Filiale, analog KMR außer Spezialfilter für K-VISIT und Maritz
-- 14.08.2024 twie: SPEC0261627 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--								somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 
--								Deshalb in der Lookupview mv_wup ein Filter auf wup_id = aktuell_wup_id damit auch hier nur die aktuell gültige ID angezeigt wird

SELECT
    v01.wup_id	--entspricht hier aktuell_wup_id
   ,v01.nb_id
   ,v01.mandant_id
   ,CASE WHEN wup_id = 0
	THEN land_id || ' (unbekannt)'
	ELSE wup_standort
	END AS wup_standort
   ,v01.dat_von
   ,v01.vf_id
   ,v01.vkl_id
   ,v01.hl_id
   ,v01.dat_bis
   ,v01.dat_eroeffnung
   ,v01.breitengrad
   ,v01.laengengrad
   ,v01.vs_id
   ,v01.land_id
FROM dbp_view.v_wup v01

WHERE ((nb_id = 0
AND dat_von < CURRENT_DATE
-- C&C Märkte ausschließen
AND dat_eroeffnung < CURRENT_DATE) --über dat_eroeffnung, ist NULL bei C&C
OR wup_id = 0)
AND wup_id = aktuell_wup_id
;