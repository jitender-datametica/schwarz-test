create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_MONAT_BIG_DE(
	WUP_ID,
	MANDANT_ID,
	ART_ID,
	WG_ID,
	OWG_ID,
	KJMO,
	BELASTUNGSART_VD_ID,
	WRG_ID,
	MENGE,
	VK_NETTO,
	VK_BRUTTO
) as










WITH 

relevant_articles AS (
	SELECT a.mandant_id
		, a.art_id
		
		, a.wg_id
		, w.owg_id
		, NVL(t.kjmo, 190001) AS kjmo_von 
		, a.dat_von
		, a.dat_bis
	FROM dbp_msi_view_vis.mv_art_wg_zu a 
		JOIN dbp_msi_view_vis.mv_wg_int w 
			ON a.wg_id = w.wg_id
		LEFT OUTER JOIN dbp_view.v_tag t
			ON a.dat_von = t.dat 
	WHERE NOT (a.wg_id IN (981, 982, 983) 
		OR w.owg_id = 1093 
		)
	)
SELECT wup.aktuell_wup_id AS wup_id
	, big.mandant_id
	, big.art_id
	, a.wg_id
	, a.owg_id
	, big.kjmo
	, big.belastungsart_vd_id
	, big.wrg_id
	, SUM(COALESCE(big.menge, 0)) AS menge
	, SUM(COALESCE(big.vk_netto, 0)) AS vk_netto
	, SUM(COALESCE(big.vk_brutto, 0)) AS vk_brutto
FROM (
	
	SELECT wup_id
		, mandant_id
		, art_id
		, kjmo
		, 4 AS belastungsart_vd_id
		, wrg_id
		, SUM(menge * - 1) AS menge
		, SUM(umsatz_netto) AS vk_netto
		, SUM(umsatz_netto + umsatz_mwst_betrag) AS vk_brutto
	FROM dbp_msi_view_vis.mv_artbew artbew
	JOIN dbp_data.tag zeit
		ON zeit.dat = artbew.dat
	WHERE MANDANT_ID = 1
		AND akt_mo BETWEEN - 12 AND - 1
	GROUP BY wup_id
		, mandant_id
		, art_id
		, kjmo
		, 4
		, wrg_id
	UNION ALL
	
	SELECT CAST(CASE 
				WHEN lk.auftraggeber_id = ''
					THEN 0
				ELSE lk.auftraggeber_id
				END AS INTEGER) AS wup_id
		, lb.mandant_id
		, lb.art_id
		, zeit.kjmo
		, 1 AS belastungsart_vd_id
		, 'EUR' AS wrg_id
		, SUM(CASE 
				WHEN lk.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
					THEN lb.menge_faktura_bme
				ELSE (lb.menge_faktura_bme) * (- 1)
				END) AS menge
		, SUM(CASE 
				WHEN lk.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
					THEN (lb.zwsum_2_betrag + lb.zwsum_5_betrag + lb.zwsum_8_betrag) / (1 + (mp.mwst / 100))
				ELSE (lb.zwsum_2_betrag + lb.zwsum_5_betrag + lb.zwsum_8_betrag) * (- 1) / (1 + (mp.mwst / 100))
				END) AS vk_netto
		, SUM(CASE 
				WHEN lk.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2', 'ZLRS', 'ZLS2', 'ZLUL')
					THEN (lb.zwsum_2_betrag + lb.zwsum_5_betrag + lb.zwsum_8_betrag)
				ELSE (lb.zwsum_2_betrag + lb.zwsum_5_betrag + lb.zwsum_8_betrag) * (- 1)
				END) AS vk_brutto
	FROM dbp_view.v_besch_faktura_det lb
	JOIN dbp_view.v_besch_faktura lk
		ON lb.mandant_id = lk.mandant_id
			AND lb.faktura_beleg_id = lk.faktura_beleg_id
	JOIN dbp_view.v_art a
		ON a.art_id = lb.art_id
			AND a.mandant_id = lb.mandant_id
	JOIN dbp_view.v_mwst_per mp
		ON mp.mwst_id = a.mwst_id
			AND mp.mandant_id = a.mandant_id
			AND lk.dat_faktura BETWEEN mp.dat_von AND mp.dat_bis
	JOIN dbp_data.tag zeit
		ON zeit.dat = CASE 
				WHEN lk.fakturaart_id IN ('ZVLT', 'ZMWP', 'ZGLT', 'ZGWP', 'ZSLT', 'ZSMP', 'Z5LT', 'Z5MP', 'ZEWP', 'ZSWP')
					THEN lb.dat_leist_erstellung
				ELSE lb.dat_faktura
				END
	WHERE lk.fakturaart_id IN (
			SELECT fakturaart_id
			FROM dbp_view.v_rpw_fakturaarten
			)
		AND lb.mandant_id = 1
		AND akt_mo BETWEEN - 12 AND - 1
	GROUP BY CAST(CASE 
				WHEN lk.auftraggeber_id = ''
					THEN 0
				ELSE lk.auftraggeber_id
				END AS INTEGER)
		, lb.mandant_id
		, lb.art_id
		, zeit.kjmo
		, 1
		, 'EUR'
	UNION ALL
	
	


	
	SELECT v01.wup_id
		, v01.mandant_id
		, v01.art_id
		, zeit.kjmo
		, 1 AS belastungsart_vd_id
		, 'EUR' AS wrg_id
		, SUM(v01.menge_rech) AS menge
		, SUM(CASE 
				WHEN v01.menge_rech = 0
					THEN 0
				ELSE v01.vk_n
				END) AS vk_netto
		, SUM(CASE 
				WHEN v01.menge_rech = 0
					THEN 0
				ELSE v01.vk_n * (100 + v03.mwst) / 100
				END) AS vk_brutto
	FROM dbp_view.v_bsch_rech_det v01
	JOIN dbp_view.v_art v02
		ON v01.art_id = v02.art_id
			AND v01.mandant_id = v02.mandant_id
	JOIN dbp_view.v_mwst_per v03
		ON v02.mwst_id = v03.mwst_id
			AND v02.mandant_id = v03.mandant_id
			AND v01.dat BETWEEN v03.dat_von AND v03.dat_bis
	JOIN dbp_data.tag zeit
		ON zeit.dat = v01.dat
	WHERE v01.mandant_id = 1
		AND akt_mo BETWEEN - 12 AND - 1
	GROUP BY v01.wup_id
		, v01.mandant_id
		, v01.art_id
		, zeit.kjmo
		, 1
		, 'EUR'
	UNION ALL
	
	SELECT v01.wup_id
		, v01.mandant_id
		, v01.art_id
		, zeit.kjmo
		, 1 AS belastungsart_vd_id
		, 'EUR' AS wrg_id
		, SUM(v01.menge_erf) AS menge
		, SUM(CASE 
				WHEN v01.betrag_verkauf = 0
					THEN v01.betrag_verkauf_ist
				ELSE v01.betrag_verkauf
				END / (1 + (v03.mwst / 100))) AS vk_netto
		, SUM(CASE 
				WHEN v01.betrag_verkauf = 0
					THEN v01.betrag_verkauf_ist
				ELSE v01.betrag_verkauf
				END) AS vk_brutto
	FROM dbp_view.v_lagerbew_det v01
	JOIN dbp_view.v_art v02
		ON v01.mandant_id = v02.mandant_id
			AND v01.art_id = v02.art_id
	JOIN dbp_view.v_mwst_per v03
		ON v02.mwst_id = v03.mwst_id
			AND v02.mandant_id = v03.mandant_id
			AND v01.dat_buch BETWEEN v03.dat_von AND v03.dat_bis
	JOIN dbp_data.tag zeit
		ON zeit.dat = v01.dat_buch
	WHERE NOT (wup_id BETWEEN 6900 AND 6914
			OR wup_id = 9201
			)
		AND
		
		
		(
			(v01.lager_bewart_id IN ('317', '318', '319', '320'))
				AND NOT (
					(COALESCE(v01.empfaenger_id, 0) BETWEEN 6900 AND 6914)
					OR COALESCE(v01.empfaenger_id, 0) = 9201
					)
			OR
			
			(
				(v01.lager_bewart_id NOT IN ('317', '318', '319', '320'))
				AND NOT (
					(v01.empfaenger_id BETWEEN 6900 AND 6914)
					OR v01.empfaenger_id = 9201
					)
				)
			)
		
		AND v01.lager_bewart_id IN ('101', '102', '161', '162', '301', '302', '303', '304', '317', '318', '319', '320', '901', '902', '905', '906', '907', '908', '912', '915', '916')
		AND v01.mandant_id = 1
		AND akt_mo BETWEEN - 12 AND - 1
	GROUP BY v01.wup_id
		, v01.mandant_id
		, v01.art_id
		, zeit.kjmo
		, 1
		, 'EUR'
	UNION ALL
	
	SELECT br.wup_id
		, brdk.mandant_id
		, brdk.wg_id * - 1000 AS art_id
		, zeit.kjmo
		, 1 AS belastungsart_vd_id
		, 'EUR' AS wrg_id
		, SUM(brdk.menge) AS menge
		, SUM(CASE 
				WHEN brdk.row_grund_id = 158
					THEN brdk.betrag_beleg * 1.23
				WHEN brdk.row_grund_id = 159
					THEN brdk.betrag_beleg * 0.8
				ELSE brdk.betrag_beleg
				END) AS vk_netto
		, SUM(CASE 
				WHEN brdk.row_grund_id = 158
					THEN brdk.betrag_beleg * 1.23 * (1 + (v03.mwst / 100))
				WHEN brdk.row_grund_id = 159
					THEN brdk.betrag_beleg * 0.8 * (1 + (v03.mwst / 100))
				ELSE brdk.betrag_beleg
				END) AS vk_brutto
	FROM dbp_view.v_besch_rech_det_kont brdk
	JOIN dbp_view.v_besch_rech br
		ON br.mandant_id = brdk.mandant_id
			AND br.rech_beleg_id = brdk.rech_beleg_id
			AND br.gj = brdk.gj
	
	JOIN dbp_view.v_mwst_per v03
		ON CASE 
				WHEN brdk.sap_mwst_id IN ('76', '78', '95', '96')
					THEN 1
				WHEN brdk.sap_mwst_id IN ('53', '55', '94', '97')
					THEN 2
				WHEN brdk.sap_mwst_id IN ('71', '74')
					THEN 3
				WHEN brdk.sap_mwst_id IN ('99')
					THEN 9
				ELSE 1
				END = v03.mwst_id
			AND brdk.mandant_id = v03.mandant_id
			AND br.dat_buch BETWEEN v03.dat_von AND v03.dat_bis
	JOIN dbp_data.tag zeit
		ON zeit.dat = br.dat_leist_erstellung
	WHERE brdk.mandant_id = 1
		AND akt_mo BETWEEN - 12 AND - 1
		AND RIGHT(brdk.sachkonto_id, 6) IN ('314602', '314603', '314604', '314605', '314606', '314607', '314608', '314609', '314610', '314611', '314612', '314616', '314617', '314621', '314622', '314623', '314624', '316001', '316002', '316003', '316004', '316005', '316006', '316007', '316008', '316009', '316010', '316011', '316012', '316013', '316014', '312006', '312007', '312008', '312009', '312010', '312011', '312012', '312013', '312014', '312015', '312016', '312017', '312018', '312019', '312020')
		AND brdk.row_grund_id IN ('100', '101', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '114', '116', '119', '120', '142', '158', '159', '160', '161', '199')
	GROUP BY br.wup_id
		, brdk.mandant_id
		, brdk.wg_id * - 1000
		, zeit.kjmo
		, 1
		, 'EUR'
	UNION ALL
	
	SELECT ma.wup_id
		, ma.mandant_id
		, ma.art_id
		, zeit.kjmo
		, CASE 
			WHEN ma.abschriftart_id IN (8, 99, 190)
				THEN 3
			ELSE 2
			END AS belastungsart_vd_id
		, ma.wrg_id
		, SUM(CASE 
				WHEN ma.abschriftart_id >= 100
					THEN CASE 
							WHEN (
									ma.abschrift_menge_einh_id IS NULL
									AND art.gewart_id = 'KG'
									)
								OR ma.abschrift_menge_einh_id = 'G'
								THEN CASE 
										WHEN ma.abschriftbetrag_netto > 0
											THEN ma.menge_abschrift / 1000.000000 * - 1
										WHEN ma.abschriftbetrag_netto < 0
											THEN ma.menge_abschrift / 1000.000000
										ELSE 0
										END
							WHEN ma.abschriftbetrag_netto > 0
								THEN ma.menge_abschrift * - 1
							WHEN ma.abschriftbetrag_netto < 0
								THEN ma.menge_abschrift
							ELSE 0
							END
				ELSE 0
				END) AS menge
		, SUM((ma.abschriftbetrag_netto) * - 1) vk_netto
		, SUM((ma.abschriftbetrag_brutto) * - 1) vk_brutto
	FROM dbp_view.v_marktabschriften ma
	INNER JOIN (
		SELECT art_id
			, gewart_id
		FROM dbp_view.v_art
		WHERE mandant_id = 1
		) art
		ON ma.art_id = art.art_id
	JOIN dbp_data.tag zeit
		ON zeit.dat = ma.dat
	JOIN dbp_view.v_abschriftart_int_zu absch
		ON ma.MANDANT_ID = absch.MANDANT_ID
			AND ma.abschriftart_id = absch.abschriftart_id
	WHERE ma.mandant_id = 1
		AND akt_mo BETWEEN - 12 AND - 1
		AND abschriftart_int_id NOT IN (99)
	GROUP BY ma.wup_id
		, ma.mandant_id
		, ma.art_id
		, zeit.kjmo
		, CASE 
			WHEN ma.abschriftart_id IN (8, 99, 190)
				THEN 3
			ELSE 2
			END
		, ma.wrg_id
	) big
INNER JOIN dbp_view.v_wup wup
	ON big.mandant_id = wup.mandant_id
		AND big.wup_id = wup.wup_id
INNER JOIN relevant_articles a
	ON big.mandant_id = a.mandant_id
		AND big.art_id = a.art_id
		
GROUP BY wup.aktuell_wup_id
	, big.mandant_id
	, big.art_id
	, a.wg_id
	, a.owg_id
	, big.kjmo
	, big.belastungsart_vd_id
	, big.wrg_id
;
