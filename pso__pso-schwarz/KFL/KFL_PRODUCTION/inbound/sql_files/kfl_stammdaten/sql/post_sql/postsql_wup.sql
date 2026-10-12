UPDATE DBP_DATA.wup 
 SET 	wup_plz		        = _wup_plz,
	wup_stadt	        = _wup_stadt,
	wup_str		        = _wup_str,	
	region_id	        = _region_id,
	land_id		        = _land_id,
	adresse_id	        = _adresse_id,
        mandant_id_ursprung     = _mandant_id_ursprung

 FROM (
SELECT
	mandant_id              as _mandant_id,
	wup_id                  as _wup_id,
	wup_plz 	        as _wup_plz,
	wup_stadt 	        as _wup_stadt,
	wup_str 	        as _wup_str,
	region_id 	        as _region_id,
	land_id 	        as _land_id,
	adresse_id	        as _adresse_id,
        mandant_id_ursprung     as _mandant_id_ursprung
	
 FROM ${TEMP_TABLE} /* DBP_ETL.wup_temp*/
) dt1
 WHERE 	mandant_id      = _mandant_id 
   AND 	wup_id 		= _wup_id
;

UPDATE DBP_DATA.wup

SET dat_eroeffnung = datEroffnung_CProjects
, dat_von = datEroffnung_CProjects

FROM
(
   SELECT
-- Aufgabe ist fuehrend vor Checkliste
	mandant_id       AS mandant_id_
	,wup_id           AS wup_id_
	,MAX(dat_eroeffnung)   AS datEroffnung_CProjects
		FROM
		(
		SELECT DISTINCT
		mandant_id
		, wup_id
		, dat_eroeffnung
		FROM ( -- Gruppierung pro Projekt/wup
				SELECT
				sub01.mandant_id
				, sub01.wup_id
				, sub01.projekt_id
				, sub01.projekt_nr
				, MAX(sub01.CPR_PRV_APLNAT)     dat_freigabe
				, MAX(sub01.EROEFFNUNGSABNAHME) dat_abnahme
				, MAX(sub01.STILLE_EROEFFNUNG)  dat_eroeffnung
					FROM ( -- Ermittlung der relevanten Termine
							SELECT
							mv02.projekt_id
							, mv03.projekt_nr
							, mv03.mandant_id
							, mv03.wup_id
							, CASE WHEN mv01.cpr_suchfeld_id = 'CPR_PRV_APLNAT'     THEN mv01.dat_termin END AS CPR_PRV_APLNAT
							, CASE WHEN mv01.cpr_suchfeld_id = 'EROEFFNUNGSABNAHME' THEN mv01.dat_termin END AS EROEFFNUNGSABNAHME
							, CASE WHEN mv01.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'  THEN mv01.dat_termin END AS STILLE_EROEFFNUNG
							FROM dbp_msi_view_ios.mv_cpr_cl_punkt mv01

							JOIN dbp_msi_view_ios.mv_cpr_phase mv02
							ON mv01.projekt_phase_id = mv02.projekt_phase_id

							JOIN dbp_msi_view_ios.mv_cpr_projekt mv03
							ON mv02.projekt_id = mv03.projekt_id

							WHERE mv03.massnahme_kz IN ('NB', 'UE') -- Neubau/Uebernahme
							AND mv03.cpr_systemstatus1_id IN (2) -- gueltige
							AND mv01.cpr_suchfeld_id IN('CPR_PRV_APLNAT', 'EROEFFNUNGSABNAHME', 'STILLE_EROEFFNUNG') -- relevante suchfelder
							AND mv01.dat_termin IS NOT NULL -- ohne leere Termine
						) sub01
						GROUP BY
						sub01.mandant_id
						, sub01.wup_id
						, sub01.projekt_id
						, sub01.projekt_nr
			) sub11
			WHERE wup_id IS NOT NULL
			AND dat_eroeffnung IS NOT NULL
		)k
	GROUP BY 1,2
	HAVING datEroffnung_CProjects >= CURRENT_DATE)d
 WHERE mandant_id = mandant_id_
AND wup_id     = wup_id_
;

DELETE FROM DBP_DATA.wup
WHERE (mandant_id, wup_id, nb_id ) IN
(SELECT DISTINCT wp.mandant_id, wp.gf_id as wup, -1 as nb_id
 FROM DBP_DATA.wup wp
 WHERE wp.mandant_id = 1 AND nb_id = 0 AND wp.gf_id > 0 AND dat_bis > CURRENT_DATE AND dat_von < CURRENT_DATE
);

INSERT INTO DBP_DATA.wup 
(wup_id, nb_id, mandant_id, vw_id, vs_id, land_id, region_id, dat_von, wup_typ_id, wup_name_v, wup_name_e, wup_standort, vf_id, vkl_id, hl_id, dat_bis, wm_id, dat_eroeffnung, haupt_wup_id, gf_id, orig_wup_id, aktuell_wup_id)
SELECT
gf_id AS wup_id
, -1 AS nb_id
, mandant_id
, 6 AS vw_id
, vs_id
, land_id
, -55 AS region_id
, to_date('2000-03-01','YYYY-MM-DD')  AS dat_von
, 0 AS wup_typ_id
, 'ZF/Maritz' || ma_name || ' ' || ma_vorname AS wup_name_v
, SUBSTR( 'Zentralfiliale Maritz ' || ma_name || ' ' || ma_vorname,1,40) AS wup_name_e
, 'ZF/Maritz ' || ma_name || ' ' || ma_vorname AS wup_standort
, 2 AS vf_id
, gf_id AS vkl_id
, -1 AS hl_id
, to_date('9999-12-31','YYYY-MM-DD')  AS dat_bis
, -1 AS wm_id
, to_date('2000-03-01','YYYY-MM-DD')  AS dat_eroeffnung
, gf_id AS haupt_wup_id -- Dummy aus GF
, gf_id AS gf_id
, gf_id AS orig_wup_id
, gf_id AS aktuell_wup_id
FROM (
SELECT DISTINCT wp.mandant_id, wp.land_id,wp.gf_id, gf.ma_name, gf.ma_vorname,max(wp.vs_id) vs_id
FROM DBP_DATA.wup wp

JOIN DBP_DATA.ma_spr_zu gf
ON gf.mandant_id = wp.mandant_id AND gf.ma_id = wp.gf_id AND gf.spr_id = 22

WHERE wp.mandant_id = 1 AND nb_id = 0 AND wp.gf_id > 0 AND dat_bis > CURRENT_DATE AND dat_von < CURRENT_DATE

GROUP BY 1,2,3,4,5

) sub_gf;

