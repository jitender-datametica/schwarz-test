--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.vaus_wup_2

SET dat_eroeffnung = datEroffnung_CProjects

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
		FROM ( -- Gruppierung pro Projekt/wup_2
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
							FROM dbp_msi_view_ios.mv_cpr_cl_punkt_2 mv01

							JOIN dbp_msi_view_ios.mv_cpr_phase_2 mv02
							ON mv01.projekt_phase_id = mv02.projekt_phase_id

							JOIN dbp_msi_view_ios.mv_cpr_projekt_2 mv03
							ON mv02.projekt_id = mv03.projekt_id

							WHERE mv03.massnahme_kz IN ('NB_2', 'UE') -- Neubau/Uebernahme
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
		--WHERE datEroffnung_CProjects >= CURRENT_DATE
GROUP BY 1,2
HAVING datEroffnung_CProjects >= CURRENT_DATE
	)d
 WHERE mandant_id = mandant_id_
AND wup_id     = wup_id_
;

