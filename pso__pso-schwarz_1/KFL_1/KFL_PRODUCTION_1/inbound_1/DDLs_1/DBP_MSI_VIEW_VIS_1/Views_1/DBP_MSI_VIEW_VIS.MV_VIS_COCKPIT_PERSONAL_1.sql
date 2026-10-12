CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_COCKPIT_PERSONAL_1
AS

/*
	FAKT/AGGREGAT VIS Cockpit Personal pro wup_1 (zeitlos)
	BASIS: vis_monat_ums_kunde_pers_wup_1
	Cockpit-Variante: 0 Monat_1 + 1 GJ kum.
	2011KW18 INITIAL
	kkaiser 20150409 NULLIFZERO eingebaut bei expber_fg und stdleist_nat_kvj, stdlohn_nat_kvj
	2025-05-23 ssch0611 : Review (Block cockpit_variante 1 inkl. kum Spalten entfernt) [AP0263159]
*/

SELECT s01.mandant_id
	, s01.nb_id
	, s01.wup_id
	, s01.wrg_id
	, s01.kjmo
	, SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date((s01.kjmo * 100) - 18999999) AS p_dat_von
	, ADD_MONTHS(SNOWCONVERT.PUBLIC.teradata_numeric_date_to_date((s01.kjmo * 100) - 18999999), 1) - 1 AS p_dat_bis
	, CAST('(' || CAST(p_dat_von AS VARCHAR) || ' - ' || CAST(p_dat_bis AS VARCHAR) || ')' AS VARCHAR(30)) AS p_zeit_akt
	, CAST('(' || CAST(ADD_MONTHS(p_dat_von, - 12) AS VARCHAR) || ' - ' || CAST(ADD_MONTHS(p_dat_bis, - 12) AS VARCHAR) || ')' AS VARCHAR(30)) AS p_zeit_vor
	, s01.expber_fg
	, 0::BYTEINT AS cockpit_variante
	, s01.pk_rang
	, s01.pk_nat
	, s01.stdleist_rang
	, s01.stdleist_nat
	, s01.stdlohn_rang
	, s01.stdlohn_nat
	, s01.p_ums_ist
	, s01.p_ums_kvj
	, s01.p_pk_ist
	, s01.p_pk_kvj
	, s01.p_ohne_ist
	, s01.p_ohne_kvj
	, s01.p_std_ist
	, s01.p_std_kvj

FROM (
	SELECT v01.mandant_id
		, v01.nb_id
		, v01.wup_id
		, v02.expber_fg
		, v01.wrg_id
		, v01.kjmo
		, v01.ums_netto AS p_ums_ist
		, v01.ums_netto_kvj AS p_ums_kvj
		, v01.pers_kosten AS p_pk_ist
		, v01.pers_kosten_kvj AS p_pk_kvj
		, v01.pers_k_ohne AS p_ohne_ist
		, v01.pers_k_ohne_kvj AS p_ohne_kvj
		, v01.pers_std AS p_std_ist
		, v01.pers_std_kvj AS p_std_kvj
		, (v01.pers_kosten * 100.0000) / CASE WHEN v01.ums_netto = 0 THEN NULL ELSE v01.ums_netto END AS pk_wup_ist
		, (v01.pers_kosten_kvj * 100.0000) / CASE WHEN v01.ums_netto_kvj = 0 THEN NULL ELSE v01.ums_netto_kvj END AS pk_wup_kvj
		, pk_wup_ist * expber_fg - CASE WHEN pk_wup_kvj * expber_fg = 0 THEN NULL ELSE pk_wup_kvj * expber_fg END AS pk_wup_abw
		, expber_fg * RANK() OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, expber_fg DESC NULLS LAST, pk_wup_abw DESC NULLS LAST) AS pk_rang
		, AVG(v01.pers_kosten * expber_fg * 100.0000) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			/ CASE 
				WHEN AVG(v01.ums_netto * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) = 0 THEN NULL 
				ELSE AVG(v01.ums_netto * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			END AS pk_nat_ist
		, AVG(v01.pers_kosten_kvj * expber_fg * 100.0000) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			/ CASE 
				WHEN AVG(v01.ums_netto_kvj * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) = 0 THEN NULL 
				ELSE AVG(v01.ums_netto_kvj * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			END AS pk_nat_kvj
		, ZEROIFNULL(pk_nat_ist - pk_nat_kvj)::DECIMAL(9, 4) AS pk_nat
		, (v01.ums_netto) / CASE WHEN v01.pers_std = 0 THEN NULL ELSE v01.pers_std END AS stdleist_wup_ist
		, (v01.ums_netto_kvj) / CASE WHEN v01.pers_std_kvj = 0 THEN NULL ELSE v01.pers_std_kvj END AS stdleist_wup_kvj
		, (stdleist_wup_ist - CASE WHEN stdleist_wup_kvj = 0 THEN NULL ELSE stdleist_wup_kvj END) * expber_fg * 100.0000 / CASE WHEN stdleist_wup_kvj * expber_fg = 0 THEN NULL ELSE stdleist_wup_kvj * expber_fg END AS stdleist_wup_abw
		, expber_fg * RANK() OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, expber_fg DESC NULLS LAST, stdleist_wup_abw DESC NULLS LAST) AS stdleist_rang
		, AVG(v01.ums_netto * expber_fg * 1.0000) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			/ CASE 
				WHEN AVG(v01.pers_std * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) = 0 THEN NULL 
				ELSE AVG(v01.pers_std * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			END AS stdleist_nat_ist
		, AVG(v01.ums_netto_kvj * expber_fg * 1.0000) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			/ CASE 
				WHEN AVG(v01.pers_std_kvj * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) = 0 THEN NULL 
				ELSE AVG(v01.pers_std_kvj * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			END AS stdleist_nat_kvj
		, ZEROIFNULL((stdleist_nat_ist - stdleist_nat_kvj) * 100.0000 / CASE WHEN stdleist_nat_kvj = 0 THEN NULL ELSE stdleist_nat_kvj END)::DECIMAL(9, 4) AS stdleist_nat
		, (v01.pers_k_ohne) / CASE WHEN v01.pers_std = 0 THEN NULL ELSE v01.pers_std END AS stdlohn_wup_ist
		, (v01.pers_k_ohne_kvj) / CASE WHEN v01.pers_std_kvj = 0 THEN NULL ELSE v01.pers_std_kvj END AS stdlohn_wup_kvj
		, (stdlohn_wup_ist - CASE WHEN stdlohn_wup_kvj = 0 THEN NULL ELSE stdlohn_wup_kvj END) * expber_fg * - 100.0000 / CASE WHEN stdlohn_wup_kvj * expber_fg = 0 THEN NULL ELSE stdlohn_wup_kvj * expber_fg END AS stdlohn_wup_abw
		, expber_fg * RANK() OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, expber_fg DESC NULLS LAST, stdlohn_wup_abw DESC NULLS LAST) AS stdlohn_rang
		, AVG(v01.pers_k_ohne * expber_fg * 1.0000) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			/ CASE 
				WHEN AVG(v01.pers_std * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) = 0 THEN NULL 
				ELSE AVG(v01.pers_std * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			END AS stdlohn_nat_ist
		, AVG(v01.pers_k_ohne_kvj * expber_fg * 1.0000) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			/ CASE 
				WHEN AVG(v01.pers_std_kvj * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) = 0 THEN NULL 
				ELSE AVG(v01.pers_std_kvj * expber_fg) OVER (PARTITION BY v01.mandant_id, v01.nb_id, v01.wrg_id ORDER BY v01.mandant_id, v01.nb_id, v01.wup_id) 
			END AS stdlohn_nat_kvj
		, ZEROIFNULL((stdlohn_nat_ist - stdlohn_nat_kvj) * - 100.0000 / CASE WHEN stdlohn_nat_kvj = 0 THEN NULL ELSE stdlohn_nat_kvj END)::DECIMAL(9, 4) AS stdlohn_nat
	FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 v01
	
	INNER JOIN (
		SELECT mandant_id
			, nb_id
			, wup_id
			, MIN(altersstruktur_tag_id) AS alter_min
			, CASE WHEN alter_min < 3 THEN 1 ELSE 0 END AS expber_fg
		FROM dbp_msi_v_view.v_altersstruktur_eis_1
		WHERE nb_id = 0 -- OR wup_id = 0
		GROUP BY ALL
		) v02
		ON v01.mandant_id = v02.mandant_id AND v01.wup_id = v02.wup_id AND v01.nb_id = v02.nb_id
	
	INNER JOIN (
		SELECT mandant_id
			, nb_id
			, wup_id
		FROM dbp_view.v_wup_1
		WHERE nb_id = 0
		) v03
		ON v01.mandant_id = v03.mandant_id AND v01.wup_id = v03.wup_id AND v01.nb_id = v03.nb_id
	
	INNER JOIN dbp_view.v_l_buchungsstatus_ker_1 v04
		ON v01.kjmo = v04.kj_ker_mo_id
	
	WHERE (v01.mandant_id = 1 AND v04.akt_fruehinfo1 = 0) OR (v01.mandant_id <> 1 AND v04.akt_fruehinfo2 = 0)
	) s01

/*
	cockpit_variante 2 (GJ kum. Werte) komplett entfernt 
*/

;
