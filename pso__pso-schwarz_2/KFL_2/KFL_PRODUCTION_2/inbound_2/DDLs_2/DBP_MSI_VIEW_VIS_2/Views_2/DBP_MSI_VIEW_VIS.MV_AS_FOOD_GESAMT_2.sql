CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AS_FOOD_GESAMT_2(
      ART_ID
      ,MANDANT_ID
      ,NB_ID
      ,WUP_ID
      ,WRG_ID
      ,DAT_AUSLISTUNG
      ,PHASE_ID
      ,KJWO
      ,PHASE_WO
      ,PHASE_VK_BRUTTO
      ,PHASE_VK_NETTO
      ,GP_ID
      ,PHASE_STATUS
      ,ERL_FG
      ,DAT_FINAL
      ,ERL_KZ
      ,DAT_AEND
      ,MENGE_PREISABSCHRIFT
      ,BETRAG_PREISABSCHRIFT_NETTO
      ,MENGE_TOTALABSCHRIFT
      ,BETRAG_TOTALABSCHRIFT_NETTO	
      ,MENGE_ENDBESTAND_PHASE
      ,MENGE_ABSATZ
      ,UMSATZ_NETTO
      ,MENGE_STARTBESTAND
      ,VK_NETTO
      ,VK_NETTO_START_BESTAND
      ,MENGE_ENDBESTAND
      ,RANK_PHASE_WO
) AS

   -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]


SELECT
      v01.art_id
      , v01.mandant_id
      , v01.nb_id
      , wup.aktuell_wup_id                                              AS wup_id
      , krs.nach_wrg_id 											               AS wrg_id
      , v01.dat_auslistung
      , v01.phase_id
      , v01.kjwo
      , v01.phase_wo
      , v01.phase_vk_brutto * krs.umrechnungskurs 					         AS phase_vk_brutto
      , v01.phase_vk_netto * krs.umrechnungskurs 					         AS phase_vk_netto
      , v02.gp_id
      , v02.phase_status
      , v02.erl_fg
      , v02.dat_final
      , v02.erl_kz
      , v02.dat_aend
      , v01.menge_preisabschrift 									            AS menge_preisabschrift
      , v01.betrag_preisabschrift_netto * krs.umrechnungskurs           AS betrag_preisabschrift_netto
      , v01.menge_totalabschrift 									            AS menge_totalabschrift 
      , v01.betrag_totalabschrift_netto * krs.umrechnungskurs           AS betrag_totalabschrift_netto
      , v01.menge_endbestand_phase
      , v01.menge_absatz 											               AS menge_absatz 
      , v01.umsatz_netto * krs.umrechnungskurs 						         AS umsatz_netto
      , ZEROIFNULL(v04.menge_startbestand) 							         AS menge_startbestand
      , v04.vk_netto * krs.umrechnungskurs 							         AS vk_netto
      , v04.menge_startbestand * v04.vk_netto * krs.umrechnungskurs	   AS vk_netto_start_bestand
      , ZEROIFNULL(v05.menge_endbestand) 							            AS menge_endbestand
      , RANK() OVER (PARTITION BY v01.art_id, v01.mandant_id, wup.aktuell_wup_id, v01.kjwo ORDER BY v01.phase_wo DESC ) AS RANK_PHASE_WO
FROM dbp_view.v_as_food_det_2 v01
  
JOIN dbp_view.v_as_food_2 v02
ON  v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
AND v01.wup_id = v02.wup_id
AND v01.nb_id = v02.nb_id
AND v01.dat_auslistung = v02.dat_auslistung

--getting the startbestand
LEFT JOIN (
      SELECT 
      v02.mandant_id
      , v02.art_id
      , v02.wup_id
      , v02.nb_id
      , v02.dat_auslistung
      , v01.phase_id
      , v02.menge_startbestand
      , v02.vk_netto
      , MIN(v01.kjwo) AS kjwo
      
      FROM dbp_view.v_as_food_det_2 v01
      
      JOIN dbp_view.v_as_food_2 v02
         ON  v01.mandant_id = v02.mandant_id
         AND v01.art_id = v02.art_id
         AND v01.wup_id = v02.wup_id
         AND v01.nb_id = v02.nb_id
         AND v01.dat_auslistung = v02.dat_auslistung
      
      WHERE v01.phase_id = 0
      GROUP BY 1,2,3,4,5,6,7,8
) v04
ON  v01.mandant_id = v04.mandant_id
AND v01.art_id = v04.art_id
AND v01.wup_id = v04.wup_id
AND v01.nb_id = v04.nb_id
AND v01.dat_auslistung = v04.dat_auslistung
AND v01.phase_id = v04.phase_id
AND v01.kjwo = v04.kjwo

--getting the endbestand
LEFT JOIN (
   SELECT 
      v02.mandant_id
      , v02.art_id
      , v02.wup_id
      , v02.nb_id
      , v02.dat_auslistung
      , v02.menge_endbestand
      , v02.vk_netto
      , MAX(v01.phase_id) AS phase_id
      , MAX(v01.kjwo) AS kjwo
      
   FROM dbp_view.v_as_food_det_2 v01
      
   JOIN dbp_view.v_as_food_2 v02
   ON  v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND v01.wup_id = v02.wup_id
   AND v01.nb_id = v02.nb_id
   AND v01.dat_auslistung = v02.dat_auslistung

   WHERE v01.phase_id = phase_id
   GROUP BY 1,2,3,4,5,6,7
) v05
ON  v01.mandant_id = v05.mandant_id
AND v01.art_id = v05.art_id
AND v01.wup_id = v05.wup_id
AND v01.nb_id = v05.nb_id
AND v01.dat_auslistung = v05.dat_auslistung
AND v01.phase_id = v05.phase_id
AND v01.kjwo = v05.kjwo

JOIN dbp_view.v_mandant_2 v03
ON v01.mandant_id = v03.mandant_id

INNER JOIN ( 
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
    FROM dbp_data.kurs_2 krs1 
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
    UNION ALL 
    SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
    FROM dbp_data.kurs_2 krs2 
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = v03.default_wrg

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

;