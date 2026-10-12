CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_vis_umsatz_heute_15min (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	DAT,
	ZEIT_STUNDE,
	ZEIT_15MIN,
	Z1,
	Z2,
	BON_ENDE_MIN,
	BON_ENDE_MAX,
	BON_ENDE_MIN_WVJ,
	BON_ENDE_MAX_WVJ,
	BON_KUNDEN_ANZ,
	BON_KUNDEN_ANZ_WVJ,
	BON_KASSEN_ANZ,
	BON_KASSEN_ANZ_WVJ,
	BON_UMSATZ_NETTO,
	BON_UMSATZ_NETTO_WVJ,
	UMS_NETTO_PLAN,
	UMS_NETTO_WVJ,
	BON_VKF_UMSATZ_NETTO,
	BON_RTR_UMSATZ_NETTO,
	BON_KPF_UMSATZ_NETTO,
	BON_VKF_UMSATZ_NETTO_WVJ,
	BON_RTR_UMSATZ_NETTO_WVJ,
	BON_KPF_UMSATZ_NETTO_WVJ,
	BON_UMSATZ_BRUTTO,
	BON_UMSATZ_BRUTTO_WVJ,
	BON_VKF_UMSATZ_BRUTTO,
	BON_RTR_UMSATZ_BRUTTO,
	BON_KPF_UMSATZ_BRUTTO,
	BON_VKF_UMSATZ_BRUTTO_WVJ,
	BON_RTR_UMSATZ_BRUTTO_WVJ,
	BON_KPF_UMSATZ_BRUTTO_WVJ
	) AS
-- 2020-10-09 ssch0611 : based on vis_umsatz_heute_stunde - AP0053793 VTC Smartphone
-- 2020-10-30 ssch0611 : added 15min level +  MIX (compare kopf with verkauf/retoure)
-- 2022-10-10 ssch0611 : Calculation EUR with new logic [P16167] 
-- 2024-08-22 ssch0611 : Filialumgliederung + Review [P1760-DWH] 
-- 2024-10-16 muellerpatri : Filter auf wg_id <> 961 hinzugefügt [SPEC0276475]
-- 2025-04-29 muellerpatri : WVJ auf ods_bon_agg_15min entfernt und auf ODS umgestellt, Aussschluss-Filter von Artikeln in WVJ und Heute integriert
-- 2025-09-09 tekin: Correcting mapping of previous year values that are missing when a store gets another wup_id (Filialumgliederung)
WITH 
kl_art AS (
	-- Art/WG individuelle Filter pro Land
	-- Spezialfall (Kartellrecht) WG 961/962  müssen direkt in Bondaten gefiltert werden, da nicht in Stammdaten vorhanden 
	SELECT art.mandant_id
		, art.kl_art_id
	FROM dbp_data.art art
	INNER JOIN dbp_data.art_wg_zu_per wg
		ON wg.mandant_id = art.mandant_id
			AND wg.art_id = art.art_id
	WHERE art.dat_bis = '9999-12-31'
		AND wg.arthiertyp_id = 2
		AND wg.dat_bis = '9999-12-31'
		AND ((wg.mandant_id = 1
				AND wg.wg_id IN (818, 969)
				AND art.mwst_id IN (0, 9))
			OR (wg.mandant_id = 1
				AND wg.art_id IN (590006700, 590006900))
			OR (wg.mandant_id = 2
				AND wg.art_id IN (818410, 202685400, 1485930, 207699370))
			OR (wg.mandant_id = 2
				AND wg.wg_id = 969
				AND wg.wug_id BETWEEN 1 AND 4)
			OR (wg.mandant_id = 5
				AND wg.wg_id = 969
				AND wg.wug_id BETWEEN 1 AND 4)
			OR (wg.mandant_id = 6
				AND wg.art_id IN (98001300, 98001310, 98001320))
			OR (wg.mandant_id = 6
				AND wg.wg_id = 969
				AND wug_id BETWEEN 1 AND 4)
			OR (wg.mandant_id = 7
				AND wg.wg_id = 969
				AND wg.wug_id = 6)
			OR (wg.mandant_id = 7
				AND wg.wg_id = 980)
			)
	),
vis01 AS (
	/* PART I WVJ : ods_bon_kopf/ods_bon_kopf_verkauf/ods_bon_kopf_retoure */
	SELECT vis0.mandant_id
		, vis0.nb_id
		, vis0.wup_id
		, vis0.wrg_id
		, CURRENT_DATE AS dat -- für JOIN mit PART II Ist
		, bn_kpf.bon_dat AS dat_wvj
		--, vis0.ums_netto_plan nicht benötigt
		--, vis0.ums_netto_wvj nicht benötigt 
		, bn_kpf.zeit_stunde
		, bn_kpf.zeit_15min
		, bn_kpf.bon_ende_min_wvj
		, bn_kpf.bon_ende_max_wvj
		, bn_kpf.bon_kunden_anz_wvj
		, bn_kpf.bon_kassen_anz_wvj
		, bn_kpf.bon_kpf_umsatz_brutto_wvj
		, bn_kpf.bon_vkf_umsatz_brutto_wvj
		, bn_kpf.bon_rtr_umsatz_brutto_wvj
		, bn_kpf.bon_kpf_umsatz_netto_wvj
		, bn_kpf.bon_vkf_umsatz_netto_wvj
		, bn_kpf.bon_rtr_umsatz_netto_wvj
		, bn_kpf.bon_vkf_menge_wvj
		, bn_kpf.bon_rtr_menge_wvj
	FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup vis0
	INNER JOIN (
		SELECT bnk.mandant_id
			, bnk.wup_id
			, bnk.wrg_id
			, bnk.bon_dat
			, EXTRACT(HOUR FROM bnk.bon_ende) AS zeit_stunde
			, FLOOR(EXTRACT(MINUTE FROM bnk.bon_ende) / 15) * 15 AS zeit_15min
			, MIN(bnk.bon_ende) AS bon_ende_MIN_wvj
			, MAX(bnk.bon_ende) AS bon_ende_MAX_wvj
			, COUNT(DISTINCT bnk.bon_id) AS bon_kunden_anz_wvj
			, COUNT(DISTINCT bnk.kasse_nr) AS bon_kassen_anz_wvj
			, SUM(bnk.kpf_ums_brutto) AS bon_kpf_umsatz_brutto_wvj
			, SUM(bnk.vkf_ums_brutto) AS bon_vkf_umsatz_brutto_wvj
			, SUM(bnk.rtr_ums_brutto) AS bon_rtr_umsatz_brutto_wvj
			, SUM(bnk.kpf_ums_netto) AS bon_kpf_umsatz_netto_wvj
			, SUM(bnk.vkf_ums_netto) AS bon_vkf_umsatz_netto_wvj
			, SUM(bnk.rtr_ums_netto) AS bon_rtr_umsatz_netto_wvj
			, SUM(bnk.vkf_menge) AS bon_vkf_menge_wvj
			, SUM(bnk.rtr_menge) AS bon_rtr_menge_wvj
		FROM (
			SELECT bnk.mandant_id
				, bnk.wup_id
				, krs.nach_wrg_id AS wrg_id
				, bnk.bon_dat
				, bnk.bon_beginn
				, bnk.bon_ende
				, bnk.bon_id
				, bnk.kasse_nr
				, bnk.umsatz_brutto * krs.umrechnungskurs AS kpf_ums_brutto
				, (bnk.umsatz_brutto - bnk.umsatz_mwst) * krs.umrechnungskurs AS kpf_ums_netto
				, bnv.ums_brutto * krs.umrechnungskurs AS vkf_ums_brutto
				, bnv.ums_netto * krs.umrechnungskurs AS vkf_ums_netto
				, bnv.menge AS vkf_menge
				, bnr.ums_brutto * krs.umrechnungskurs AS rtr_ums_brutto
				, bnr.ums_netto * krs.umrechnungskurs AS rtr_ums_netto
				, bnr.menge AS rtr_menge
			FROM dbp_v_ods.v_ods_bon_kopf bnk
			INNER JOIN dbp_msi_view_vis.mv_kurs_umrechnung krs
				ON krs.von_wrg_id = bnk.wrg_id
			LEFT JOIN (
				SELECT v.mandant_id
					, v.wup_id
					, v.bon_dat
					, v.bon_id
					, SUM(v.umsatz_brutto) AS ums_brutto
					, SUM((v.umsatz_brutto * 100) / (vm.mwst + 100)) AS ums_netto
					, SUM(v.menge) AS menge
				FROM dbp_v_ods.v_ods_bon_verkauf v
				INNER JOIN dbp_view.v_mwst_per vm
					ON v.mandant_id = vm.mandant_id
						AND v.mwst_id = vm.mwst_id
						AND v.bon_dat BETWEEN vm.dat_von AND vm.dat_bis
				WHERE (v.mandant_id, v.kl_art_id) NOT IN (SELECT mandant_id, kl_art_id FROM kl_art ka)
					AND v.wg_id NOT IN (961, 962) -- Spezialfall (Kartellrecht) 
				GROUP BY ALL
				) bnv
				ON bnk.bon_id = bnv.bon_id
					AND bnk.wup_id = bnv.wup_id
					AND bnk.mandant_id = bnv.mandant_id
					AND bnk.bon_dat = bnv.bon_dat
			LEFT JOIN (
				SELECT r.mandant_id
					, r.wup_id
					, r.bon_id
					, r.bon_dat
					, SUM(r.umsatz_brutto) AS ums_brutto
					, SUM((r.umsatz_brutto * 100) / (rm.mwst + 100)) AS ums_netto
					, SUM(r.menge) AS menge
				FROM dbp_v_ods.v_ods_bon_retoure r
				INNER JOIN dbp_view.v_mwst_per rm
					ON r.mandant_id = rm.mandant_id
						AND r.mwst_id = rm.mwst_id
						AND r.bon_dat BETWEEN rm.dat_von AND rm.dat_bis
				WHERE (r.mandant_id, r.kl_art_id) NOT IN (SELECT mandant_id, kl_art_id FROM kl_art ka)
					AND r.wg_id NOT IN (961, 962) -- Spezialfall (Kartellrecht) 
				GROUP BY ALL
				) bnr
				ON bnk.bon_id = bnr.bon_id
					AND bnk.wup_id = bnr.wup_id
					AND bnk.mandant_id = bnr.mandant_id
					AND bnk.bon_dat = bnr.bon_dat
			WHERE (bnk.bon_id, bnk.wup_id, bnk.mandant_id) NOT IN (SELECT bon_id, wup_id, mandant_id FROM dbp_v_ods.v_ods_bon_storno)
				AND bnk.turnover_fg = 1
				/* Filterung für Zählung relevanter Bons, welche gezählt werden sollen -> Verkauf- oder Rerour-Bon  */
				AND (bnv.bon_id IS NOT NULL
					OR bnr.bon_id IS NOT NULL)
				AND bnk.bon_dat = CURRENT_DATE - 364 -- Vorjahr, Wochentag 
			) bnk
		GROUP BY ALL
		) bn_kpf
		ON vis0.mandant_id = bn_kpf.mandant_id
			AND vis0.wup_id = bn_kpf.wup_id
			AND vis0.wrg_id = bn_kpf.wrg_id
			AND vis0.dat = bn_kpf.bon_dat
	WHERE vis0.nb_id = 0
		AND vis0.dat = CURRENT_DATE - 364 -- Vorjahr, Wochentag 
	),
vis02 AS (
	/* Part II HEUTE : ods_bon_kopf/ods_bon_kopf_verkauf/ods_bon_kopf_retoure */
	SELECT vis0.mandant_id
		, vis0.nb_id
		, vis0.wup_id
		, vis0.wrg_id
		, vis0.dat
		, vis0.ums_netto_plan
		, vis0.ums_netto_wvj
		, bn_kpf.zeit_stunde
		, bn_kpf.zeit_15min
		, bn_kpf.bon_ende_min
		, bn_kpf.bon_ende_max
		, bn_kpf.bon_kunden_anz
		, bn_kpf.bon_kassen_anz
		, bn_kpf.bon_kpf_umsatz_brutto
		, bn_kpf.bon_vkf_umsatz_brutto
		, bn_kpf.bon_rtr_umsatz_brutto
		, bn_kpf.bon_kpf_umsatz_netto
		, bn_kpf.bon_vkf_umsatz_netto
		, bn_kpf.bon_rtr_umsatz_netto
		, bn_kpf.bon_vkf_menge
		, bn_kpf.bon_rtr_menge
	FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup vis0
	INNER JOIN (
		SELECT bnk.mandant_id
			, bnk.wup_id
			, bnk.wrg_id
			, bnk.bon_dat
			, EXTRACT(HOUR FROM bnk.bon_ende) AS zeit_stunde
			, FLOOR(EXTRACT(MINUTE FROM bnk.bon_ende) / 15) * 15 AS zeit_15min
			, MIN(bnk.bon_ende) AS bon_ende_MIN
			, MAX(bnk.bon_ende) AS bon_ende_MAX
			, COUNT(DISTINCT bnk.bon_id) AS bon_kunden_anz
			, COUNT(DISTINCT bnk.kasse_nr) AS bon_kassen_anz
			, SUM(bnk.kpf_ums_brutto) AS bon_kpf_umsatz_brutto
			, SUM(bnk.vkf_ums_brutto) AS bon_vkf_umsatz_brutto
			, SUM(bnk.rtr_ums_brutto) AS bon_rtr_umsatz_brutto
			, SUM(bnk.kpf_ums_netto) AS bon_kpf_umsatz_netto
			, SUM(bnk.vkf_ums_netto) AS bon_vkf_umsatz_netto
			, SUM(bnk.rtr_ums_netto) AS bon_rtr_umsatz_netto
			, SUM(bnk.vkf_menge) AS bon_vkf_menge
			, SUM(bnk.rtr_menge) AS bon_rtr_menge
		FROM (
			SELECT bnk.mandant_id
				, bnk.wup_id
				, krs.nach_wrg_id AS wrg_id
				, bnk.bon_dat
				, bnk.bon_beginn
				, bnk.bon_ende
				, bnk.bon_id
				, bnk.kasse_nr
				, bnk.umsatz_brutto * krs.umrechnungskurs AS kpf_ums_brutto
				, (bnk.umsatz_brutto - bnk.umsatz_mwst) * krs.umrechnungskurs AS kpf_ums_netto
				, bnv.ums_brutto * krs.umrechnungskurs AS vkf_ums_brutto
				, bnv.ums_netto * krs.umrechnungskurs AS vkf_ums_netto
				, bnv.menge AS vkf_menge
				, bnr.ums_brutto * krs.umrechnungskurs AS rtr_ums_brutto
				, bnr.ums_netto * krs.umrechnungskurs AS rtr_ums_netto
				, bnr.menge AS rtr_menge
			FROM dbp_v_ods.v_ods_bon_kopf bnk
			INNER JOIN dbp_msi_view_vis.mv_kurs_umrechnung krs
				ON krs.von_wrg_id = bnk.wrg_id
			LEFT JOIN (
				SELECT v.mandant_id
					, v.wup_id
					, v.bon_dat
					, v.bon_id
					, SUM(v.umsatz_brutto) AS ums_brutto
					, SUM((v.umsatz_brutto * 100) / (vm.mwst + 100)) AS ums_netto
					, SUM(v.menge) AS menge
				FROM dbp_v_ods.v_ods_bon_verkauf v
				INNER JOIN dbp_view.v_mwst_per vm
					ON v.mandant_id = vm.mandant_id
						AND v.mwst_id = vm.mwst_id
						AND v.bon_dat BETWEEN vm.dat_von AND vm.dat_bis
				WHERE (v.mandant_id, v.kl_art_id) NOT IN (SELECT mandant_id, kl_art_id FROM kl_art ka)
					AND v.wg_id NOT IN (961, 962) -- Spezialfall (Kartellrecht) 
				GROUP BY ALL
				) bnv
				ON bnk.bon_id = bnv.bon_id
					AND bnk.wup_id = bnv.wup_id
					AND bnk.mandant_id = bnv.mandant_id
					AND bnk.bon_dat = bnv.bon_dat
			LEFT JOIN (
				SELECT r.mandant_id
					, r.wup_id
					, r.bon_id
					, r.bon_dat
					, SUM(r.umsatz_brutto) AS ums_brutto
					, SUM((r.umsatz_brutto * 100) / (rm.mwst + 100)) AS ums_netto
					, SUM(r.menge) AS menge
				FROM dbp_v_ods.v_ods_bon_retoure r
				INNER JOIN dbp_view.v_mwst_per rm
					ON r.mandant_id = rm.mandant_id
						AND r.mwst_id = rm.mwst_id
						AND r.bon_dat BETWEEN rm.dat_von AND rm.dat_bis
				WHERE (r.mandant_id, r.kl_art_id) NOT IN (SELECT mandant_id, kl_art_id FROM kl_art ka)
					AND r.wg_id NOT IN (961, 962) -- Spezialfall (Kartellrecht) 
				GROUP BY ALL
				) bnr
				ON bnk.bon_id = bnr.bon_id
					AND bnk.wup_id = bnr.wup_id
					AND bnk.mandant_id = bnr.mandant_id
					AND bnk.bon_dat = bnr.bon_dat
			WHERE (bnk.bon_id, bnk.wup_id, bnk.mandant_id) NOT IN (SELECT bon_id, wup_id, mandant_id FROM dbp_v_ods.v_ods_bon_storno)
				AND bnk.turnover_fg = 1
				AND (bnv.bon_id IS NOT NULL
					OR bnr.bon_id IS NOT NULL)
				AND bnk.bon_dat = CURRENT_DATE
			) bnk
		GROUP BY ALL
		) bn_kpf
		ON vis0.mandant_id = bn_kpf.mandant_id
			AND vis0.wup_id = bn_kpf.wup_id
			AND vis0.wrg_id = bn_kpf.wrg_id
			AND vis0.dat = bn_kpf.bon_dat
	WHERE vis0.nb_id = 0
		AND vis0.dat = CURRENT_DATE
	),
wup_id_change AS (
	SELECT mandant_id
		, wup_id
		, orig_wup_id
		, aktuell_wup_id
		, wup_name_e
		, wup_standort
		, dat_von
		, dat_bis
		, dat_eroeffnung
		, wup_aenderung_grund_id
	FROM dbp_view.v_wup
	--WHERE wup_aenderung_grund_id = 3 -- 0 = keine Aenderung, 1 = Umzug (vor Filialumgliederungen), 2 = Umzug (seit Filialumgliederungen), 3 = Umgliederung, 4 = Abriss / Neubau
	QUALIFY COUNT(*) OVER (PARTITION BY mandant_id, orig_wup_id) > 1 -- original stores with multiple rows have a change of the wup_id (Filialumgliederung)  
	--ORDER BY mandant_id, orig_wup_id, dat_von
	)
SELECT DISTINCT COALESCE(vis01.mandant_id, vis02.mandant_id) AS mandant_id
	, COALESCE(vis01.nb_id, vis02.nb_id) AS nb_id
	, COALESCE(w.aktuell_wup_id, vis01.wup_id, vis02.wup_id) AS wup_id -- to take over the current wup id though previous year values have another id after a regrouping (Filialumgliederung)  
	, COALESCE(vis01.wrg_id, vis02.wrg_id) AS wrg_id
	, COALESCE(vis01.dat, vis02.dat) AS dat
	, COALESCE(vis01.zeit_stunde, vis02.zeit_stunde) AS zeit_stunde
	, COALESCE(vis01.zeit_15min, vis02.zeit_15min) AS zeit_15min
	, vis01.zeit_stunde AS z1 -- Helper (AGG_15)
	, vis02.zeit_stunde AS z2 -- Helper (BON_Kopf)
	, vis02.bon_ende_min
	, vis02.bon_ende_max
	, vis01.bon_ende_min_wvj
	, vis01.bon_ende_max_wvj
	, vis02.bon_kunden_anz
	, vis01.bon_kunden_anz_wvj
	, vis02.bon_kassen_anz
	, vis01.bon_kassen_anz_wvj
	, NULLIF(COALESCE(vis02.bon_vkf_umsatz_netto, 0) + COALESCE(vis02.bon_rtr_umsatz_netto, 0), 0) AS bon_umsatz_netto -- verkauf/retoure
	, NULLIF(COALESCE(vis01.bon_vkf_umsatz_netto_wvj, 0) + COALESCE(vis01.bon_rtr_umsatz_netto_wvj, 0), 0) AS bon_umsatz_netto_wvj -- verkauf/retoure
	, vis02.ums_netto_plan -- Tageswert Plan 
	, vis02.ums_netto_wvj -- Tageswert WVJ 
	, vis02.bon_vkf_umsatz_netto
	, vis02.bon_rtr_umsatz_netto
	, vis02.bon_kpf_umsatz_netto
	, vis01.bon_vkf_umsatz_netto_wvj
	, vis01.bon_rtr_umsatz_netto_wvj
	, vis01.bon_kpf_umsatz_netto_wvj
	, NULLIF(COALESCE(vis02.bon_vkf_umsatz_brutto, 0) + COALESCE(vis02.bon_rtr_umsatz_brutto, 0), 0) AS bon_umsatz_brutto -- verkauf/retoure
	, NULLIF(COALESCE(vis01.bon_vkf_umsatz_brutto_wvj, 0) + COALESCE(vis01.bon_rtr_umsatz_brutto_wvj, 0), 0) AS bon_umsatz_brutto_wvj -- verkauf/retoure
	, vis02.bon_vkf_umsatz_brutto
	, vis02.bon_rtr_umsatz_brutto
	, vis02.bon_kpf_umsatz_brutto
	, vis01.bon_vkf_umsatz_brutto_wvj
	, vis01.bon_rtr_umsatz_brutto_wvj
	, vis01.bon_kpf_umsatz_brutto_wvj
FROM vis01
LEFT OUTER JOIN wup_id_change w
	ON vis01.mandant_id = w.mandant_id
		AND vis01.wup_id = w.wup_id
		AND vis01.dat_wvj BETWEEN dat_von AND dat_bis -- to take the corresponding new wupid in case of a wupid change within the last 364 days  
FULL OUTER JOIN vis02
	ON vis01.mandant_id = vis02.mandant_id
		AND COALESCE(w.aktuell_wup_id, vis01.wup_id) = vis02.wup_id -- to match the new wupid and otherwise the original wupid
		AND vis01.wrg_id = vis02.wrg_id
		AND vis01.dat = vis02.dat
		AND vis01.zeit_stunde = vis02.zeit_stunde
		AND vis01.zeit_15min = vis02.zeit_15min
;
