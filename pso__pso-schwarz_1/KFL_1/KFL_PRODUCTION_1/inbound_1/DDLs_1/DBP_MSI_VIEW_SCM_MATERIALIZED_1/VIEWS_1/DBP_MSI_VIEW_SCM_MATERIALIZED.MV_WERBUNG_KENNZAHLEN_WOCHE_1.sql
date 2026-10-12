create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WERBUNG_KENNZAHLEN_WOCHE_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	KJWO,
	WERBE_TYP_ID,
	WTAG_ID_START,
	WTAG_ID_ENDE,
	POSTEN_ID,
	POSTEN_FG,
	ART_MUTTER_WB_ID,
	ART_MUTTER_DISPLAY_ID,
	MWB_BASISMENGE_EINH_ID,
	MWB_VERPART_ID,
	ART_MUTTER_WB_NR,
	ART_MUTTER_WB_BEZ,
	ART_MUTTER_WB_FG,
	ANZ_ART_KIND,
	FAKTOR_FLAKI,
	ART_ID,
	ART_DISPLAY_ID,
	ART_BASISMENGE_EINH_ID,
	ART_VERPART_ID,
	MENGE_TAG1,
	MENGE_TAG2,
	MENGE_TAG3,
	MENGE_TAG4,
	MENGE_TAG5,
	MENGE_TAG6,
	MENGE_TAG7,
	MENGE,
	UMSATZ_NETTO_TAG1,
	UMSATZ_NETTO_TAG2,
	UMSATZ_NETTO_TAG3,
	UMSATZ_NETTO_TAG4,
	UMSATZ_NETTO_TAG5,
	UMSATZ_NETTO_TAG6,
	UMSATZ_NETTO_TAG7,
	UMSATZ_NETTO,
	MENGE_0_TAG1,
	MENGE_0_TAG2,
	MENGE_0_TAG3,
	MENGE_0_TAG4,
	MENGE_0_TAG5,
	MENGE_0_TAG6,
	MENGE_0_TAG7,
	TAGE_MENGE_0,
	MENGE_WE_ZENTRALE,
	MENGE_WE,
	MENGE_AKTIONSSTART,
	MENGE_ENDBESTAND,
	MIN_SICHERH_BESTAND,
	MENGE_HISTORIE_AF,
	ANZAHL_NULLBESTAND,
	ANZAHL_TAGE_AKTION,
	MENGE_TAG1_7BIS13H,
	WE_MENGE_VOR_AKTION,
	SOLLBESTAND,
	LAGER_PROZENT,
	MHD_ZEITRAUM,
	MENGE_LGBEST_ERP_FREI_BME,
	AVQ_RELEVANT_FG,
	ANZAHL_NULLBESTAND_TAG1,
	ANZAHL_NULLBESTAND_TAG1BIS3,
	ANZAHL_NULLBESTAND_TAG2,
	ANZAHL_NULLBESTAND_TAG3,
	ANZAHL_NULLBESTAND_TAG4,
	ANZAHL_NULLBESTAND_TAG5,
	ANZAHL_NULLBESTAND_TAG6,
	ANZAHL_NULLBESTAND_TAG7,
	MENGE_SA,
	VK_VOR_AKTION_BRUTTO,
	VK_AKTION_BRUTTO,
	VK_KCARD_BRUTTO,
	MENGE_NUR_TAG1,
	AKTIONSKLASSIFIZIERUNG_ID
) as

   
   
  
  
  
  
     
               
   
      
   
   
SELECT
    wkw.mandant_id
   ,wkw.nb_id
   
   
   ,COALESCE(v05.aktuell_wup_id, wkw.wup_id) AS wup_id
   ,wkw.kjwo, wkw.werbe_typ_id 
   ,wtag_id_start
   ,wtag_id_ende
   ,wkw.posten_id 
   ,CASE WHEN art.posten_kz_sap <> '' THEN 1 ELSE 0 END AS posten_fg
   ,wkw.mutter_wb_id AS art_mutter_wb_id 
   ,CASE WHEN mwb.artikeltyp_id = 12 THEN  mwb.artikeltyp_id ELSE mwb.display_id END AS art_mutter_display_id
   ,mwb.basismenge_einh_id AS mwb_basismenge_einh_id
   ,COALESCE(mwb.verpart_id,' ') AS mwb_verpart_id
   ,TO_VARCHAR((CASE WHEN wkw.mandant_id = 1 THEN (TRUNC(wkw.mutter_wb_id/100)) ELSE (TRUNC(wkw.mutter_wb_id/10)) END), 'FM00000000') AS art_mutter_wb_nr 
   ,msz.art_bez AS art_mutter_wb_bez
   ,CASE WHEN wkw.mutter_wb_id = wkw.art_id THEN 0 ELSE 1 END::BYTEINT AS art_mutter_wb_fg 
   ,RANK() OVER (PARTITION BY wkw.mandant_id, wkw.wup_id, wkw.kjwo, wkw.werbe_typ_id, art_mutter_wb_id ORDER BY wkw.mandant_id, wkw.wup_id, wkw.kjwo, wkw.werbe_typ_id, art_mutter_wb_id, wkw.art_id) - 1 AS anz_art_kind
   ,wkw.faktor_flaki     
   ,wkw.art_id
   ,CASE WHEN art.artikeltyp_id = 12 THEN  art.artikeltyp_id ELSE art.display_id END AS art_display_id
   ,art.basismenge_einh_id AS art_basismenge_einh_id
   ,COALESCE(art.verpart_id,' ') AS art_verpart_id, wkw.menge_tag1
   ,wkw.menge_tag2
   ,wkw.menge_tag3
   ,wkw.menge_tag4
   ,wkw.menge_tag5
   ,wkw.menge_tag6
   ,wkw.menge_tag7
   ,(wkw.menge_tag1 + wkw.menge_tag2 + wkw.menge_tag3 + wkw.menge_tag4 + wkw.menge_tag5 + wkw.menge_tag6 + wkw.menge_tag7)  AS menge
   ,wkw.umsatz_netto_tag1
   ,wkw.umsatz_netto_tag2
   ,wkw.umsatz_netto_tag3
   ,wkw.umsatz_netto_tag4
   ,wkw.umsatz_netto_tag5
   ,wkw.umsatz_netto_tag6
   ,wkw.umsatz_netto_tag7
   ,(wkw.umsatz_netto_tag1 + wkw.umsatz_netto_tag2 + wkw.umsatz_netto_tag3 + wkw.umsatz_netto_tag4 + wkw.umsatz_netto_tag5 + wkw.umsatz_netto_tag6 + wkw.umsatz_netto_tag7)  AS umsatz_netto
   ,CASE WHEN wkw.menge_tag1 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag1
   ,CASE WHEN wkw.menge_tag2 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag2
   ,CASE WHEN wkw.menge_tag3 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag3
   ,CASE WHEN wkw.menge_tag4 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag4
   ,CASE WHEN wkw.menge_tag5 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag5
   ,CASE WHEN wkw.menge_tag6 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag6
   ,CASE WHEN wkw.menge_tag7 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag7
   ,wkw.tage_menge_0  
   ,wkw.we_menge_zentral AS menge_we_zentrale
   ,wkw.we_menge AS menge_we
   ,wkw.menge_aktionsstart
   ,wkw.menge_endbestand
   ,wkw.min_sicherh_bestand
   ,menge_historie_af
   ,anzahl_nullbestand
   ,anzahl_tage_aktion
   ,wkw.menge_tag1_7bis13h
   ,wkw.we_menge_vor_aktion
   ,wkw.sollbestand
   ,wkw.lager_prozent
   ,wkw.mhd_zeitraum
   ,mb.menge_lgbest_erp_frei_bme
   ,CASE WHEN COALESCE(wkw.avq_relevant_fg,1) = 1 THEN 1 ELSE 0 END
   ,wkw.anzahl_nullbestand_tag1
   ,wkw.anzahl_nullbestand_tag1bis3
   ,wkw.anzahl_nullbestand_tag2
   ,wkw.anzahl_nullbestand_tag3
   ,wkw.anzahl_nullbestand_tag4
   ,wkw.anzahl_nullbestand_tag5
   ,wkw.anzahl_nullbestand_tag6
   ,wkw.anzahl_nullbestand_tag7
   ,wkw.menge_sa
   ,wkw.vk_vor_aktion_brutto
   ,wkw.vk_aktion_brutto
   ,wkw.vk_kcard_brutto
   ,wkw.menge_nur_tag1
  ,CASE WHEN wkw.avq_relevant_fg = 9 THEN 4
        WHEN wkw.avq_relevant_fg = 0 THEN 3 
        WHEN wkw.avq_relevant_fg = 1 AND COALESCE(bby.bby_fg,0)=1 THEN 2 
         
         ELSE 1 
         END AS aktionsklassifizierung_id
		 
  FROM dbp_view.v_werbung_kennzahlen_woche_1  wkw
  
   JOIN dbp_view.v_art_1 art_1
   ON art.mandant_id = wkw.mandant_id AND art.art_id = wkw.art_id
   AND art.dat_bis = '9999-12-31'

   JOIN dbp_view.v_art_spr_zu_1  msz
   ON msz.mandant_id = wkw.mandant_id AND msz.art_id = wkw.mutter_wb_id
   AND msz.spr_id = 22

   JOIN dbp_view.v_art_1  mwb
   ON mwb.mandant_id = wkw.mandant_id AND mwb.art_id = wkw.mutter_wb_id
   AND mwb.dat_bis = '9999-12-31'

   JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = wkw.mandant_id 
   AND v05.wup_id = wkw.wup_id
   AND v05.nb_id = 0
   
   LEFT JOIN dbp_view.v_marktbestand_erp_delta_1 mb
   ON mb.mandant_id = wkw.mandant_id AND mb.art_id = wkw.art_id
   AND mb.wup_id=wkw.wup_id 
   
   LEFT JOIN ( SELECT 
              a.mandant_id
             ,aaw.wup_id
             ,aaw.art_id
             ,a.kjwo_von 
             ,wt.werbe_typ_id
             ,1 AS bby_fg
             FROM dbp_view.v_AKTION_ART_WUP_ZU_1 aaw
             JOIN dbp_view.v_AKTION_1 a ON a.mandant_id=aaw.mandant_id AND a.aktion_id=aaw.aktion_id
             JOIN dbp_view.v_l_bonuskauf_1 bby ON a.mandant_id=bby.mandant_id AND a.aktion_id=bby.aktion_id
             JOIN dbp_msi_view_vis.mv_werbe_woche_1 wt ON wt.mandant_id=a.mandant_id AND wt.dat_von=a.dat_von AND wt.dat_bis=a.dat_bis
             WHERE a.mandant_id=1 OR a.aktion_typ_id IN ('KDN', 'KDP' ,'KPB', 'KDI')
             AND  EXISTS (SELECT 1 FROM dbp_view.v_tag_1 t WHERE t.akt_kj BETWEEN -2 AND 0 AND t.kjwo = a.kjwo_von)
             GROUP BY  a.mandant_id, aaw.wup_id, aaw.art_id, a.kjwo_von  , wt.werbe_typ_id
             ) bby
   ON wkw.mandant_id = bby.mandant_id
   AND wkw.wup_id = bby.wup_id
   AND wkw.art_id=bby.art_id
   AND wkw.kjwo= bby.kjwo_von
   AND wkw.werbe_typ_id=bby.werbe_typ_id 
  
   WHERE EXISTS (SELECT 1 FROM dbp_view.v_tag_1 t WHERE t.akt_kj BETWEEN -2 AND 0 AND t.kjwo = wkw.kjwo);