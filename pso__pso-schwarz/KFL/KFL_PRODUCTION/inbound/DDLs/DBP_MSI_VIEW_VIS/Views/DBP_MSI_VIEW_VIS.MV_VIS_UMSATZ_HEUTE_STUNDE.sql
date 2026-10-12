CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_vis_umsatz_heute_stunde (
	MANDANT_ID
	, NB_ID
	, WUP_ID
	, WRG_ID
	, DAT
	, ZEIT_STUNDE
	, Z1
	, Z2
	, BON_ENDE_MIN
	, BON_ENDE_MAX
	, BON_KUNDEN_ANZ
	, BON_KUNDEN_ANZ_WVJ
	, BON_KASSEN_ANZ
	, BON_KASSEN_ANZ_WVJ
	, BON_VKF_UMSATZ_NETTO
	, BON_RTR_UMSATZ_NETTO
	, BON_KPF_UMSATZ_NETTO
	, BON_UMSATZ_NETTO_MIX
	, BON_UMSATZ_NETTO
	, BON_UMSATZ_NETTO_WVJ
	, BON_VKF_UMSATZ_BRUTTO
	, BON_RTR_UMSATZ_BRUTTO
	, BON_KPF_UMSATZ_BRUTTO
	, BON_UMSATZ_BRUTTO_MIX
	, BON_UMSATZ_BRUTTO
	, BON_UMSATZ_BRUTTO_WVJ
	, UMS_NETTO_PLAN
	, UMS_NETTO_WVJ
	) AS
-- 2020-08-17 ssch0611 : initial - AP0053793 VTC Smartphone
-- 2020-09-23 ssch0611 : added bon_verkauf/bon_retoure), replaced umsatz (kopf with verkauf/retoure) 
-- 2024-10-16 muellerpatri : Filter auf wg_id <> 961 hinzugefügt [SPEC0276475]
-- 2025-09-08 tekin: Correcting mapping of previous year values that are missing when a store gets another wup_id (Filialumgliederung)
WITH vis01 AS (
-- previous year values
	SELECT vis0.mandant_id
		, vis0.nb_id
		, vis0.wup_id
		, vis0.wrg_id
		, vis0.dat
		, bn_agg.dat AS dat_wvj
		, vis0.ums_netto_plan
		, vis0.ums_netto_wvj
		, bn_agg.zeit_stunde
		, bn_agg.bon_kunden_anz_wvj
		, bn_agg.bon_kassen_anz_wvj
		, bn_agg.bon_umsatz_brutto_wvj
		, bn_agg.bon_umsatz_netto_wvj
		, bn_agg.bon_anz_artikel_wvj -- not used (anz bonzeilen)
	FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup vis0
	INNER JOIN (
		-- AGG_15
		SELECT agg.mandant_id
			, agg.wup_id
			, agg.wrg_id
			, agg.dat --CURRENT_DATE AS dat 
			, agg.zeit_stunde
			, SUM(agg.anz_kunden) AS bon_kunden_anz_wvj
			, COUNT(DISTINCT agg.kasse_nr) AS bon_kassen_anz_wvj
			, SUM(agg.umsatz_brutto) AS bon_umsatz_brutto_wvj
			, SUM(agg.umsatz_netto) AS bon_umsatz_netto_wvj
			, SUM(agg.anz_artikel) AS bon_anz_artikel_wvj
		FROM (
			SELECT agg.mandant_id
				, agg.wup_id
				, mdt.default_wrg AS wrg_id
				, agg.dat
				, agg.zeit_stunde
				, agg.kasse_nr
				, agg.anz_kunden
				, agg.umsatz_brutto
				, agg.umsatz_netto
				, agg.anz_artikel
			FROM dbp_v_ods.v_ods_bon_agg_15min agg
			JOIN dbp_view.v_mandant mdt
				ON mdt.mandant_id = agg.mandant_id
			WHERE agg.dat = CURRENT_DATE - 364
			UNION ALL -- AGG_15 in EUR
			SELECT agg.mandant_id
				, agg.wup_id
				, krs.nach_wrg_id AS wrg_id
				, agg.dat
				, agg.zeit_stunde
				, agg.kasse_nr
				, agg.anz_kunden
				, agg.umsatz_brutto * krs.umrechnungskurs AS umsatz_brutto
				, agg.umsatz_netto * krs.umrechnungskurs AS umsatz_netto
				, agg.anz_artikel
			FROM dbp_v_ods.v_ods_bon_agg_15min agg
			JOIN dbp_view.v_mandant mdt
				ON mdt.mandant_id = agg.mandant_id
					AND mdt.default_wrg <> 'EUR'
			JOIN dbp_view.v_kurs krs
				ON krs.von_wrg_id = mdt.default_wrg
					AND krs.kurstyp_id = 3
					AND krs.dat_bis = TO_DATE('99991231', 'YYYYMMDD')
			WHERE agg.dat = CURRENT_DATE - 364
			) agg
		GROUP BY agg.mandant_id
			, agg.wup_id
			, agg.wrg_id
			, agg.dat
			, agg.zeit_stunde
		) bn_agg
		ON vis0.mandant_id = bn_agg.mandant_id
			AND vis0.wup_id = bn_agg.wup_id
			AND vis0.wrg_id = bn_agg.wrg_id
			AND vis0.dat = bn_agg.dat + 364
	WHERE vis0.nb_id = 0
		AND vis0.dat = CURRENT_DATE
	),
vis02 AS (
	SELECT vis0.mandant_id
		, vis0.nb_id
		, vis0.wup_id
		, vis0.wrg_id
		, vis0.dat
		, vis0.ums_netto_plan
		, vis0.ums_netto_wvj
		, bn_kpf.zeit_stunde
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
		-- BON_Kopf-Verkauf-Retoure
		SELECT bnk.mandant_id
			, bnk.wup_id
			, bnk.wrg_id
			, bnk.bon_dat
			, EXTRACT(HOUR FROM bnk.bon_ende) AS zeit_stunde
			, MIN(bnk.bon_ende) AS bon_ende_min
			, MAX(bnk.bon_ende) AS bon_ende_max
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
				, bnk.wrg_id
				, bnk.bon_dat
				, bnk.bon_beginn
				, bnk.bon_ende
				, bnk.bon_id
				, bnk.kasse_nr
				, bnk.umsatz_brutto AS kpf_ums_brutto
				, (bnk.umsatz_brutto - bnk.umsatz_mwst) AS kpf_ums_netto
				, bnv.ums_brutto AS vkf_ums_brutto
				, bnv.ums_netto AS vkf_ums_netto
				, bnv.menge AS vkf_menge
				, bnr.ums_brutto AS rtr_ums_brutto
				, bnr.ums_netto AS rtr_ums_netto
				, bnr.menge AS rtr_menge
			FROM dbp_v_ods.v_ods_bon_kopf bnk
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
				WHERE v.wg_id <> 961
				GROUP BY v.mandant_id
					, v.wup_id
					, v.bon_dat
					, v.bon_id
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
				WHERE r.wg_id <> 961
				GROUP BY r.mandant_id
					, r.wup_id
					, r.bon_dat
					, r.bon_id
				) bnr
				ON bnk.bon_id = bnr.bon_id
					AND bnk.wup_id = bnr.wup_id
					AND bnk.mandant_id = bnr.mandant_id
					AND bnk.bon_dat = bnr.bon_dat
			WHERE (bnk.bon_id, bnk.wup_id, bnk.mandant_id) NOT IN (SELECT bon_id, wup_id, mandant_id FROM dbp_v_ods.v_ods_bon_storno)
				AND bnk.turnover_fg = 1
				AND bnk.bon_dat = CURRENT_DATE
			UNION ALL -- BON_Kopf-Verkauf-Retoure in EUR 
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
			JOIN dbp_view.v_mandant mdt
				ON mdt.mandant_id = bnk.mandant_id
					AND mdt.default_wrg <> 'EUR'
			JOIN dbp_view.v_kurs krs
				ON krs.von_wrg_id = bnk.wrg_id
					AND krs.kurstyp_id = 3
					AND krs.dat_bis = TO_DATE('99991231', 'YYYYMMDD')
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
						AND v.bon_dat BETWEEN vm.dat_von
							AND vm.dat_bis
				WHERE v.wg_id <> 961
				GROUP BY v.mandant_id
					, v.wup_id
					, v.bon_dat
					, v.bon_id
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
					, SUM((r.umsatz_brutto / 100) * (rm.mwst + 100)) AS ums_netto
					, SUM(r.menge) AS menge
				FROM dbp_v_ods.v_ods_bon_retoure r
				INNER JOIN dbp_view.v_mwst_per rm
					ON r.mandant_id = rm.mandant_id
						AND r.mwst_id = rm.mwst_id
						AND r.bon_dat BETWEEN rm.dat_von AND rm.dat_bis
				WHERE r.wg_id <> 961
				GROUP BY r.mandant_id
					, r.wup_id
					, r.bon_dat
					, r.bon_id
				) bnr
				ON bnk.bon_id = bnr.bon_id
					AND bnk.wup_id = bnr.wup_id
					AND bnk.mandant_id = bnr.mandant_id
					AND bnk.bon_dat = bnr.bon_dat
			WHERE (bnk.bon_id, bnk.wup_id, bnk.mandant_id) NOT IN (SELECT bon_id, wup_id, mandant_id FROM dbp_v_ods.v_ods_bon_storno)
				AND bnk.turnover_fg = 1
				AND bnk.bon_dat = CURRENT_DATE
			) bnk
		GROUP BY bnk.mandant_id
			, bnk.wup_id
			, bnk.wrg_id
			, bnk.bon_dat
			, zeit_stunde
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
	, vis01.zeit_stunde AS z1 -- AGG_15
	, vis02.zeit_stunde AS z2 -- BON_Kopf
	, vis02.bon_ende_min
	, vis02.bon_ende_max
	, vis02.bon_kunden_anz
	, vis01.bon_kunden_anz_wvj
	, vis02.bon_kassen_anz
	, vis01.bon_kassen_anz_wvj
	, vis02.bon_vkf_umsatz_netto
	, vis02.bon_rtr_umsatz_netto
	, vis02.bon_kpf_umsatz_netto
	, COALESCE(NULLIF(COALESCE(bon_vkf_umsatz_netto, 0) + COALESCE(bon_rtr_umsatz_netto, 0), 0), bon_kpf_umsatz_netto) AS bon_umsatz_netto_mix -- test
	, NULLIF(COALESCE(bon_vkf_umsatz_netto, 0) + COALESCE(bon_rtr_umsatz_netto, 0), 0) AS bon_umsatz_netto -- verkauf/retoure
	, vis01.bon_umsatz_netto_wvj
	, vis02.bon_vkf_umsatz_brutto
	, vis02.bon_rtr_umsatz_brutto
	, vis02.bon_kpf_umsatz_brutto
	, COALESCE(NULLIF(COALESCE(bon_vkf_umsatz_brutto, 0) + COALESCE(bon_rtr_umsatz_brutto, 0), 0), bon_kpf_umsatz_brutto) AS bon_umsatz_brutto_mix -- test
	, NULLIF(COALESCE(bon_vkf_umsatz_brutto, 0) + COALESCE(bon_rtr_umsatz_brutto, 0), 0) AS bon_umsatz_brutto -- verkauf/retoure
	, vis01.bon_umsatz_brutto_wvj
	, COALESCE(vis01.ums_netto_plan, vis02.ums_netto_plan) AS ums_netto_plan
	, COALESCE(vis01.ums_netto_wvj, vis02.ums_netto_wvj) AS ums_netto_wvj
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
;
