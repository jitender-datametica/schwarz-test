CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_BIG_BESTANDSDIFFERENZEN_2(
	KJMO,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	WRG_ID,
	BESTANDSMENGE,
	BESTANDSMENGE_VORMONAT,
	BESTANDSWERT_ZVKP_VK_NETTO,
	BESTANDSWERT_VORMONAT_ZVKP_VK_NETTO,
	AKTIONFLAG
) AS

	-- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

SELECT
	v01.kjmo
	, v01.mandant_id
	, wup.aktuell_wup_id AS wup_id
	, v01.nb_id
	, v01.art_id
	, v01.wrg_id
	, v01.lbkum AS Bestandsmenge
	, v01.lbkum_vm AS Bestandsmenge_Vormonat
	, v01.vksal_ZVKP_nt AS Bestandswert_ZVKP_VK_netto
	, v01.vksal_ZVKP_nt_VM AS Bestandswert_Vormonat_ZVKP_VK_netto
	, COALESCE(v01.AKTIONFLAG,0)
FROM
(
		SELECT
		sub1.kjmo
		, sub1.mandant_id
		, sub1.wup_id
		, sub1.nb_id
		, sub1.art_id
		, sub1.wrg_id
		, sub1.vksal_nt
		, sub2.vksal_nt AS vksal_nt_VM
		, sub1.lbkum, sub2.lbkum AS lbkum_VM
		, v05.mwst_id, v07.vk_brutto
		, v06.mwst
		, (v07.vk_brutto * 100) / (100 + v06.mwst) vk_netto
		, sub1.lbkum * vk_netto AS vksal_ZVKP_nt
		, sub2.lbkum * vk_netto AS vksal_ZVKP_nt_VM
		,v08.AKTIONFLAG
		FROM
			(
			SELECT
			v03.kjmo
			, v01.mandant_id
			, TRY_CAST(v01.bewertungskreis_id AS INTEGER) AS wup_id
			, v02.nb_id
			, v01.wrg_id
			, v01.art_id
			, to_numeric(to_varchar(ADD_MONTHS(TO_DATE(to_varchar(v03.kjmo), 'YYYYMM'), -1), 'YYYYMM')) AS vkjmo --manual code change
			, SUM(v01.menge_bestand_bme) AS LBKUM
			, SUM(v01.vk_wert_netto) AS VKSAL_NT
			
			FROM dbp_view.v_art_bewertungskreis_periode_2 v01
			JOIN dbp_view.v_wup_2 v02
			ON v01.mandant_id = v02.mandant_id
			AND TRY_CAST(v01.bewertungskreis_id AS INTEGER) = v02.wup_id
			AND v01.gjmo > 190001
			
			JOIN 
			(
				SELECT
				v01.mandant_id mandant_id
				, v02.mandant_kbez mandant_kbez
				, v01.krk_id krk_id
				, v01.buchungsperiode_id buchungsperiode_id
				, v01.sap_buchungs_jahr sap_buchungs_jahr
				, (v01.sap_buchungs_jahr * 100) + v01.buchungsperiode_id AS LFGJAMON
				, CAST(LFGJAMON AS CHAR(6))||' '||CAST(v02.mandant_kbez AS CHAR(2))AS LFGJAMON_MANDT, v01.kjmo
				FROM dbp_view.v_sap_periode_kalender_zu_2 v01
				INNER JOIN dbp_view.v_mandant_2 v02
				ON v01.mandant_id = v02.mandant_id
				WHERE v01.buchungsperiode_id <= 12
				AND v01.krk_id <> 'DE02'
			) v03
			ON v01.mandant_id = v03.mandant_id AND
			v03.LFGJAMON BETWEEN v01.gjmo AND v01.gjmo_bis
			
			-- Performance nur letzte 12 Monate
			JOIN
			dbp_view.v_monat_2 v04
			ON v03.kjmo = v04.kjmo
			WHERE akt_mo BETWEEN  -13 AND -1
			GROUP BY 1,2,3,4,5,6
			) sub1
		
			LEFT OUTER JOIN
			(
				SELECT
				v03.kjmo
				, v01.mandant_id
				, TRY_CAST(v01.bewertungskreis_id AS INTEGER) AS wup_id
				, v02.nb_id
				, v01.wrg_id
				, v01.art_id
				, to_numeric(to_varchar(ADD_MONTHS(TO_DATE(to_varchar(v03.kjmo), 'YYYYMM'), -1), 'YYYYMM')) AS vkjmo --manual code change
				, SUM(v01.menge_bestand_bme) AS LBKUM
				, SUM(v01.vk_wert_netto) AS VKSAL_NT
				
				FROM dbp_view.v_art_bewertungskreis_periode_2 v01
				JOIN dbp_view.v_wup_2 v02
				ON v01.mandant_id = v02.mandant_id
				AND TRY_CAST(v01.bewertungskreis_id AS INTEGER) = v02.wup_id
				AND v01.gjmo > 190001
				
				JOIN 
				(
					SELECT
					v01.mandant_id mandant_id
					, v02.mandant_kbez mandant_kbez
					, v01.krk_id krk_id
					, v01.buchungsperiode_id buchungsperiode_id
					, v01.sap_buchungs_jahr sap_buchungs_jahr
					, (v01.sap_buchungs_jahr * 100) + v01.buchungsperiode_id AS LFGJAMON
					, CAST(LFGJAMON AS CHAR(6))||' '||CAST(v02.mandant_kbez AS CHAR(2))AS LFGJAMON_MANDT
					, v01.kjmo
					FROM dbp_view.v_sap_periode_kalender_zu_2 v01
					INNER JOIN dbp_view.v_mandant_2 v02
					ON v01.mandant_id = v02.mandant_id
					WHERE v01.buchungsperiode_id <= 12
					AND v01.krk_id <> 'DE02'
				) v03
				ON v01.mandant_id = v03.mandant_id AND
				v03.LFGJAMON BETWEEN v01.gjmo AND v01.gjmo_bis
				
				JOIN dbp_view.v_monat_2 v04
				ON v03.kjmo = v04.kjmo
				WHERE akt_mo BETWEEN  -13 AND -1
				GROUP BY 1,2,3,4,5,6
			) sub2
		ON  sub1.vkjmo = sub2.kjmo
		AND sub1.mandant_id = sub2.mandant_id
		AND sub1.wup_id = sub2.wup_id
		AND sub1.wrg_id = sub2.wrg_id
		AND sub1.art_id = sub2.art_id
		
		JOIN dbp_view.v_art_2 v05
		ON v05.art_id = sub1.art_id
		AND v05.mandant_id = sub1.mandant_id
		
		JOIN dbp_view.v_mwst_per_2 v06
		ON v05.mandant_id = v06.mandant_id
		AND v05.mwst_id = v06.mwst_id
		AND v06.dat_bis = '9999-12-31'
		
		JOIN dbp_view.v_art_wup_vk_per_2 v07
		ON v05.mandant_id = v07.mandant_id
		AND v05.art_id = v07.art_id
		AND sub1.wup_id = v07.wup_id
		AND 
			(SELECT MAX(dat) dat 
			FROM dbp_view.v_tag_2 
			WHERE akt_mo = -1) BETWEEN v07.dat_von AND v07.dat_bis
		
		LEFT JOIN
		(
				SELECT DISTINCT
				v22.mandant_id
				,v22.wup_id
				,v22.art_id
				,v33.kjmo
				,CASE WHEN v11.aktion_id IS NOT NULL THEN 1 ELSE 0 END AS AKTIONFLAG
				FROM dbp_view.v_aktion_2 v11
				
				JOIN dbp_view.v_aktion_art_wup_zu_2 v22
				ON v22.aktion_id = v11.aktion_id
				AND v22.mandant_id = v11.mandant_id
				
				/* Offset 8 days to map article on previous month additionally */
				JOIN dbp_view.v_tag_2 v33
				ON v33.dat BETWEEN (v11.dat_von - 8) AND v11.dat_bis
				
				WHERE v22.grund_sperrung IS NULL
				AND v11.mandant_id <> 1
				AND dat_preisaktiviert <> '1900-01-01'
		) v08
		ON v08.art_id = sub1.art_id
		AND v08.kjmo= sub1.kjmo
		AND v08.mandant_id= sub1.mandant_id
		AND v08.wup_id = sub1.wup_id
) v01

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

WHERE v01.mandant_id <> 1;