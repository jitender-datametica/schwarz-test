create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_LIEFERANTENMANAGEMENT_2(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	DAT_BUCH,
	ENDLIEF_FG,
	ZEIT_ENDLIEF_FG,
	BEST_MENGE_ORIG_FG,
	ANNAHMEVERWEIGERUNG_ID,
	NB_ID,
	ART_ID,
	BELEG_GP_ID,
	WUP_ID,
	BESTELLART_ID,
	DAT_BEST_BELEG,
	DAT_LIEF_WUNSCH,
	DAT_LIEF_BEWERTUNG,
	MENGE_LIEF,
	BETRAG_LAGERBEW_EK_N,
	BETRAG_BEST_EK_N,
	MENGE_BEST_BME,
	MENGE_BEST_ORIG,
	MENGE_BEST_KOLLI_ORIG,
	MENGE_IST_KOLLI_ORIG,
	LAGERORT_ID,
	GP_ID,
	LOESCH_FG_EKKO,
	LOESCH_FG_EKPO,
	SELBSTABHOL_FG,
	ANZAHL_LIEF,
	ANZAHL_LIEF_POS,
	LAGER_BEWART_ID,
	MENGE_GESAMT,
	MENGE_NORMAL,
	MENGE_IWT,
	MENGE_WERBUNG,
	MENGE_BEVORRATUNG,
	WRG_ID,
	VK_NETTO_LIEF_SOLL,
	VK_NETTO_LIEF_IST,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI,
	MENGE_LIEF_IST_KOLLI_KUM,
	FEHLLIEFERUNG_MENGE,
	FEHLLIEFERUNG_MENGE_LAST_VALUE,
	FEHLLIEFERUNG_MENGE_CASE,
	SOLL_IST_LIEFERDATUM_DIFF,
	IWT_ID,
	NEUER_ARTIKEL_FG,
	PLANLIEFERZEIT,
	GP_TEILSORTIMENT_ID,
	REICHWEITE,
	GP_DISPO_MULTI_ID,
	RATIO,
	BEDARFSNUMMER,
	MENGE_WERBUNG_OFFEN_KUM,
	MENGE_LIEF_OFFEN_KUM,
	MENGE_LIEF_IST_WERBUNG_CALC,
	MENGE_LIEF_IST_NORMAL_CALC,
	MENGE_LIEF_IST_BEVORRATUNG_CALC,
	MENGE_LIEF_IST_IWT_CALC
) as
--2023-05-11, dknop, adding menge_lief_ist_kolli_kum, fehllieferung_menge, fehllieferung_menge_case, menge_lief_ist_kolli_kum
--2023-06-01, nwag, refactoring, aktkj -2 instead of last 90 days
--2023-06-22, dknop, updating join to v_tag_2, correcting case condition for gp_teilsortiment_id
--2023-06-26, dknop, adding v01.bestellart_id in ('ZLLF', 'ZBCZ', 'ZBPL', 'ZBSK', 'ZBHR', 'ZBRO', 'ZBBG'), including dat_best_beleg in join to besch_best_det_2
--2023-07-20, dknop, change dbp_data.besch_best_det_2 to dbp_view.v_besch_best_det_2
--2023-07-25, dknop, adding fehllieferung_menge_last_value
--2023-09-13, dknop, changing coalesce for iwt_id fom '0' to ''
--2024-06-18, dknop, changing definition of wrg_id, set 'EUR' when user_wrg.wrg_typ_id=0 
SELECT DISTINCT
 v01.mandant_id
,v01.best_beleg_id
,v01.best_beleg_pos_id
,v01.dat_buch
,v01.endlief_fg
,CASE WHEN v01.dat_buch IN ('1900-01-01', '9999-12-31'    ) THEN -2 ELSE v01.zeit_endlief_fg END AS zeit_endlief_fg
-- to be done in ETL:
    ,CASE WHEN v01.mandant_id = 1 THEN v01.best_menge_orig_fg
	  WHEN v01.mandant_id > 1 AND ROW_NUMBER() OVER ( PARTITION BY v01.mandant_id, v01.best_beleg_id, v01.best_beleg_pos_id ORDER BY v01.dat_buch ) = 1 THEN 1 
	  ELSE 0 END AS best_menge_orig_fg -- wird benoetig wenn teillieferungen vorhanden sind -> umbenennung durch feldliste oben!
 --,v01.best_menge_orig_fg
,v01.annahmeverweigerung_id
,v01.nb_id
,v01.art_id
,v01.gp_id AS beleg_gp_id
,v01.wup_id
,v01.bestellart_id
,v01.dat_best_beleg
,v01.dat_lief_wunsch
,v01.dat_lief_bewertung
,v01.menge_lief
,v01.betrag_lagerbew_ek_n
,v01.betrag_best_ek_n
,v01.menge_best_bme
,v01.menge_best_bme * best_menge_orig_fg   AS menge_best_orig
,v01.menge_lief_soll_kolli *  best_menge_orig_fg AS menge_best_kolli_orig
,v01.menge_lief_ist_kolli *  best_menge_orig_fg AS menge_ist_kolli_orig
,v01.lagerort_id
,v01.gp_id
,v01.loesch_fg_ekko
,v01.loesch_fg_ekpo
,v01.selbstabhol_fg
,v01.anzahl_lief
,v01.anzahl_lief_pos
,v01.lager_bewart_id
,CASE WHEN v03.menge_normal IS NOT NULL THEN v03.menge_normal ELSE 0.000 END AS menge_gesamt
,CASE WHEN v03.menge_normal IS NOT NULL THEN (v03.menge_normal-v03.menge_iwt-v03.menge_werbung-v03.menge_bevorratung)* best_menge_orig_fg ELSE 0.000 END AS menge_normal
,CASE WHEN v03.menge_iwt IS NOT NULL THEN v03.menge_iwt * best_menge_orig_fg ELSE 0.000 END AS menge_iwt
,CASE WHEN v03.menge_werbung IS NOT NULL THEN v03.menge_werbung * best_menge_orig_fg ELSE 0.000 END AS menge_werbung
,CASE WHEN v03.menge_bevorratung IS NOT NULL THEN v03.menge_bevorratung * best_menge_orig_fg ELSE 0.000 END AS menge_bevorratung
,CASE WHEN user_wrg.wrg_typ_id=0 THEN 'EUR' ELSE v01.wrg_id END AS wrg_id
,CASE WHEN user_wrg.wrg_typ_id=0 THEN v01.vk_netto_lief_soll*kurs.umrechnungskurs ELSE  v01.vk_netto_lief_soll END  AS vk_netto_lief_soll  
,CASE WHEN user_wrg.wrg_typ_id=0 THEN  v01.vk_netto_lief_ist*kurs.umrechnungskurs ELSE  v01.vk_netto_lief_ist END  AS vk_netto_lief_ist 
,v01.menge_lief_soll_kolli
,v01.menge_lief_ist_kolli
,SUM(menge_lief_ist_kolli) OVER (PARTITION BY v01.mandant_id, v01.best_beleg_id, v01.best_beleg_pos_id,
    v01.wup_id, v01.nb_id, v01.art_id ORDER BY v01.dat_buch ASC
             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS menge_lief_ist_kolli_kum
,menge_lief_ist_kolli_kum - v01.menge_lief_soll_kolli  AS fehllieferung_menge           
,CASE WHEN ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.best_beleg_id,v01.best_beleg_pos_id,
    v01.wup_id, v01.nb_id, v01.art_id ORDER BY v01.dat_buch DESC)= 1 THEN CASE WHEN (menge_lief_ist_kolli_kum - v01.menge_lief_soll_kolli)>0 THEN 0 ELSE (menge_lief_ist_kolli_kum - v01.menge_lief_soll_kolli) END
    ELSE 0 END AS fehllieferung_menge_last_value   
,CASE WHEN v01.endlief_fg IN (-1,-2) AND v01.zeit_endlief_fg<>-1 /*AND v01.menge_lief_ist_kolli<v01.menge_lief_soll_kolli*/ THEN fehllieferung_menge ELSE 0 END AS fehllieferung_menge_case
,Abs(v01.dat_buch - v01.dat_lief_bewertung) AS soll_ist_lieferdatum_diff
,COALESCE(v045.iwt_id,'') AS iwt_id
,COALESCE(v045.neuer_artikel_fg,0) AS neuer_artikel_fg
,v045.planlieferzeit
,CASE WHEN v045.gp_teilsortiment_id = '999999' THEN '' ELSE COALESCE(v045.gp_teilsortiment_id,'      ') END AS gp_teilsortiment_id
,v045.reichweite
, v045.gp_dispo_multi_id
,v045.ratio
,v001.bedarfsnummer

,v03.menge_werbung-menge_lief_ist_kolli_kum AS menge_werbung_offen_kum
,menge_lief_soll_kolli - menge_lief_ist_kolli_kum AS menge_lief_offen_kum
-- Werbung, Prio 1
      -- Bestellmenge Gesamt = Liefermenge Gesamt: Verteilung auf Kategorien gem?? Bestellung
,CASE WHEN menge_werbung_offen_kum > 0 THEN menge_lief_ist_kolli ELSE menge_lief_ist_kolli + menge_werbung_offen_kum END
  AS menge_lief_ist_werbung_calc

-- Sortiment (normal), Prio 2
      -- Bestellmenge Gesamt = Liefermenge Gesamt: Verteilung auf Kategorien gem. Bestellung
, menge_lief_ist_kolli - menge_lief_ist_werbung_calc    AS menge_lief_ist_normal_calc

 -- Bevorratung, Prio 3
, menge_lief_ist_kolli - menge_lief_ist_werbung_calc  - menge_lief_ist_normal_calc  AS menge_lief_ist_bevorratung_calc 

-- IWT, Prio 4
, menge_lief_ist_kolli - menge_lief_ist_werbung_calc  - menge_lief_ist_normal_calc  - menge_lief_ist_bevorratung_calc AS menge_lief_ist_iwt_calc  

FROM DBP_VIEW.v_besch_best_lief_lbs_2 v01

JOIN DBP_MSI_VIEW_SCM_MATERIALIZED.mv_kurs_2 kurs_2
ON v01.wrg_id = kurs.von_wrg_id

CROSS JOIN DBP_MSI_VIEW_SCM_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 user_wrg 

JOIN DBP_VIEW.v_besch_best_det_2 v001
ON v01.mandant_id = v001.mandant_id
AND v01.best_beleg_id = v001.best_beleg_id
AND v01.best_beleg_pos_id = v001.best_beleg_pos_id
--AND v01.art_id = v001.art_id
AND v01.dat_best_beleg = v001.dat_best_beleg

LEFT JOIN DBP_VIEW.v_vz_best_split_2 v03
   ON v01.best_beleg_id     = v03.best_beleg_id
  AND v01.best_beleg_pos_id = v03.best_beleg_pos_id
  AND v01.mandant_id        = v03.mandant_id
  AND v01.gp_id             = v03.gp_id

--AND v001.gp_teilsortiment_id = CASE WHEN v03.gp_teilsortiment_id = '' THEN '999999' ELSE v03.gp_teilsortiment_id END   
--geht nur als subsselect da INNER JOIN zwischen den beiden Tabellen notwendig:

LEFT JOIN ( SELECT v04.mandant_id
                 ,v04.dat_plan
                 ,v04.art_id
                 ,v05.wup_id
				 ,v05.gp_id
				 , CASE WHEN v05.gp_teilsortiment_id = '' THEN '999999' ELSE v05.gp_teilsortiment_id END AS gp_teilsortiment_id
                --,v05.gp_teilsortiment_id
				--,v04.dat_lief
                 ,MAX(v04.iwt_id) iwt_id
                 ,MAX(v04.neuer_artikel_fg) neuer_artikel_fg
                 ,MAX(v05.planlieferzeit) planlieferzeit
                 ,MAX(v04.reichweite ) reichweite 
                 ,MAX(v04.ratio) ratio
                 ,MAX(v04.gp_dispo_multi_id) gp_dispo_multi_id
				
           FROM DBP_VIEW.v_art_gp_dispo_tag_2 v04 
	       JOIN DBP_VIEW.v_tag_2 v06 ON v04.dat_plan=v06.dat AND v06.akt_kj BETWEEN -2 AND 0
           JOIN DBP_VIEW.v_gp_dispo_vz_tag_2 v05
             ON v04.mandant_id     = v05.mandant_id
             AND v04.dat_plan       = v05.dat_plan
             AND v04.gp_dispo_id    = v05.gp_dispo_id
			 WHERE v04.augeblendet_fg=0 
				--AND v04.dat_plan >= CURRENT_DATE - 90
			 GROUP BY v04.mandant_id
                 ,v04.dat_plan
                 ,v04.art_id
                 ,v05.wup_id
				 ,v05.gp_id
				 ,v05.gp_teilsortiment_id
          ) v045

ON v01.mandant_id     = v045.mandant_id
 --AND v01.dat_best_beleg = v045.dat_plan
  AND v01.art_id         = v045.art_id
  AND v01.wup_id         = v045.wup_id
  AND v01.dat_lief_bewertung = v045.dat_plan
  AND v01.gp_id = v045.gp_id
  AND v001.gp_teilsortiment_id = v045.gp_teilsortiment_id 

JOIN DBP_VIEW.v_tag_2 v07 
ON v01.dat_lief_bewertung=v07.dat 
--and v045.dat_plan=v07.dat
AND v07.akt_kj BETWEEN -2 AND 0

WHERE v01.nb_id <> 99
AND v01.bestellart_id IN ('ZLLF', 'ZBCZ', 'ZBPL', 'ZBSK', 'ZBHR', 'ZBRO', 'ZBBG');