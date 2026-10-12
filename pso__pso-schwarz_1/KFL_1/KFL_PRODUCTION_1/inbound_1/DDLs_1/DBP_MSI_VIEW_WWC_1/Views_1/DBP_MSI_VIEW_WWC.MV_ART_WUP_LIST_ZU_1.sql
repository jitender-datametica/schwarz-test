CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_WUP_LIST_ZU_1(
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	BEZUGSWEG_ID,
	DAT_AENDERUNG,
	KJMO,
	GJMO,
	LFGJAMON,
	KDIS_KZ,
	LISTUNG_MARKT,
	LISTUNG_FCT
) AS
--08.01.2025, SPEC0285828, prescherad: Neuanlage
--04.08.2025, SPEC0325089, prescherad: Listung_mit LFGJAMON auswertbar machen  
 SELECT 
 v01.mandant_id
,v01.art_id
,v01.wup_id
,v01.nb_id
,v01.bezugsweg_id
,v04.max_dat AS dat_aenderung
,v04.kjmo
,v04.gjmo
,v05.lfgjamon
,CASE WHEN v01.kdis = 0 OR v01.kdis IS NULL THEN ' ' ELSE 'K' END kdis_kz
,CASE WHEN v02.art_id IS NULL THEN 'war nie gelistet' ELSE
 CASE WHEN v01.listung_id = 1 THEN (CASE WHEN v01.bezugsweg_id = 1 
                              THEN (CASE WHEN v01.kdis = 0 THEN '1' ELSE '5' END)
                              WHEN v01.bezugsweg_id = 4 
                              THEN (CASE WHEN v01.kdis = 0 THEN '4' ELSE '8' END)
                              ELSE 'ausgelistet' END)
                              ELSE 'ausgelistet' END END listung_markt
,CASE WHEN listung_markt IN ('ausgelistet','war nie gelistet') THEN NULL ELSE listung_markt END listung_fct

FROM dbp_view.v_art_wup_zu_per_1 v01
LEFT JOIN 
(SELECT
 mandant_id
,art_id
,wup_id
FROM dbp_view.v_art_list_wup_zu_per_1
GROUP BY 1,2,3) v02
ON  v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
AND v01.wup_id = v02.wup_id


JOIN dbp_view.v_wup_1 v03
ON  v01.mandant_id = v03.MANDANT_ID 
AND v01.wup_id = v03.WUP_ID 
AND v01.nb_id = v03.nb_id  

INNER JOIN dbp_view.v_monat_1 v04
ON v04.max_dat BETWEEN v01.dat_von AND v01.dat_bis

JOIN (
SELECT
    v01.mandant_id,
    (v01.sap_buchungs_jahr * 100) + v01.buchungsperiode_id AS LFGJAMON,
    v01.kjmo
    FROM
    dbp_view.v_sap_periode_kalender_zu_1 v01
    INNER JOIN dbp_view.v_mandant_1 v02 ON v01.mandant_id = v02.mandant_id
    WHERE
    v01.buchungsperiode_id <= 12
    AND v01.krk_id <> 'DE02' ) v05
ON v01.MANDANT_ID=v05.mandant_id
AND v04.KJMO=v05.KJMO	

WHERE v04.akt_mo <= 0

AND  (((v03.DAT_EROEFFNUNG < CURRENT_DATE OR v03.DAT_EROEFFNUNG< CURRENT_DATE +45) AND v03.DAT_VON IS NOT NULL)
      OR v03.NB_ID <> 0
      OR v03.WUP_ID = 9203)-- Filterung von Zentralfilialen
	AND NOT v03.WUP_ID BETWEEN 1 AND 999 -- 20100330 Filterung der IWT Betriebe
	AND v03.NB_ID <> 99;