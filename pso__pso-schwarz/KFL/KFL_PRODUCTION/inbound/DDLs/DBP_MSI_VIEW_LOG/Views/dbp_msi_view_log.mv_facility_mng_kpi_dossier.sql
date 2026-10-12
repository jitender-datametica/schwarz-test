create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_FACILITY_MNG_KPI_DOSSIER(
	MANDANT_ID,
	WUP_ID,
	WERK_ID,
	DAT_BUCH,
	INSTANDHALTUNGSKOSTEN_HRL_FOOD,
	INSTANDHALTUNGSKOSTEN_HRL_FOOD_FREMD,
	INSTANDHALTUNGSKOSTEN_HRL_TIKO,
	INSTANDHALTUNGSKOSTEN_HRL_TIKO_FREMD,
	INSTANDHALTUNGSKOSTEN_AHL_FOOD,
	INSTANDHALTUNGSKOSTEN_AHL_FOOD_FREMD,
	INSTANDHALTUNGSKOSTEN_AKL_FOOD,
	INSTANDHALTUNGSKOSTEN_AKL_FOOD_FREMD,
	INSTANDHALTUNGSKOSTEN_AKA_FOOD,
	INSTANDHALTUNGSKOSTEN_AKA_FOOD_FREMD,
	INSTANDHALTUNGSKOSTEN_AKL_FRISCHE,
	INSTANDHALTUNGSKOSTEN_AKL_FRISCHE_FREMD,
	INSTANDHALTUNGSKOSTEN_AKA_OG,
	INSTANDHALTUNGSKOSTEN_AKA_OG_FREMD,
	INSTANDHALTUNG_STUNDEN_HRL_FOOD,
	INSTANDHALTUNG_STUNDEN_HRL_TIKO,
	INSTANDHALTUNG_STUNDEN_AHL_FOOD,
	INSTANDHALTUNG_STUNDEN_AKL_FOOD,
	INSTANDHALTUNG_STUNDEN_AKA_FOOD,
	INSTANDHALTUNG_STUNDEN_AKL_FRISCHE,
	INSTANDHALTUNG_STUNDEN_AKA_OG,
	HRL_ANZAHL_PALETTEN_WE_BOTH,
	AHL_ANZAHL_PALETTEN_WE_BOTH,
	AKL_MENGE_LIEF_IST_KOLLI_BOTH,
	AKA_FOOD_MENGE_LIEF_IST_KOLLI_BOTH,
	FRISCHE_AKL_ANZ_KOLLI_WA_BOTH,
	AKA_MENGE_LIEF_IST_KOLLI_BOTH,
	HRL_TIKO_ANZAHL_PALETTEN_WE_BOTH
) as










					 
SELECT DISTINCT
  
 iw.mandant_id
,iw.wup_id
,iw.werk_id 
,t.dat AS dat_buch
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ( 'HRL Food / NF', 'HRL Food/NF') AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S'
              AND auftragsart_id IN ('CS56','CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg,0)= 0
             ) THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
             ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_hrl_food
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ( 'HRL Food / NF', 'HRL Food/NF') AND ist_kost.soll_haben_kz='S' AND auftragsart_id IN ('CS37','CS47','CS57','CS77')  )
           THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_hrl_food_fremd             
            
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'HRL Tiko'  AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S' 
              AND auftragsart_id IN ('CS56','CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg,0)= 0
          ) THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_hrl_tiko
 
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'HRL Tiko'  AND ist_kost.soll_haben_kz='S' AND auftragsart_id IN ('CS37','CS47','CS57','CS77'))
           THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_hrl_tiko_fremd
          
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AHL Food / NF' , 'AHL Food/NF') AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S' 
              AND auftragsart_id IN ('CS56','CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg,0)= 0
             ) THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
             ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_ahl_food
 ,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AHL Food / NF' , 'AHL Food/NF') AND ist_kost.soll_haben_kz='S'  AND auftragsart_id IN ('CS37','CS47','CS57','CS77')) 
              THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
             ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_ahl_food_fremd 
             
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AKL Food / NF', 'AKL Food/NF') AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S'   
              AND auftragsart_id IN ('CS56','CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg,0)= 0
             ) THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
             ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_akl_food
 
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AKL Food / NF', 'AKL Food/NF') AND ist_kost.soll_haben_kz='S' AND auftragsart_id IN ('CS37','CS47','CS57','CS77') )
           THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_akl_food_fremd

,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AKA Food / NF', 'AKA Food/NF') AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S'   
              AND auftragsart_id IN ('CS56','CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg,0)= 0
             ) THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
             ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_aka_food

,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AKA Food / NF', 'AKA Food/NF') AND ist_kost.soll_haben_kz='S' AND auftragsart_id IN ('CS37','CS47','CS57','CS77') )
           THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_aka_food_fremd
			 
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'AKL Frische' AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S'  
              AND auftragsart_id IN ('CS56','CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg,0)= 0
          ) THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_akl_frische

,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'AKL Frische' AND ist_kost.soll_haben_kz='S' AND auftragsart_id IN ('CS37','CS47','CS57','CS77') )
           THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_akl_frische_fremd

,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'AKA O&G' AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S' 
               AND auftragsart_id IN ('CS56','CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg,0)= 0
          ) THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_aka_og

 ,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'AKA O&G' AND ist_kost.soll_haben_kz='S' AND auftragsart_id IN ('CS37','CS47','CS57','CS77') 
             )
           THEN CASE WHEN m_wrg.wrg_typ_id = 0 THEN (ist_kost.betrag * kurs.umrechnungskurs)
          ELSE ist_kost.betrag END ELSE NULL END) AS instandhaltungskosten_aka_og_fremd   
          

,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ( 'HRL Food / NF', 'HRL Food/NF') AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S') 
             AND ist_kost.co_leistungsart_id IN ('INST01','INST02','INST03','INST04','INST05','INST06','INST07','INST08','INST09','INST10','INST70','INST71','INST72','INST73','INST74','INST75','INST76','INST88') 
             AND auftragsart_id IN ('CS36','CS46','CS56','CS76','CS34','CS35','CS44','CS45','CS54','CS55')
          THEN menge ELSE NULL END) AS instandhaltung_stunden_hrl_food

,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'HRL Tiko' AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S') 
             AND ist_kost.co_leistungsart_id IN ('INST01','INST02','INST03','INST04','INST05','INST06','INST07','INST08','INST09','INST10','INST70','INST71','INST72','INST73','INST74','INST75','INST76','INST88') 
             AND auftragsart_id IN ('CS36','CS46','CS56','CS76','CS34','CS35','CS44','CS45','CS54','CS55')
          THEN menge ELSE NULL END) AS instandhaltung_stunden_hrl_tiko
          
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AHL Food / NF', 'AHL Food/NF') AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S') 
             AND ist_kost.co_leistungsart_id IN ('INST01','INST02','INST03','INST04','INST05','INST06','INST07','INST08','INST09','INST10','INST70','INST71','INST72','INST73','INST74','INST75','INST76','INST88') 
             AND auftragsart_id IN ('CS36','CS46','CS56','CS76','CS34','CS35','CS44','CS45','CS54','CS55')
          THEN menge ELSE NULL END) AS instandhaltung_stunden_ahl_food
          
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AKL Food / NF' ,'AKL Food/NF') AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S') 
             AND ist_kost.co_leistungsart_id IN ('INST01','INST02','INST03','INST04','INST05','INST06','INST07','INST08','INST09','INST10','INST70','INST71','INST72','INST73','INST74','INST75','INST76','INST88') 
             AND auftragsart_id IN ('CS36','CS46','CS56','CS76','CS34','CS35','CS44','CS45','CS54','CS55')
          THEN menge ELSE NULL END) AS instandhaltung_stunden_akl_food
		  
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez IN ('AKA Food / NF' ,'AKA Food/NF') AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S') 
             AND ist_kost.co_leistungsart_id IN ('INST01','INST02','INST03','INST04','INST05','INST06','INST07','INST08','INST09','INST10','INST70','INST71','INST72','INST73','INST74','INST75','INST76','INST88') 
             AND auftragsart_id IN ('CS36','CS46','CS56','CS76','CS34','CS35','CS44','CS45','CS54','CS55')
          THEN menge ELSE NULL END) AS instandhaltung_stunden_aka_food
          
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'AKL Frische' AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S') 
             AND ist_kost.co_leistungsart_id IN ('INST01','INST02','INST03','INST04','INST05','INST06','INST07','INST08','INST09','INST10','INST70','INST71','INST72','INST73','INST74','INST75','INST76','INST88') 
             AND auftragsart_id IN ('CS36','CS46','CS56','CS76','CS34','CS35','CS44','CS45','CS54','CS55')
          THEN menge ELSE NULL END) AS instandhaltung_stunden_akl_frische 
          
,SUM(CASE 
        WHEN (tp_o_info.anlage_bez = 'AKA O&G' AND (ist_kost.nebenkontierungsart_id <>'OCCT' OR ist_kost.nebenkontierungsart_id IS NULL) AND ist_kost.soll_haben_kz='S') 
             AND ist_kost.co_leistungsart_id IN ('INST01','INST02','INST03','INST04','INST05','INST06','INST07','INST08','INST09','INST10','INST70','INST71','INST72','INST73','INST74','INST75','INST76','INST88') 
             AND auftragsart_id IN ('CS36','CS46','CS56','CS76','CS34','CS35','CS44','CS45','CS54','CS55')
          THEN menge ELSE NULL END) AS instandhaltung_stunden_aka_og  
          

,MAX(COALESCE(tr_auf.hrl_anz_paletten_we,0)) + MAX(COALESCE(lag_we.hrl_anz_paletten_we_ewm,0)) AS  hrl_anzahl_paletten_we_both
,MAX(COALESCE(ahl_anz_paletten_we_ewm,0)) + MAX(COALESCE(tr_auf.ahl_anz_paletten_we,0)) AS  ahl_anzahl_paletten_we_both
,MAX(COALESCE(bl_wg_wup.akl_menge_lief_ist_kolli,0)) + MAX(COALESCE(bl_wa_hu_sum.akl_menge_lief_ist_kolli_ewm,0)) AS  akl_menge_lief_ist_kolli_both
,MAX(aka_food_menge_lief_ist_kolli_ewm) AS aka_food_menge_lief_ist_kolli_both
,MAX(COALESCE(lag.akl_anz_kolli_wa,0)) + MAX(COALESCE(tr_auf.akl_anz_kolli_wa,0)) AS  frische_akl_anz_kolli_wa_both
,MAX(COALESCE(bl_wa_hu_sum.aka_menge_lief_ist_kolli,0)) + MAX(COALESCE(bl_wg_wup.aka_menge_lief_ist_kolli,0)) AS  aka_menge_lief_ist_kolli_both
,MAX(COALESCE(hrl_tiko_anz_paletten_we_ewm,0)) + MAX(COALESCE(tr_auf.hrl_tiko_anz_paletten_we,0)) AS  hrl_tiko_anzahl_paletten_we_both
      
FROM  
  (SELECT DISTINCT
              w.mandant_id
             ,w.wup_id 
             ,tpp.werk_instandhaltung_plan AS in_werk_nr
             ,w_id.werk_id           
             ,w.lagernummer_id_ewm
             FROM DBP_DATA.TECHN_PLATZ_PER tpp
             JOIN 
             (SELECT 
              mandant_id
             ,wup_id
             ,MAX(CASE WHEN ewm_fg=1 THEN lagernummer_id ELSE NULL END) AS lagernummer_id_ewm 
              FROM dbp_data.l_lagernummer GROUP BY 1,2) w
             ON tpp.mandant_id = w.mandant_id
             AND tpp.wup_id = w.wup_id
     
             JOIN dbp_view.v_in_werk w_id
             ON  tpp.werk_instandhaltung_plan = w_id.werk_nr
             AND tpp.mandant_id = w_id.mandant_id
 
              WHERE dat_bis>=CURRENT_DATE-730  AND nb_id= -111 AND techn_platz_typ_id IN ('3','4','5','7')
              AND TRY_CAST(werk_instandhaltung_plan AS NUMBER(38,0)) IS NULL
              AND werk_instandhaltung_plan IS NOT NULL 
              AND TRY_CAST(RIGHT(werk_instandhaltung_plan,2) AS NUMBER(38,0)) >= 60 
              AND tpp.wup_id<>6921 
  ORDER BY 1,2,3)iw
 
JOIN dbp_view.v_tag t ON EXTRACT(YEAR FROM t.dat) BETWEEN YEAR(CURRENT_TIMESTAMP) - 2 AND YEAR(CURRENT_TIMESTAMP)
AND LEFT(iw.in_werk_nr,2) IN ('DE','CZ','PL','SK','HR','RO','BG')
 
	
	
  LEFT JOIN  ( SELECT t1.nebenkontierungsart_id
		             ,t1.soll_haben_kz
                     ,t1.dat_buch
                     ,t1.mandant_id
                     ,t1.auftrag_id
                     ,t1.wrg_id
                     ,t1.co_leistungsart_id
		             ,t1.betrag
                     ,t1.menge
                     ,t2.werk_id
                     ,t2.auftragsart_id 
				FROM dbp_view.v_ist_kosten_det t1 
                JOIN  dbp_view.v_in_auftrag t2 
                ON t1.mandant_id=t2.mandant_id 
                AND t1.auftrag_id=t2.auftrag_id
				) ist_kost
  ON ist_kost.dat_buch=t.dat
  AND iw.mandant_id=ist_kost.mandant_id
  AND iw.werk_id=ist_kost.werk_id

  LEFT JOIN(SELECT mandant_id, auftrag_id , dat_buch, SUM(betrag)AS betrag
        FROM dbp_view.v_ist_kosten_det
        
       WHERE (nebenkontierungsart_id <>'OCCT' OR nebenkontierungsart_id IS NULL) AND soll_haben_kz='S'
	  AND  EXTRACT(YEAR FROM dat_buch) BETWEEN YEAR(CURRENT_TIMESTAMP) - 2 AND YEAR(CURRENT_TIMESTAMP)
       GROUP BY mandant_id, auftrag_id , dat_buch
       ) betrag
       ON ist_kost.mandant_id=betrag.mandant_id
       AND ist_kost.auftrag_id=betrag.auftrag_id
       AND ist_kost.dat_buch=betrag.dat_buch

   LEFT JOIN dbp_msi_view_log.mv_kurs kurs
   ON ist_kost.wrg_id = kurs.von_wrg_id
   
   INNER JOIN dbp_view.v_mandant_wrg_typ_zu m_wrg ON iw.mandant_id=m_wrg.mandant_id  
   INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU akt_user ON m_wrg.wrg_typ_id = akt_user.wrg_typ_id
   
   LEFT JOIN (SELECT DISTINCT auftrag_id,mandant_id,storno_fg, dat_buch 
   FROM dbp_view.v_in_auftrag_rm WHERE EXTRACT(YEAR FROM dat_buch) BETWEEN YEAR(CURRENT_TIMESTAMP) - 2 AND YEAR(CURRENT_TIMESTAMP)) in_auf_rm
   ON ist_kost.auftrag_id=in_auf_rm.auftrag_id
   AND ist_kost.mandant_id=in_auf_rm.mandant_id
   AND ist_kost.dat_buch=in_auf_rm.dat_buch
 
   LEFT JOIN dbp_view.v_in_instandhaltung_objekt_qual in_obj_q
   ON ist_kost.auftrag_id = in_obj_q.auftrag_id
   AND ist_kost.mandant_id = in_obj_q.mandant_id
   
   LEFT JOIN dbp_msi_view_log.v_ts_tp_objekt_info tp_o_info
   ON in_obj_q.tp_objekt_id = tp_o_info.tp_objekt_id
   AND in_obj_q.mandant_id = tp_o_info.mandant_id

        

 LEFT JOIN ( SELECT 
    wup_id
   ,mandant_id
   ,dat_quittierung
   ,SUM(hrl_anzahl_paletten_we) AS hrl_anz_paletten_we
   ,SUM(ahl_anzahl_paletten_we) AS ahl_anz_paletten_we
   ,SUM(hrl_tiko_anzahl_paletten_we) AS hrl_tiko_anz_paletten_we
   ,SUM(akl_anz_kolli_wa) AS akl_anz_kolli_wa
   ,SUM(hrl_tiko_anz_kolli_we) AS hrl_tiko_anz_kolli_we
                FROM (SELECT tr_det.wup_id
                  ,tr_det.mandant_id
                  ,tr_det.dat_quittierung
                  ,tr_det.transport_beleg_id
                  ,CASE WHEN (tr_det.von_lagertyp_id = 'IP1' AND tr_det.nach_lagertyp_id IN ( 'H01' , 'HEB' , 'HEP') AND sort.artikelsortiment_id = 1) THEN 1 ELSE 0 END AS hrl_anzahl_paletten_we 
                  ,CASE WHEN (tr_det.von_lagertyp_id = 'BF1' AND tr_det.nach_lagertyp_id IN ( 'IHL')) THEN 1 ELSE 0 END AS ahl_anzahl_paletten_we 
                  ,CASE WHEN (tr_det.von_lagertyp_id = 'IP1' AND tr_det.nach_lagertyp_id IN ( 'H01' , 'HEB' , 'HEP') AND sort.artikelsortiment_id = 4) THEN 1 ELSE 0 END AS hrl_tiko_anzahl_paletten_we 
                  ,CASE WHEN (tr_det.von_lagertyp_id = 'G08' AND tr_det.nach_lagertyp_id = '916') THEN menge_transportauftrag_kolli ELSE 0 END AS akl_anz_kolli_wa
                  ,CASE WHEN (tr_det.von_lagertyp_id = 'UP1' AND tr_det.nach_lagertyp_id = 'IT1') THEN menge_transportauftrag_kolli ELSE 0 END AS hrl_tiko_anz_kolli_we

                  FROM dbp_view.v_transportauftrag_det tr_det
           JOIN DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM sort
           ON tr_det.mandant_id = sort.mandant_id
           AND tr_det.wup_id = sort.wup_id
           AND tr_det.lagernummer_id = sort.lagernummer_id
           AND tr_det.nb_id = sort.nb_id
		   WHERE EXTRACT(YEAR FROM dat_quittierung) BETWEEN YEAR(CURRENT_TIMESTAMP) - 2 AND YEAR(CURRENT_TIMESTAMP))                   
        GROUP BY
        wup_id
       ,mandant_id
       ,dat_quittierung)tr_auf
       
ON  iw.wup_id = tr_auf.wup_id
AND iw.mandant_id = tr_auf.mandant_id
AND t.dat = tr_auf.dat_quittierung


LEFT JOIN ( SELECT
             lagernummer_id
            ,mandant_id
            ,dat_we
            ,SUM (hrl_anzahl_paletten_we_ewm) AS hrl_anz_paletten_we_ewm
            ,SUM (hrl_tiko_anzahl_paletten_we_ewm) AS hrl_tiko_anz_paletten_we_ewm
			,SUM (ahl_anzahl_paletten_we_ewm) AS ahl_anz_paletten_we_ewm
             FROM(
                    SELECT ordim_c.lagernummer_id
                  ,ordim_c.handling_unit_id_nach
                  ,ordim_c.mandant_id
                  ,CAST(ordim_c.datzeit_we AS DATE) AS dat_we
                  ,CASE WHEN rollb.lageraufgabe_id IS NOT NULL THEN 1 ELSE 0 END AS rollback_fg
                  ,CASE WHEN ordim_c.lagerprozessart_id IN ('0E01' , '0E02', '0E03') AND ordim_c.status_id ='C' AND rollback_fg = '0' AND ordim_c.lagertyp_id_nach IN ('1IHP', '5IHP') THEN 1 ELSE 0 END AS hrl_anzahl_paletten_we_ewm 
                  ,CASE WHEN ordim_c.lagerprozessart_id IN ('0E01' , '0E02', '0E03') AND ordim_c.status_id ='C' AND rollback_fg = '0' AND ordim_c.lagertyp_id_nach IN ('4IHP','4IAP') THEN 1 ELSE 0 END AS hrl_tiko_anzahl_paletten_we_ewm
				  ,CASE WHEN ordim_c.lagerprozessart_id IN ('0E01' , '0E02', '0E03') AND ordim_c.status_id ='C' AND rollback_fg = '0' AND ordim_c.lagertyp_id_nach IN ('1ILP') THEN 1 ELSE 0 END AS ahl_anzahl_paletten_we_ewm
                  FROM dbp_view.v_lageraufgabe ordim_c
                  LEFT JOIN dbp_view.v_lageraufgabe rollb 
                    ON ordim_c.mandant_id=rollb.mandant_id
                    AND ordim_c.handling_unit_guid_nach = rollb.handling_unit_guid_nach
                    AND rollb.lagerprozessart_id='0E01'
                    AND rollb.lagerprozesstyp_id='5'
                    AND rollb.status_id='A'
				WHERE EXTRACT(YEAR FROM ordim_c.datzeit_we) BETWEEN YEAR(CURRENT_TIMESTAMP) - 2 AND YEAR(CURRENT_TIMESTAMP)
                  )
                  GROUP BY
                   lagernummer_id
                  ,mandant_id
                  ,dat_we
                  ) lag_we
ON  iw.lagernummer_id_ewm = lag_we.lagernummer_id
AND iw.mandant_id = lag_we.mandant_id
AND t.dat = lag_we.dat_we


LEFT JOIN (  SELECT ordim_c.lagernummer_id
             ,ordim_c.mandant_id
             ,CAST(ordim_c.datzeit_quittierung AS DATE) AS dat_quittierung
             ,SUM(menge_kolli) AS akl_anz_kolli_wa
              FROM dbp_view.v_lageraufgabe ordim_c
              WHERE lagertyp_id_von = '3GAB'
AND EXTRACT(YEAR FROM datzeit_quittierung) BETWEEN YEAR(CURRENT_TIMESTAMP) - 2 AND YEAR(CURRENT_TIMESTAMP)			  
             GROUP BY
                   ordim_c.lagernummer_id
                  ,ordim_c.mandant_id
                  ,dat_quittierung
                  ) lag
ON  iw.lagernummer_id_ewm = lag.lagernummer_id
AND iw.mandant_id = lag.mandant_id
AND t.dat = lag.dat_quittierung


 
 LEFT JOIN ( SELECT 
    wup_id
   ,mandant_id
   ,dat_lief_soll
   ,SUM(akl_menge_lief_ist_kolli) AS akl_menge_lief_ist_kolli
   ,SUM(aka_menge_lief_ist_kolli) AS aka_menge_lief_ist_kolli
                FROM( SELECT bl_wg_wup.wup_id
                  ,bl_wg_wup.mandant_id
                  ,bl_wg_wup.dat_lief_soll
                  ,CASE WHEN bl_wg_wup.lief_pal_typ_id = '7' AND bl_wg_wup.lief_typ_id IN ('YM', 'YU','YNOT','NL','ZLFI','ZLCC')THEN bl_wg_wup.menge_lief_ist_kolli ELSE 0 END AS akl_menge_lief_ist_kolli						  
                  ,CASE WHEN bl_wg_wup.lief_pal_typ_id = '8' AND bl_wg_wup.lief_typ_id IN ('YM', 'YU','YNOT','NL','ZLFI','ZLCC')THEN bl_wg_wup.menge_lief_ist_kolli ELSE 0 END AS aka_menge_lief_ist_kolli
                 FROM dbp_view.v_besch_lief_wg_wup bl_wg_wup
				 
				 LEFT JOIN dbp_msi_data.ts_lagerort_ewm_dat v06
				  ON bl_wg_wup.mandant_id=v06.mandant_id
				   AND bl_wg_wup.wup_id=v06.wup_id
				   AND bl_wg_wup.lagerort_id=v06.lagerort_id
				 WHERE
				  ( v06.mandant_id IS NULL OR NOT  bl_wg_wup.dat_lief_soll >= v06.dat)
				  AND EXTRACT(YEAR FROM dat_lief_soll) BETWEEN YEAR(CURRENT_TIMESTAMP) - 2 AND YEAR(CURRENT_TIMESTAMP)
				 )             
               GROUP BY
                  wup_id
                 ,mandant_id
                 ,dat_lief_soll) bl_wg_wup
 ON  iw.wup_id = bl_wg_wup.wup_id
 AND iw.mandant_id = bl_wg_wup.mandant_id
 AND t.dat = bl_wg_wup.dat_lief_soll
 

  LEFT JOIN ( SELECT 
    wup_id
   ,mandant_id
   ,dat_lief_soll
   ,SUM(akl_menge_lief_ist_kolli) AS akl_menge_lief_ist_kolli_ewm
   ,SUM(aka_food_menge_lief_ist_kolli) AS aka_food_menge_lief_ist_kolli_ewm
   ,SUM(aka_menge_lief_ist_kolli) AS aka_menge_lief_ist_kolli
                FROM( SELECT bl_wa_hu_sum.wup_id
                  ,bl_wa_hu_sum.mandant_id
                  ,bl_wa_hu_sum.dat_lief_soll
                  ,CASE WHEN (bl_wa_hu_sum.lief_pal_typ_id = '7' AND bl_wa_hu_sum.lief_typ_id IN ('YM', 'YU','YNOT','NL','ZLFI','ZLCC'))THEN bl_wa_hu_sum.menge_lief_ist_kolli ELSE 0 END AS akl_menge_lief_ist_kolli
		  ,CASE WHEN (bl_wa_hu_sum.lief_pal_typ_id = 'J' AND bl_wa_hu_sum.lief_typ_id IN ('YM', 'YU','YNOT','NL','ZLFI','ZLCC'))THEN bl_wa_hu_sum.menge_lief_ist_kolli ELSE 0 END AS aka_food_menge_lief_ist_kolli
		  ,CASE WHEN (bl_wa_hu_sum.lief_pal_typ_id = '8' AND bl_wa_hu_sum.lief_typ_id IN ('YM', 'YU','YNOT','NL','ZLFI','ZLCC'))THEN bl_wa_hu_sum.menge_lief_ist_kolli ELSE 0 END AS aka_menge_lief_ist_kolli  
 
                 FROM dbp_view.v_besch_lief_wa_hu_sum bl_wa_hu_sum 
				 
				 LEFT JOIN dbp_msi_data.ts_lagerort_ewm_dat v06
				  ON bl_wa_hu_sum.mandant_id=v06.mandant_id
				   AND bl_wa_hu_sum.wup_id=v06.wup_id
				   AND bl_wa_hu_sum.lagerort_id=v06.lagerort_id
				 WHERE
				  ( v06.mandant_id IS NOT NULL OR NOT  bl_wa_hu_sum.dat_lief_soll < v06.dat)
				  AND EXTRACT(YEAR FROM dat_lief_soll) BETWEEN YEAR(CURRENT_TIMESTAMP) - 2 AND YEAR(CURRENT_TIMESTAMP))
                   
   GROUP BY
    wup_id
   ,mandant_id
   ,dat_lief_soll) bl_wa_hu_sum
 ON  iw.wup_id = bl_wa_hu_sum.wup_id
 AND iw.mandant_id = bl_wa_hu_sum.mandant_id
 AND t.dat = bl_wa_hu_sum.dat_lief_soll

   
GROUP BY 
 iw.mandant_id
,iw.wup_id
,iw.werk_id 
,t.dat;
