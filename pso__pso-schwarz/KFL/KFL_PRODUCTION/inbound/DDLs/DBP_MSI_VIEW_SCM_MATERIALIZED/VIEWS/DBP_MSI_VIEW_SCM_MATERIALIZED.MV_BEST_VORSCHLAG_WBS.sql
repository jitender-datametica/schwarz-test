create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_BEST_VORSCHLAG_WBS(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT_AUSFUEHRUNG,
	AUSLIEFERGRUPPE_ID,
	GONDELKOPF_FG,
	ZWEITPLATZIERUNG_FG,
	AKTION_ID,
	GEWICHT_TAG1,
	GEWICHT_TAG2,
	GEWICHT_TAG3,
	GEWICHT_TAG4,
	GEWICHT_TAG5,
	GEWICHT_TAG6,
	GEWICHT_TAG7,
	GEWICHT_STUNDE1,
	GEWICHT_STUNDE2,
	MENGE_MIN_TAG1,
	MENGE_MAX_TAG1,
	WUP_ID_VZ,
	MANDANT_ID_VZ,
	NB_ID_VZ,
	GP_ID,
	DAT_BEDARF_VON,
	DAT_BEDARF_BIS,
	NACHVERSORGUNG_MGL_FG,
	DAT_LETZE_NACHVERSORGUNG,
	ABSATZ_WOCHE_AKTION,
	ABVERKAUF_PROJEZIERT_WOCHE_AKTION,
	ABVERKAUF_PROJEZIERT_BESTANDSPERIODE,
	ABVERKAUF_PROJEZIERT_BEDARFSPERIODE,
	MENGE_LGBEST_BME,
	MENGE_BEST_OFFEN_BME,
	MENGE_LGBEST_PROJEZIERT_BME,
	MENGE_LGBEST_FINAL_BME_MIN,
	MENGE_BEDARF_BME,
	MENGE_BEDARF_AME,
	MENGE_AUFFUELL_AME,
	MENGE_BEST_VORL_BME,
	MENGE_BEST_VORL_AME,
	MENGE_STANDARDBESTAND_VZ_AME,
	MENGE_BLOCKBESTAND_VZ_AME,
	MENGE_VERFUEGBARERBESTAND_VZ_AME,
	MENGE_VERFUEGBARERBESTAND_VZ_AME_INITIAL,
	MENGE_BEDARF_SUM_AME,
	FAIR_SHARE_FG,
	RANG_FAIR_SHARE,
	MOPRO_MHD_FG,
	CLEAR_STOCK_FG,
	RANG_CLEAR_STOCK,
	ABVERKAUF_DURCHSCHNITT_BME,
	REICHWEITE_ZIELBESTAND,
	REICHWEITE_ZIELBESTAND_CLEAR_STOCK,
	MENGE_WBS,
	AUSNAHME_PALLETTE_FG,
	AUSNAHME_MHD_FG,
	AUSNAHME_WEBEABSATZ_FG,
	MENGE_LGBEST_INITIAL,
	AUSNAHME_KOLLI_FG,
	ZIELBESTAND_AKT_BME,
	MENGE_WBS_FINAL,
	CHECK_VZ_FG,
	CHECK_WUP_FG,
	STATUS_VERARBEITUNG,
	DAT_LIEF_WUNSCH,
	DISPOTEILSORTIMENT_ID,
	MENGE_WBS_PAL,
	BEST_MENGE_EINH_ID_FINAL,
	LAGERORT_ID,
	ORDER_GENERATED_FG
) as










SELECT 
 a11.mandant_id


,v05.aktuell_wup_id wup_id
,a11.nb_id
,a11.art_id
,a11.dat_ausfuehrung
,a11.ausliefergruppe_id
,a11.gondelkopf_fg
,a11.zweitplatzierung_fg
,a11.aktion_id
,a11.gewicht_tag1
,a11.gewicht_tag2
,a11.gewicht_tag3
,a11.gewicht_tag4
,a11.gewicht_tag5
,a11.gewicht_tag6
,a11.gewicht_tag7
,a11.gewicht_stunde1
,a11.gewicht_stunde2
,a11.menge_min_tag1
,a11.menge_max_tag1
,CASE WHEN a11.vz_wup_id > 9999 THEN -9 ELSE a11.vz_wup_id END AS wup_id_vz


,a11.vz_mandant_id AS mandant_id_vz


,-111 AS nb_id_vz
,CASE WHEN a11.ausliefergruppe_id = 'VEN' THEN a13.gp_id ELSE a11.vz_wup_id END AS gp_id 

,a11.dat_bedarf_von
,a11.dat_bedarf_bis
,a11.nachversorgung_mgl_fg
,a11.dat_letze_nachversorgung
,a11.absatz_woche_aktion
,a11.abverkauf_projeziert_woche_aktion
,a11.abverkauf_projeziert_bestandsperiode
,a11.abverkauf_projeziert_bedarfsperiode
,a11.menge_lgbest_bme
,a11.menge_best_offen_bme
,a11.menge_lgbest_projeziert_bme
,a11.menge_lgbest_final_bme_min
,a11.menge_bedarf_bme
,a11.menge_bedarf_ame
,a11.menge_auffuell_ame
,a11.menge_best_vorl_bme
,a11.menge_best_vorl_ame
,a11.menge_standardbestand_vz_ame
,a11.menge_blockbestand_vz_ame
,a11.menge_verfuegbarerbestand_vz_ame

,a11.menge_verfuegbarerbestand_vz_ame AS menge_verfuegbarerbestand_vz_ame_initial
,a11.menge_bedarf_sum_ame
,a11.fair_share_fg
,a11.rang_fair_share
,a11.mopro_mhd_fg
,a11.clear_stock_fg
,a11.rang_clear_stock
,a11.abverkauf_durchschnitt_bme
,a11.reichweite_zielbestand
,a11.reichweite_zielbestand_clear_stock
,a11.menge_wbs
,COALESCE(a11.ausnahme_pallette_fg,0) AS ausnahme_pallette_fg
,COALESCE(a11.ausnahme_mhd_fg,0) AS ausnahme_mhd_fg
,COALESCE(a11.ausnahme_webeabsatz_fg,0) AS ausnahme_webeabsatz_fg
,a11.menge_lgbest_initial
,COALESCE(a11.ausnahme_kolli_fg,0) AS ausnahme_kolli_fg
,a11.zielbestand_akt_bme
,CASE WHEN a12.status_verarbeitung = 1 THEN a12.menge_wbs_final ELSE a11.menge_wbs END AS menge_wbs_final
,ZEROIFNULL(a12.check_vz_fg) AS check_vz_fg
,ZEROIFNULL(a12.check_wup_fg) AS check_wup_fg
,ZEROIFNULL(a12.status_verarbeitung) AS status_verarbeitung
,a11.dat_lief_wunsch
,a11.dispoteilsortiment_id
,a11.menge_wbs_pal
,a11.best_menge_einh_id_final
,COALESCE(marc.fremd_lagerort_id, '-9') AS lagerort_id


,a11.order_generated_fg


FROM dbp_view.v_best_vorschlag_wbs a11

INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = a11.mandant_id
   
   AND v05.wup_id = a11.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

LEFT JOIN   dbp_view.v_art_gp_nm_zu_per a13
  ON a11.art_id          = a13.art_id
 AND a11.dat_ausfuehrung BETWEEN a13.dat_von AND a13.dat_bis
 AND a11.mandant_id      = a13.mandant_id
 AND a11.nb_id           = a13.nb_id
 AND a11.wup_id          = a13.wup_id

LEFT JOIN   dbp_view.v_ts_best_vorschlag_wbs a12
  ON a11.art_id          = a12.art_id
 AND a11.dat_ausfuehrung = a12.dat_ausfuehrung
 AND a11.mandant_id      = a12.mandant_id
 AND a11.nb_id           = a12.nb_id
 AND a11.wup_id          = a12.wup_id
 
LEFT JOIN dbp_view.v_art_wup_status_per marc
  ON a11.art_id     = marc.art_id
 AND a11.vz_mandant_id = marc.mandant_id 
 AND a11.vz_wup_id  = marc.wup_id
 AND marc.dat_bis='9999-12-31';