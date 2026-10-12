CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_PUK_WUP_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	VKL_ID,
	GF_ID,
	VS_ID,
	WRG_ID,
	KJMO,
	UMS_NETTO,
	UMS_NETTO_KVJ,
	UMS_NETTO_PLAN,
	UMS_NETTO_FRISCHE,
	UMS_NETTO_FRISCHE_KVJ,
	ANZ_KUNDE,
	ANZ_KUNDE_KVJ,
	PERS_STD,
	PERS_STD_KVJ,
	PERS_STD_PLAN,
	PERS_KOSTEN,
	PERS_KOSTEN_KVJ,
	PERS_KOSTEN_PLAN,
	MENGE,
	MENGE_KVJ,
	MENGE_FRISCHE,
	MENGE_FRISCHE_KVJ,
	KASSIERZEIT,
	KASSIERZEIT_KVJ,
	SCANZEIT,
	SCANZEIT_KVJ,
	ABSCHRIFT_OP,
	ABSCHRIFT_OP_KVJ,
	ABSCHRIFT_OP_FRISCHE,
	ABSCHRIFT_OP_FRISCHE_KVJ
) AS

/*
		FAKT-AGGREGAT PUK - Personal und Kennzahlen pro Filiale/Monat_1
		Join relevanten Stammdaten + Anreicherung Fakten bis Vormonat
		2019.0730 INITIAL
		2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
		2025-05-23 ssch0611 : Review (menge_absatz alias) [AP0263159]
*/

SELECT vis.mandant_id
	, vis.nb_id
	, wup.aktuell_wup_id AS wup_id
	, wup.vkl_id
	, wup.gf_id
	, wup.vs_id
	, vis.wrg_id
	, vis.kjmo
	, vis.ums_netto
	, vis.ums_netto_kvj
	, vis.ums_netto_plan
	, uwg.sum_ums_netto_frische       AS ums_netto_frische
	, uwg.sum_ums_netto_frische_kvj   AS ums_netto_frische_kvj
	, vis.anz_kunde
	, vis.anz_kunde_kvj
	, vis.pers_std
	, vis.pers_std_kvj
	, vis.pers_std_plan
	, vis.pers_kosten
	, vis.pers_kosten_kvj
	, vis.pers_kosten_plan
	, uwg.sum_menge                   AS menge
	, uwg.sum_menge_kvj               AS menge_kvj
	, uwg.sum_menge_frische           AS menge_frische
	, uwg.sum_menge_frische_kvj       AS menge_frische_kvj
	, vtk.sum_kassierzeit             AS kassierzeit
	, vtk_kvj.sum_kassierzeit         AS kassierzeit_kvj
	, vtk.sum_scanzeit                AS scanzeit
	, vtk_kvj.sum_scanzeit            AS scanzeit_kvj
	, awg.sum_abschrift_netto         AS abschrift_op
	, awg.sum_abschrift_netto_kvj     AS abschrift_op_kvj
	, awg.sum_abschrift_frische       AS abschrift_op_frische
	, awg.sum_abschrift_frische_kvj   AS abschrift_op_frische_kvj
	
FROM dbp_msi_data.vis_monat_ums_kunde_pers_wup_1  vis

INNER JOIN dbp_data.wup_1 wup_1
	ON vis.wup_id = wup.wup_id AND vis.mandant_id = wup.mandant_id

LEFT JOIN (
	SELECT mandant_id
		, wup_id
		, nb_id
		, wrg_id
		, kjmo
		, SUM(menge_absatz)								AS sum_menge
		, SUM(menge_absatz_kvj)							AS sum_menge_kvj
		, SUM(IFF(abt_id = 5, menge_absatz, 0.00))		AS sum_menge_frische
		, SUM(IFF(abt_id = 5, menge_absatz_kvj, 0.00))	AS sum_menge_frische_kvj
		, SUM(IFF(abt_id = 5, ums_netto, 0.00))			AS sum_ums_netto_frische
		, SUM(IFF(abt_id = 5, ums_netto_kvj, 0.00))		AS sum_ums_netto_frische_kvj
	FROM dbp_msi_data.vis_monat_umsatz_wg_1

	GROUP BY ALL
) uwg
ON vis.wup_id = uwg.wup_id AND vis.mandant_id = uwg.mandant_id AND vis.kjmo = uwg.kjmo 
AND vis.wrg_id = uwg.wrg_id

LEFT JOIN (
	SELECT vtk.mandant_id
		, vtk.wup_id
		, vtk.nb_id
		, zeit.kjmo
		, SUM(vtk.kassierzeit)			AS sum_kassierzeit
		, SUM(vtk.registrierzeit / 60)	AS sum_scanzeit
	FROM dbp_data.vis_tag_kasse_1  vtk
	INNER JOIN dbp_data.tag_1 zeit_1
		ON zeit.dat = vtk.dat
	LEFT OUTER JOIN dbp_data.kasse_typ_per_1 ktp
		ON vtk.mandant_id = ktp.mandant_id AND vtk.wup_id = ktp.wup_id
		AND vtk.kasse_nr = ktp.kasse_nr AND vtk.dat BETWEEN ktp.dat_von AND ktp.dat_bis

	WHERE COALESCE(ktp.kasse_typ_id, vtk.kasse_typ_id) = 1

	GROUP BY ALL
) vtk
ON vis.wup_id = vtk.wup_id AND vis.mandant_id = vtk.mandant_id AND vis.kjmo = vtk.kjmo

LEFT JOIN (
	SELECT vtk.mandant_id
		, vtk.wup_id
		, vtk.nb_id
		, zeit.kjmo
		, SUM(vtk.kassierzeit) 			AS sum_kassierzeit
		, SUM(vtk.registrierzeit / 60)	AS sum_scanzeit
	FROM dbp_data.vis_tag_kasse_1  vtk
	INNER JOIN dbp_data.tag_1 zeit_1
		ON zeit.dat = vtk.dat
	LEFT OUTER JOIN dbp_data.kasse_typ_per_1 ktp
		ON vtk.mandant_id = ktp.mandant_id AND vtk.wup_id = ktp.wup_id
		AND vtk.kasse_nr = ktp.kasse_nr AND vtk.dat BETWEEN ktp.dat_von AND ktp.dat_bis

	WHERE COALESCE(ktp.kasse_typ_id, vtk.kasse_typ_id) = 1

	GROUP BY ALL
 ) vtk_kvj
ON vis.wup_id = vtk_kvj.wup_id AND vis.mandant_id = vtk_kvj.mandant_id
AND vis.kjmo = (vtk_kvj.kjmo + 100)

LEFT JOIN (
	SELECT awg.mandant_id
		, awg.wup_id
		, awg.nb_id
		, awg.wrg_id
		, awg.kjmo
		, SUM(CASE WHEN awg.mandant_id = 6 AND awg.abschriftart_id = 2 THEN 1 WHEN awg.mandant_id = 3 AND awg.abschriftart_id = 11 THEN 1 WHEN awg.mandant_id IN (2, 5, 7, 8) AND awg.abschriftart_id = 7 THEN 1 WHEN awg.mandant_id IN (2, 5) AND awg.abschriftart_id = 10 THEN 1 ELSE -1 END * awg.abschrift_netto) AS sum_abschrift_netto
		, SUM(CASE WHEN awg.mandant_id = 6 AND awg.abschriftart_id = 2 THEN 1 WHEN awg.mandant_id = 3 AND awg.abschriftart_id = 11 THEN 1 WHEN awg.mandant_id IN (2, 5, 7, 8) AND awg.abschriftart_id = 7 THEN 1 WHEN awg.mandant_id IN (2, 5) AND awg.abschriftart_id = 10 THEN 1 ELSE -1 END * awg.abschrift_netto_kvj) AS sum_abschrift_netto_kvj
		, SUM(CASE WHEN awg.abt_id IN (5) THEN CASE WHEN awg.mandant_id = 6 AND awg.abschriftart_id = 2 THEN 1 WHEN awg.mandant_id = 3 AND awg.abschriftart_id = 11 THEN 1 WHEN awg.mandant_id IN (2, 5, 7, 8) AND awg.abschriftart_id = 7 THEN 1 WHEN awg.mandant_id IN (2, 5) AND awg.abschriftart_id = 10 THEN 1 ELSE -1 END * awg.abschrift_netto ELSE 0.00 END) AS sum_abschrift_frische
		, SUM(CASE WHEN awg.abt_id IN (5) THEN CASE WHEN awg.mandant_id = 6 AND awg.abschriftart_id = 2 THEN 1 WHEN awg.mandant_id = 3 AND awg.abschriftart_id = 11 THEN 1 WHEN awg.mandant_id IN (2, 5, 7, 8) AND awg.abschriftart_id = 7 THEN 1 WHEN awg.mandant_id IN (2, 5) AND awg.abschriftart_id = 10 THEN 1 ELSE -1 END * awg.abschrift_netto_kvj ELSE 0.00 END) AS sum_abschrift_frische_kvj
	FROM dbp_msi_data.vis_tag_abschriften_wg_1 awg
	INNER JOIN (
		SELECT  aiz.mandant_id, aiz.abschriftart_id FROM dbp_data.abschriftart_int_zu_1 aiz
		WHERE (abschriftart_int_id) IN (
			SELECT abschriftart_int_id FROM dbp_data.l_abschriftart_int_1 
			WHERE abschriftart_thema_int_id IN (1,4)
			)
	) aiz
	ON awg.mandant_id = aiz.mandant_id AND awg.abschriftart_id = aiz.abschriftart_id
	
	GROUP BY ALL
 ) awg
ON vis.wup_id = awg.wup_id AND vis.mandant_id = awg.mandant_id AND vis.kjmo = awg.kjmo AND vis.wrg_id = awg.wrg_id

WHERE MOD(vis.kjmo, 100) <> 13
AND vis.nb_id = 0
;