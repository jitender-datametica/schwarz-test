CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WBS_REPLENISHMENT(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DIFF_TAGE,
	AKTION_ID_SET,
	KJWO_VON,
	DAT_VON,
	DAT_BIS,
	WTAG_ID_VON,
	MUTTER_WB_ID,
	ANZ_AKT_SELBE_DAUER,
	AKTION_RANG,
	AKTION_LABEL,
	AKTION_DAT_VON,
	AKTION_DAT_BIS,
	MENGE,
	KORRIGIERTE_MENGE,
	SALES_FG,
	MENGE_AF_2WO,
	PERC_UPLIFT,
	WMAPE,
	RMSE,
	BIAS,
	IN_GRUPPE_FG,
	TV_FG,
	TITELSEITE_FG,
	RUECKSEITE_FG,
	MIT_HISTORIE_FG,
	VK_AKTION_BRUTTO,
	VK_VOR_AKTION_BRUTTO,
	ANZ_ART_IN_GRUPPE,
	ANZ_ART_IN_GRUPPE_REFERENZPERIODE,
	KJWO_HIST_AKTION,
	FAKTOR_FLAKI_HIST_AKTION,
	MENGE_HIST_AKTION,
	MENGE_AKTIONSSTART_HIST_AKTION,
	MENGE_WE_ZENTRALE_HIST_AKTION,
	ANZAHL_NULLBESTAND_HIST_AKTION,
	ANZAHL_TAGE_AKTION_HIST_AKTION,
	MENGE_HISTORIE_AF_HIST_AKTION,
	SOLLBESTAND_HIST_AKTION,
	MIN_SICHERH_BESTAND_HIST_AKTION,
	MENGE_ENDBESTAND_HIST_AKTION,
	UMSATZ_NETTO_HIST_AKTION,
	ANTEIL_WUP_ABVK,
	ABWEICHUNG_FG,
	GK_HISTORY_FG,
	MANDANT_ID_VZ,
	DAT_BELADUNG
) AS
--AP0048550 | Spec0112697 | 20210601 | cbru1709 | add new fields
--2022-09-27, dknop, adding avq_relevant_fg=1
--20221028, dknop, changing to COALESCE(wkw.avq_relevant_fg,1)
--20230216, richternic, Filterung auf wkw.avq_relevant_fg rausnehmen
--2024-08-06,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2025-10-23, nw, add 1=0 to deactivate materialization
SELECT
v01.mandant_id,
--v01.wup_id,
--CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END wup_id, 
v05.aktuell_wup_id wup_id, 
v01.nb_id,
v01.art_id,
v01.diff_tage,
v01.aktion_id_set,
v01.kjwo_von,
v01.dat_von,
v01.dat_bis,
v01.wtag_id_von,
v01.mutter_wb_id,
v01.anz_akt_selbe_dauer,
v01.aktion_rang,
v01.aktion_label,
v01.aktion_dat_von,
v01.aktion_dat_bis,
v01.menge,
v01.korrigierte_menge,
COALESCE(v01.sales_fg,0) AS sales_fg,
v01.menge_af_2wo,
v01.perc_uplift,
v01.wmape,
v01.rmse,
bias,
COALESCE(v01.in_gruppe_fg,0) AS in_gruppe_fg,
COALESCE(v01.tv_fg,0) AS tv_fg,
COALESCE(v01.titelseite_fg,0) AS titelseite_fg,
COALESCE(v01.rueckseite_fg,0) AS rueckseite_fg,
COALESCE(v01.mit_historie_fg,0) AS mit_historie_fg,
v01.vk_aktion_brutto,
v01.vk_vor_aktion_brutto,
v01.anz_art_in_gruppe,
v01.anz_art_in_gruppe_referenzperiode,
v02.kjwo AS kjwo_hist_aktion,
wkw1.faktor_flaki AS faktor_flaki_hist_aktion,
(wkw1.menge_tag1 + wkw1.menge_tag2 + wkw1.menge_tag3 + wkw1.menge_tag4 + wkw1.menge_tag5 + wkw1.menge_tag6 + wkw1.menge_tag7) AS menge_hist_aktion,
wkw1.menge_aktionsstart AS menge_aktionsstart_hist_aktion,
wkw1.we_menge_zentral AS menge_we_zentrale_hist_aktion,
wkw1.anzahl_nullbestand AS anzahl_nullbestand_hist_aktion,
wkw1.anzahl_tage_aktion AS anzahl_tage_aktion_hist_aktion,
wkw1.menge_historie_af AS menge_historie_af_hist_aktion,
wkw1.sollbestand AS sollbestand_hist_aktion,
wkw1.min_sicherh_bestand AS min_sicherh_bestand_hist_aktion,
wkw1.menge_endbestand AS menge_endbestand_hist_aktion,
(wkw1.umsatz_netto_tag1 + wkw1.umsatz_netto_tag2 + wkw1.umsatz_netto_tag3 + wkw1.umsatz_netto_tag4 + wkw1.umsatz_netto_tag5 + wkw1.umsatz_netto_tag6 + wkw1.umsatz_netto_tag7) AS umsatz_netto_hist_aktion,
--20210601 cbru1709
v01.anteil_wup_abvk,
COALESCE(v01.abweichung_fg,0) AS abweichung_fg,
COALESCE(v01.gk_history_fg,0) AS gk_history_fg,
v011.mandant_id_vz,
v011.dat_beladung
  
FROM dbp_view.v_wbs_replenishment v01

INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v01.mandant_id
   --   AND v05.wup_id = CASE WHEN TRY_CAST(v01.wup_id  AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v01.wup_id  AS INTEGER) END
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))


LEFT JOIN dbp_view.v_tag v02
ON v01.aktion_dat_von = v02.dat

JOIN ( SELECT DISTINCT mandant_id, CASE WHEN wup_id_vz = 6140 THEN 4 ELSE mandant_id_vz END AS mandant_id_vz, art_id, wup_id, nb_id, /*kjwo,*/ dat_ab, dat_bis, dat_beladung  FROM dbp_view.v_wbs_werbeaenderungen) v011 
ON v011.mandant_id = v01.mandant_id 
AND v011.art_id = v01.art_id 
AND v011.dat_ab = v01.dat_von
AND v011.dat_bis = v01.dat_bis
--AND v011.kjwo = v01.kjwo_von
AND v011.wup_id = v01.wup_id 
AND v011.nb_id = v01.nb_id

LEFT JOIN dbp_view.v_werbung_kennzahlen_woche wkw1
ON v01.mandant_id = wkw1.mandant_id
AND v01.art_id = wkw1.art_id
AND v01.wup_id = wkw1.wup_id
AND v02.kjwo = wkw1.kjwo

WHERE 1 = 0;