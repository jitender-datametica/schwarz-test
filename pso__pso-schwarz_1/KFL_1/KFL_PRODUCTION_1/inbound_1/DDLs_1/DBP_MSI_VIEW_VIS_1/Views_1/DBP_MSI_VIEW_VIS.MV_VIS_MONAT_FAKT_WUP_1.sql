CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WUP_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	KJMO,
	MO_KJ,
	UMS_NETTO,
	UMS_NETTO_KVJ,
	UMS_NETTO_KVVJ,
	UMS_NETTO_PLAN,
	UMS_NETTO_PLAN_EXTERN,
	UMS_NETTO_PLAN_X,
	ANZ_KUNDE,
	ANZ_KUNDE_KVJ,
	ANZ_KUNDE_KVVJ,
	ANZ_OFFEN,
	ANZ_OFFEN_KVJ,
	ANZ_OFFEN_KVVJ,
	PERS_STD,
	PERS_STD_KVJ,
	PERS_STD_PLAN,
	PERS_KOSTEN,
	PERS_KOSTEN_KVJ,
	PERS_KOSTEN_PLAN,
	PERS_K_OHNE,
	PERS_K_OHNE_KVJ,
	PERS_K_OHNE_PLAN,
	ROHERTRAG,
	ROHERTRAG_KVJ,
	ROHERTRAG_PLAN,
	PERS_AUQ,
	PERS_AUQ_KVJ,
	PERS_FLUQ,
	PERS_FLUQ_KVJ,
	NL_IST,
	NL_PLAN
) AS

/*
	FAKT-AGGREGAT Umsatz/Kunden/Personal-Kosten-Stunden_1-Quoten pro Monat_1 - WUP_1
	2011KW07 INITIAL
	2011KW18 Erweiterung PK ohne Abgrenz
	2019.0220 ssch0611 : Erweiterung Filialebene2 (Nettoleistung)
	2019.0314 ssch0611 : Erweiterung ums_netto_plan_extern
	2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH] -> Ausbauen von NL_ABW
	2025-05-23 ssch0611 : Review (kum Spalten entfernt, inkl. pers_kum) [AP0263159]
*/

SELECT vis.mandant_id
	, vis.nb_id
	, wup.aktuell_wup_id	AS wup_id 
	, vis.wrg_id
	, vis.kjmo
	, vis.mo_kj
	/* Umsatz netto */
	, vis.ums_netto
	, vis.ums_netto_kvj
	, vis.ums_netto_kvvj
	/* Umsatz Plan CO (Standard/intern) */
	, vis.ums_netto_plan
	 /* Umsatz Plan extern (für SDL Reporting) */
	, vis.ums_netto_plan_extern 
	, IFF(vis.ums_netto_plan_extern <> 0, vis.ums_netto_plan_extern, vis.ums_netto_plan)	AS ums_netto_plan_x 
	/* Anzahl Kunden */
	, vis.anz_kunde
	, vis.anz_kunde_kvj
	, vis.anz_kunde_kvvj
	/* Öffnungstage */
	, vis.anz_offen
	, vis.anz_offen_kvj
	, vis.anz_offen_kvvj
	/* Nettostunden */
	, vis.pers_std
	, vis.pers_std_kvj
	, vis.pers_std_plan
	/* Personalkosten_1 */
	, vis.pers_kosten
	, vis.pers_kosten_kvj
	, vis.pers_kosten_plan
	/* Personalkosten_1 ohne Abgrenzung (veraltet) */
	, vis.pers_k_ohne
	, vis.pers_k_ohne_kvj
	, vis.pers_k_ohne_plan
	/* Rohertrag (veraltet) */
	, vis.rohertrag
	, vis.rohertrag_kvj
	, vis.rohertrag_plan
	/* Personalkennzahlen (veraltet) */
	, vis.pers_auq
	, vis.pers_auq_kvj
	, vis.pers_fluq
	, vis.pers_fluq_kvj
	, vis.ums_netto      / NULLIFZERO(vis.pers_std)			AS NL_IST
	, vis.ums_netto_plan / NULLIFZERO(vis.pers_std_plan)	AS NL_PLAN
FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 vis

INNER JOIN dbp_view.v_wup_1 wup_1
	ON vis.mandant_id = wup.mandant_id AND vis.wup_id = wup.wup_id
;