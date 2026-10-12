create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_WBS_AUSLIEFERGRUPPE_2(
	MANDANT_ID,
	AUSLIEFERGRUPPE_ID,
	FAKTOR_REST_VON_NORMALBESTAND,
	SCHWELLWERT_PAL_ABRUNDUNG_PROZ,
	SCHWELLWERT_PAL_AUFRUNDUNG_PROZ,
	KOLLI_RUNDUNG_PROZ,
	FAKTOR_MAX_KAPA_ENDBESTAND,
	ADJUSTMENT_FG,
	FAKTOR_BESTAND_BETRACHTUNG,
	ANZ_TAGE_SWITCH_3,
	ANZ_TAGE_SWITCH_1,
	ANZ_TAGE_SWITCH_2,
	ANZ_TAGE_SWITCH_4,
	LIEFERUNG_TAG_OFFSET,
	ESTIMATION_FG,
	ERWEITERUNG_BEDARFSHORIZONT_TAGE,
	SHARE_WERT_0,
	SHARE_WERT_1,
	SHARE_WERT_2,
	SHARE_WERT_3,
	SHARE_WERT_4,
	SHARE_WERT_5,
	SHARE_WERT_6,
	SHARE_WERT_7,
	SHARE_WERT_8,
	SHARE_WERT_9,
	SHARE_WERT_10,
	SHARE_WERT_11,
	SHARE_WERT_12,
	SHARE_WERT_13,
	SHARE_WERT_14,
	SHARE_WERT_15,
	SHARE_WERT_16,
	RS_2,
	SHARE_STRING
) as


SELECT 
	v01.mandant_id
    ,v01.ausliefergruppe_id
 
    ,MAX(v01.faktor_rest_von_normalbestand) AS faktor_rest_von_normalbestand
    ,MAX(v01.schwellwert_pal_abrundung_proz) AS schwellwert_pal_abrundung_proz
    ,MAX(v01.schwellwert_pal_aufrundung_proz) AS schwellwert_pal_aufrundung_proz
    ,MAX(v01.kolli_rundung_proz) AS kolli_rundung_proz
    ,MAX(v01.faktor_max_kapa_endbestand) AS faktor_max_kapa_endbestand
    ,MAX(COALESCE(v01.adjustment_id,0)) AS adjustment_fg
    ,MAX(v01.faktor_bestand_betrachtung) AS faktor_bestand_betrachtung
    ,MAX(v01.anz_tage_switch_3) AS anz_tage_switch_3
    ,MAX(v01.anz_tage_switch_1) AS anz_tage_switch_1
    ,MAX(v01.anz_tage_switch_2) AS anz_tage_switch_2
    ,MAX(v01.anz_tage_switch_4) AS anz_tage_switch_4
    ,MAX(v01.lieferung_tag_offset) AS lieferung_tag_offset
    ,MAX(COALESCE(v01.estimation_fg,0)) AS estimation_fg
    ,MAX(COALESCE(erweiterung_bedarfshorizont_tage,0)) AS erweiterung_bedarfshorizont_tage 
    ,MAX(CASE WHEN rank_share = 0 THEN share_wert ELSE NULL END) AS share_wert_0
    ,MAX(CASE WHEN rank_share = 1 THEN share_wert ELSE NULL END) AS share_wert_1
    ,MAX(CASE WHEN rank_share = 2 THEN share_wert ELSE NULL END) AS share_wert_2
    ,MAX(CASE WHEN rank_share = 3 THEN share_wert ELSE NULL END) AS share_wert_3
    ,MAX(CASE WHEN rank_share = 4 THEN share_wert ELSE NULL END) AS share_wert_4
    ,MAX(CASE WHEN rank_share = 5 THEN share_wert ELSE NULL END) AS share_wert_5
    ,MAX(CASE WHEN rank_share = 6 THEN share_wert ELSE NULL END) AS share_wert_6
    ,MAX(CASE WHEN rank_share = 7 THEN share_wert ELSE NULL END) AS share_wert_7
    ,MAX(CASE WHEN rank_share = 8 THEN share_wert ELSE NULL END) AS share_wert_8
    ,MAX(CASE WHEN rank_share = 9 THEN share_wert ELSE NULL END) AS share_wert_9
    ,MAX(CASE WHEN rank_share = 10 THEN share_wert ELSE NULL END) AS share_wert_10
    ,MAX(CASE WHEN rank_share = 11 THEN share_wert ELSE NULL END) AS share_wert_11
    ,MAX(CASE WHEN rank_share = 12 THEN share_wert ELSE NULL END) AS share_wert_12
    ,MAX(CASE WHEN rank_share = 13 THEN share_wert ELSE NULL END) AS share_wert_13
    ,MAX(CASE WHEN rank_share = 14 THEN share_wert ELSE NULL END) AS share_wert_14
    ,MAX(CASE WHEN rank_share = 15 THEN share_wert ELSE NULL END) AS share_wert_15
    ,MAX(CASE WHEN rank_share = 16 THEN share_wert ELSE NULL END) AS share_wert_16
    
    ,MAX(COALESCE(rank_share, 0)) AS rs_2 
	
    ,TO_CHAR(NVL(share_wert_0, 0)) || CASE WHEN rs_2 > 0 THEN '/' ELSE '' END
		|| CASE WHEN rs_2 > 1 THEN TO_CHAR(NVL(share_wert_1, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_1), '') END
		|| CASE WHEN rs_2 > 2 THEN TO_CHAR(NVL(share_wert_2, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_2), '') END
		|| CASE WHEN rs_2 > 3 THEN TO_CHAR(NVL(share_wert_3, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_3), '') END
		|| CASE WHEN rs_2 > 4 THEN TO_CHAR(NVL(share_wert_4, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_4), '') END
		|| CASE WHEN rs_2 > 5 THEN TO_CHAR(NVL(share_wert_5, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_5), '') END
		|| CASE WHEN rs_2 > 6 THEN TO_CHAR(NVL(share_wert_6, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_6), '') END
		|| CASE WHEN rs_2 > 7 THEN TO_CHAR(NVL(share_wert_7, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_7), '') END
		|| CASE WHEN rs_2 > 8 THEN TO_CHAR(NVL(share_wert_8, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_8), '') END
		|| CASE WHEN rs_2 > 9 THEN TO_CHAR(NVL(share_wert_9, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_9), '') END
		|| CASE WHEN rs_2 > 10 THEN TO_CHAR(NVL(share_wert_10, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_10), '') END
		|| CASE WHEN rs_2 > 11 THEN TO_CHAR(NVL(share_wert_11, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_11), '') END
		|| CASE WHEN rs_2 > 12 THEN TO_CHAR(NVL(share_wert_12, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_12), '') END
		|| CASE WHEN rs_2 > 13 THEN TO_CHAR(NVL(share_wert_13, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_13), '') END
		|| CASE WHEN rs_2 > 14 THEN TO_CHAR(NVL(share_wert_14, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_14), '') END
		|| CASE WHEN rs_2 > 15 THEN TO_CHAR(NVL(share_wert_15, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_15), '') END
		|| CASE WHEN rs_2 > 16 THEN TO_CHAR(NVL(share_wert_16, 0)) || '/' ELSE NVL(TO_CHAR(share_wert_16), '') END
	 AS share_string
	 
FROM DBP_VIEW.v_ts_wbs_ausliefergruppe_2 v01
LEFT JOIN DBP_VIEW.v_ts_wbs_ausliefergruppe_share v02
	ON (v01.mandant_id = v02.mandant_id AND v01.ausliefergruppe_id = v02.ausliefergruppe_id)
GROUP BY 	
	v01.mandant_id
    ,v01.ausliefergruppe_id;