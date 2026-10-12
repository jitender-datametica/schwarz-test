CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_MONAT_MANDANT_SUM_1
AS

/*
	FAKT-AGGREGAT Umsatz / Kunden / Personal pro Monat_1 - NB_1 / Mandant_1
	vorhandene view >> neues Aggregat vis_monat_ums_kunde_pers_wup_1
	2010KW28 3stellige WG / neues Aggregat
	2025-05-23 ssch0611 : Review (kum Spalten entfernt) [AP0263159]
*/

SELECT v01.mandant_id
	, v01.nb_id
	, v01.wrg_id AS umsatz_wrg
	, v01.kjmo
	, SUM(v01.ums_netto) AS umsatz_netto
	, SUM(v01.ums_netto_kvj) AS umsatz_netto_vj
	, SUM(v01.ums_netto_kvvj) AS umsatz_netto_vvj
	, SUM(v01.ums_netto_plan) AS umsatz_netto_plan
	, SUM(v01.anz_kunde) AS kunde_anz
	, SUM(v01.anz_kunde_kvj) AS kunde_anz_vj
	, SUM(v01.anz_kunde_kvvj) AS anz_kunde_kvvj -- NEUE SPALTE
	, SUM(v01.anz_offen) AS offen_anz
	, SUM(v01.anz_offen_kvj) AS offen_anz_vj
	, SUM(v01.anz_offen_kvvj) AS offen_anz_vvj
	, SUM(v01.pers_kosten) AS pk_ker
	, SUM(v01.pers_kosten_kvj) AS pk_ker_vj
	, SUM(v01.pers_kosten_plan) AS pk_ker_plan
	, SUM(v01.rohertrag) AS rohertrag
	, SUM(v01.rohertrag_kvj) AS rohertrag_vj
	, SUM(v01.rohertrag_plan) AS rohertrag_plan
	, SUM(v01.pers_std) AS pers_stunden
	, SUM(v01.pers_std_kvj) AS pers_stunden_vj
	, SUM(v01.pers_std_plan) AS pers_stunden_plan
	, SUM(v01.pers_auq) AS pers_kranktage
	, SUM(v01.pers_auq_kvj) AS pers_kranktage_vj
	, CASE WHEN SUM(v01.pers_auq) <> 0 THEN 1 ELSE 0 END AS pers_anz
	, CASE WHEN SUM(v01.pers_auq_kvj) <> 0 THEN 1 ELSE 0 END AS pers_anz_vj
	, CASE WHEN SUM(v01.pers_fluq) <> 0 THEN 1 ELSE 0 END AS pers_anz_tage
	, CASE WHEN SUM(v01.pers_fluq_kvj) <> 0 THEN 1 ELSE 0 END AS pers_anz_tage_vj
	, SUM(v01.ums_netto_plan) AS ums_n_ker_plan
	, SUM(v01.ums_netto_kvj) AS ums_n_ker_vj
	, SUM(v01.ums_netto_kvvj) AS ums_n_ker_vvj
	, SUM(v01.pers_kosten) AS pers_kosten
	, SUM(v01.pers_kosten_kvj) AS pers_kosten_vj
FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 v01

GROUP BY ALL
;