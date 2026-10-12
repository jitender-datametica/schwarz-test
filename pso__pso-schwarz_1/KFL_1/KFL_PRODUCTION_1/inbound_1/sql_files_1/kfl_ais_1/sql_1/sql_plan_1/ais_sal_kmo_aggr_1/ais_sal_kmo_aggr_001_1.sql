DELETE FROM DBP_DATA.sal_kmo_1
WHERE mandant_id = ${MANDANT_ID} AND kjmo IN (SELECT kjmo_sort FROM DBP_ETL.st_wochen_1)
;

INSERT INTO DBP_DATA.sal_kmo_1 (mandant_id
                                           ,art_id
                                           ,kjmo
                                           ,wrg_id
                                           ,arthiertyp_id
                                           ,wg_id
                                           ,wug_id
                                           ,art_status
                                           ,gp_id
                                           ,gp_name
                                           ,zek_id
                                           ,eigenmarke_id
                                           ,bio_fg
                                           ,vegan_fg
                                           ,posten_food
                                           ,posten_nonfood
                                           ,gluten_fg
                                           ,mwst
                                           ,disc_pe
                                           ,disc_marke
                                           ,lactose_fg
                                           ,k_listung
                                           ,umrech_faktor_best
                                           ,umrech_faktor_ausg
                                           ,mhd_zeitraum
                                           ,mhd_zeitraum_dz
                                           ,k1_artbew_menge
                                           ,k1_anz_kjwo_wug_absatz
                                           ,k2_artbew_menge
                                           ,k2_anz_kjwo_wug_absatz
                                           ,k3_artbew_menge
                                           ,k3_anz_kjwo_wug_absatz
                                           ,k4_artbew_menge
                                           ,k4_anz_kjwo_wug_absatz
                                           ,k5_artbew_menge
                                           ,k5_anz_kjwo_wug_absatz
                                           ,total_artbew_menge
                                           ,total_anz_kjwo_wug_absatz
                                           ,total_artbew_menge_vj
                                           ,total_artbew_menge_sa
                                           ,total_anz_kjwo_wug_absatz_sa
                                           ,total_anz_tage_wug_absatz_sa
                                           ,total_artbew_menge_af
                                           ,total_anz_kjwo_wug_absatz_af
                                           ,schnelldreherquote
                                           ,prozentual_absatz_sa
                                           ,total_rohertrag
                                           ,total_rohertrag_vj
                                           ,total_rohertrag_af
                                           ,total_rohertrag_sa
                                           ,rohertrag_einheit
                                           ,rohertrag_einheit_af
                                           ,rohertrag_einheit_sa
                                           ,abschriftbetrag_netto_oWerbung
                                           ,ek_kb_stamm
                                           ,vk_brutto_pk1
                                           ,vk_brutto_pk4
                                           ,vk_netto_pk1
                                           ,vk_netto_pk4
                                           ,total_umsatz_netto
                                           ,total_umsatz_netto_af
                                           ,total_umsatz_netto_sa
                                           ,total_anz_markt
                                           ,anz_kjwo_wup_listung
                                           ,anz_wup_listung
                                           ,lager_prozent
                                           ,kol_la_bzw
                                           ,kol_bst_bzw
                                           ,spanne_ek1
                                           ,spanne_ek4)
SELECT a.mandant_id
      ,a.art_id
      ,e.kjmo_sort AS kjmo
      ,d.default_wrg AS wrg_id
      ,2 AS arthiertyp_id
      ,a.wg_id
      ,a.wug_id
      ,a.loesch_id AS art_status
      ,a.akt_gp_id AS gp_id
      ,a.akt_gp_name AS gp_name
      ,a.zek_1 AS zek_id
      ,COALESCE(a.eigenmarke_id,'') AS eigenmarke_id
      ,COALESCE(a.bio_fg,0) AS bio_fg
      ,COALESCE(a.vegan_fg,0) AS vegan_fg
      ,COALESCE(a.posten_food,'') AS posten_food
      ,COALESCE(a.posten_nonfood,'') AS posten_nonfood
      ,COALESCE(a.gluten_fg,0) AS gluten_fg
      ,COALESCE(a.mwst,0) AS mwst
      ,a.aldi_id AS disc_pe
      ,a.discount_id AS disc_marke
      ,COALESCE(a.lactose_fg,0) AS lactose_fg
      ,COALESCE(CAST(a.min_durchg_gelistet_sst AS VARCHAR(4)),'N/A') AS k_listung
      ,ZEROIFNULL(a.kol_bst) AS umrech_faktor_best
      ,ZEROIFNULL(a.kol_la) AS umrech_faktor_ausg
      ,a.mhd_zeitraum
      ,a.mhd_zeitraum_dz
      ,SUM(a.absatz_sk1) AS k1_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk1)) AS k1_anz_kjwo_wug_absatz
      ,SUM(a.absatz_sk2) AS k2_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk2)) AS k2_anz_kjwo_wug_absatz
      ,SUM(a.absatz_sk3) AS k3_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk3)) AS k3_anz_kjwo_wug_absatz
      ,SUM(a.absatz_sk4) AS k4_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk4)) AS k4_anz_kjwo_wug_absatz
      ,SUM(a.absatz_sk5) AS k5_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_sk5)) AS k5_anz_kjwo_wug_absatz
      ,SUM(a.absatz_gesamt) AS total_artbew_menge
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_tot_sk1_bis6)) AS total_anz_kjwo_wug_absatz
      ,SUM(a.absatz_vj_sk1_bis_6) AS total_artbew_menge_vj
      ,SUM(a.absatz_sa_sk1_bis6) AS total_artbew_menge_sa
      ,NULLIFZERO(SUM(anz_tage_mit_abs_sa_sk1_bis6)) AS total_anz_kjwo_wug_absatz_sa
      ,NULLIFZERO(SUM(a.anz_tage_mit_abs_sa_sk1_bis6)) AS total_anz_tage_wug_absatz_sa
      ,SUM(a.absatz_af_sk1_bis6) AS total_artbew_menge_af
      ,NULLIFZERO(SUM(a.anz_wo_mit_abs_af_sk1_bis6)) AS total_anz_kjwo_wug_absatz_af
      ,ZEROIFNULL(ROUND((SUM(a.anz_wo_mit_absatz)/NULLIFZERO(SUM(a.anz_wo_listung_1)))*100,1)) AS schnelldreherquote
      ,ZEROIFNULL(ROUND(SUM(a.absatz_sa_sk1_bis6)/NULLIFZERO(SUM(a.absatz_gesamt))*100,1)) AS prozentual_absatz_sa
      ,/*_{DWH_COMMON_PTY_ENC}*/(ZEROIFNULL(SUM(a.einstandspreis_tot)) /*_{DWH_COMMON_PTY_KEY_ENC}*/) AS total_rohertrag
      ,/*_{DWH_COMMON_PTY_ENC}*/(ZEROIFNULL(SUM(a.einstandspreis_ums_sk1_bis_6_vj)) /*_{DWH_COMMON_PTY_KEY_ENC}*/) AS total_rohertrag_vj
      ,/*_{DWH_COMMON_PTY_ENC}*/(ZEROIFNULL(SUM(a.einstandspreis_af)) /*_{DWH_COMMON_PTY_KEY_ENC}*/) AS total_rohertrag_af
      ,/*_{DWH_COMMON_PTY_ENC}*/(ZEROIFNULL(SUM(a.einstandspreis_sa)) /*_{DWH_COMMON_PTY_KEY_ENC}*/) AS total_rohertrag_sa
      ,/*_{DWH_COMMON_PTY_ENC}*/(ZEROIFNULL(SUM(a.einstandspreis_tot)/NULLIFZERO(SUM(a.absatz_gesamt))) /*_{DWH_COMMON_PTY_KEY_ENC}*/) AS rohertrag_einheit
      ,/*_{DWH_COMMON_PTY_ENC}*/(ZEROIFNULL(SUM(a.einstandspreis_af)/NULLIFZERO(SUM(a.absatz_af_sk1_bis6))) /*_{DWH_COMMON_PTY_KEY_ENC}*/) AS rohertrag_einheit_af
      ,/*_{DWH_COMMON_PTY_ENC}*/(ZEROIFNULL(SUM(a.einstandspreis_sa)/NULLIFZERO(SUM(a.absatz_sa_sk1_bis6))) /*_{DWH_COMMON_PTY_KEY_ENC}*/) AS rohertrag_einheit_sa
      ,ZEROIFNULL(ROUND(SUM(a.abschr_vk_o_werbung),1)) AS abschriftbetrag_netto_oWerbung
      ,/*_{DWH_COMMON_PTY_ENC}*/(ZEROIFNULL(ROUND(AVG(a.stk_ek_kb_stamm),2)) /*_{DWH_COMMON_PTY_KEY_ENC}*/) AS ek_kb_stamm
      ,ROUND(AVG(a.vkpk1),2) AS vk_brutto_pk1
      ,ROUND(AVG(a.vkpk4),2) AS vk_brutto_pk4
      ,ROUND(AVG(a.vkpk1/(CAST(f.mwst/100 + 1 AS FLOAT))),2) AS vk_netto_pk1
      ,ROUND(AVG(a.vkpk4/(CAST(f.mwst/100 + 1 AS FLOAT))),2) AS vk_netto_pk4
      ,ZEROIFNULL(SUM(a.umsatz_brutto_tot)) AS total_umsatz_netto
      ,ZEROIFNULL(SUM(a.umsatz_brutto_af)) AS total_umsatz_netto_af
      ,ZEROIFNULL(SUM(a.umsatz_brutto_sa)) AS total_umsatz_netto_sa
      ,SUM(0) AS total_anz_markt
      ,ZEROIFNULL(SUM(a.anz_wo_listung_1)) AS anz_kjwo_wup_listung
      ,SUM(0) AS anz_wup_listung --anz_listung_as_is
      ,COALESCE(MAX(CAST(c.lager_prozent AS DECIMAL(18,3))/100),1) AS lager_prozent
      ,COALESCE(MAX(CASE 
             WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz  = 0 THEN a.kol_la
             WHEN a.mhd_zeitraum  = 0 AND a.mhd_zeitraum_dz <> 0 THEN NULL
             WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz <> 0 THEN a.kol_la
             WHEN a.mhd_zeitraum  = 0 AND a.mhd_zeitraum_dz  = 0 THEN a.kol_la
           END),0) AS kol_la_bzw
      ,COALESCE(MAX(CASE 
             WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz  = 0 THEN NULL
             WHEN a.mhd_zeitraum  = 0 AND a.mhd_zeitraum_dz <> 0 THEN a.kol_bst
             WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz <> 0 THEN NULL
             WHEN a.mhd_zeitraum  = 0 AND a.mhd_zeitraum_dz  = 0 THEN NULL
           END),0) AS kol_bst_bzw
      ,COALESCE(ROUND(AVG(a.sp_ekkb_01)*100,1),0) AS spanne_ek1
      ,COALESCE(ROUND(AVG(a.sp_ekkb_04)*100,1),0) AS spanne_ek4
FROM DBP_ETL.sal_aggregat_kmo_1 a
JOIN DBP_DATA.art_1 c
  ON a.art_id = c.art_id AND
     a.mandant_id = c.mandant_id
JOIN DBP_DATA.mandant_1 d
  ON a.mandant_id = d.mandant_id
JOIN (SELECT kjmo_sort
      FROM DBP_ETL.st_wochen_1
      GROUP BY 1) e
  ON 1 = 1
JOIN DBP_DATA.mwst_per_1 f
  ON a.mandant_id = f.mandant_id AND
     c.mwst_id = f.mwst_id AND
     CURRENT_DATE BETWEEN f.dat_von AND f.dat_bis
WHERE a.kjwo IN (SELECT kjwo FROM DBP_ETL.st_wochen_1)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
         21,22,23,24,25,26
;

UPDATE DBP_DATA.sal_kmo_1 FROM (SELECT a.mandant_id,
                                                   a.art_id,
						   SUM(a.listung_id) AS anz_listung_as_is
					    FROM DBP_DATA.art_wup_zu_per_1 a
					    JOIN DBP_DATA.wup_1 b
					      ON a.mandant_id = b.mandant_id AND
						 a.wup_id = b.wup_id AND
						 a.mandant_id = b.mandant_id AND
						 CURRENT_DATE BETWEEN b.dat_von AND b.dat_bis
                                            JOIN DBP_DATA.art_wg_zu_per_1 c
					      ON a.mandant_id = c.mandant_id AND
						 a.art_id = c.art_id AND
						 c.arthiertyp_id = 2 AND
						 c.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')
					    WHERE a.mandant_id > 1 AND
						  a.listung_id = 1 AND
						  CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
					    GROUP BY 1,2) b
									 
SET anz_wup_listung = b.anz_listung_as_is

WHERE DBP_DATA.sal_kmo.art_id = b.art_id AND
      DBP_DATA.sal_kmo.mandant_id = b.mandant_id AND
      DBP_DATA.sal_kmo.kjmo IN (SELECT kjmo_sort FROM DBP_ETL.st_wochen_1)
;

UPDATE DBP_DATA.sal_kmo_1 FROM (SELECT x.mandant_id,
                                                   x.art_id,
                                                   COUNT(DISTINCT x.wup_id) AS anz_maerkte
                                            FROM (SELECT a.mandant_id,
							 a.art_id,
                                                         a.wup_id,
                                                         SUM(a.menge) AS menge
						  FROM DBP_DATA.artbew_1 a
						  JOIN DBP_ETL_PROCESS.sort_monat_woche_1 c
                                                    ON a.dat BETWEEN c.dat_sort_von AND c.dat_sort_bis
						  JOIN DBP_DATA.art_wg_zu_per_1 b
						    ON a.mandant_id = b.mandant_id AND
						       a.art_id = b.art_id AND
						       b.arthiertyp_id = 2 AND
						       b.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')
						  WHERE a.mandant_id > 1 AND
						        c.kjmo_sort IN (SELECT kjmo_sort FROM DBP_ETL.st_wochen_1)
						  GROUP BY 1,2,3
						  HAVING SUM(a.menge) > 0) x
				            GROUP BY 1,2) b
									 
SET total_anz_markt = b.anz_maerkte

WHERE DBP_DATA.sal_kmo.art_id = b.art_id AND
      DBP_DATA.sal_kmo.mandant_id = b.mandant_id AND
      DBP_DATA.sal_kmo.kjmo IN (SELECT kjmo_sort FROM DBP_ETL.st_wochen_1)
;
