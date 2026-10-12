-- 2024-04-22, AP0179753, dknop, initial

-- 2024-05-17, dknop, change to inner join KFL_PRODUCTION.dbp_view.v_art_wup_status_per

-- 2024-07-26, dknop, adding 'UBF1','UBFL','ZFLS','ZFW1'  to the filter

-- 2025-03-11, nwag, adding best_beleg_id + best_beleg_pos_id

-- 2024-05-23, dknop, adding loesch_id_hist, including umrechnungskurs in calculations

-- 2024-06-13, dknop, adding UB2K to the filter
 -- 2024-07-19, nwag, switching to regular table

-- 2024-06-04, dknop, adding t.akt_kj BETWEEN -2 AND 0

-- 2024-08-05,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm.mv_fehlmengen(USERID STRING) AS
-- AND v05.wup_id = CASE WHEN TRY_CAST(empfaenger_wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(empfaenger_wup_id AS INTEGER) END

SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.lagerort_id -- ,v01.empfaenger_wup_id

 -- , CASE WHEN TRY_CAST(empfaenger_wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END empfaenger_wup_id

 ,
 V05.aktuell_wup_id AS empfaenger_wup_id,
 V01.mandant_id_empfaenger,
 V01.empfaenger_nb_id,
 V01.art_id,
 V01.dat_lief_soll,
 V01.bestellart_id,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN 'EUR'
  ELSE V01.wrg_id
  END AS wrg_id,
 COALESCE(V01.kuerzung_fg, 0) AS lieferungskuerzung_fg,
  CASE
  WHEN COALESCE(V01.kuerzung_fg, 0) = 1
  THEN 'F'
  ELSE V01.diff_id
  END AS diff_id,
 V01.menge_lief_soll_kolli,
  CASE
  WHEN V01.menge_lief_ist_kolli > V01.menge_lief_soll_kolli
  THEN V01.menge_lief_soll_kolli
  ELSE V01.menge_lief_ist_kolli
  END AS menge_lief_ist_kolli,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN V01.vk_netto_soll * KURS.umrechnungskurs
  ELSE V01.vk_netto_soll
  END AS vk_netto_lief_soll,
  CASE
  WHEN V01.vk_netto_ist > V01.vk_netto_soll
  THEN CASE
   WHEN USER_WRG.wrg_typ_id = 0
   THEN V01.vk_netto_soll * KURS.umrechnungskurs
   ELSE V01.vk_netto_soll
   END
  ELSE CASE
   WHEN USER_WRG.wrg_typ_id = 0
   THEN V01.vk_netto_ist * KURS.umrechnungskurs
   ELSE V01.vk_netto_ist
   END
  END AS vk_netto_lief_ist,
 V01.kuerz_menge_lief_soll_kolli AS kz_menge_lief_soll_kolli,
 V01.kuerz_menge_lief_ist_kolli AS kz_menge_lief_ist_kolli,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN V01.kuerz_vk_netto_soll * KURS.umrechnungskurs
  ELSE V01.kuerz_vk_netto_soll
  END AS kz_vk_netto_lief_soll,
  CASE
  WHEN USER_WRG.wrg_typ_id = 0
  THEN V01.kuerz_vk_netto_ist * KURS.umrechnungskurs
  ELSE V01.kuerz_vk_netto_ist
  END AS kz_vk_netto_lief_ist,
 V02.loesch_id,
 V02.kdis,
 V02.disponent_id,
  CASE
  WHEN V02.loesch_id IN ('A', 'L', 'R')
  THEN 1
  WHEN V01.kuerzung_fg > 1 AND V01.menge_lief_soll_kolli > V01.menge_lief_ist_kolli
  THEN 2
  WHEN V02.loesch_id IN ('F1', 'F2')
  THEN 3
  WHEN V01.kuerzung_fg = 0 AND V01.menge_lief_soll_kolli > V01.menge_lief_ist_kolli
  THEN 4
  WHEN V01.bestellart_id = 'UBE'
  THEN 5
  ELSE 0
  END AS grund_id,
  CASE
  WHEN V02.loesch_id IN ('A', 'L', 'R', 'F1', 'F2')
  THEN 1
  WHEN V01.kuerzung_fg > 1 AND V01.menge_lief_soll_kolli > V01.menge_lief_ist_kolli
  THEN 4
  WHEN V01.kuerzung_fg = 0 AND V01.menge_lief_soll_kolli > V01.menge_lief_ist_kolli
  THEN 3
  WHEN V01.bestellart_id = 'UBE'
  THEN 2
  ELSE - 1
  END AS prio_id,
 V02.loesch_id AS loesch_id_hist
FROM kfl_production_dbp_view.v_besch_lief_fehlmengen AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V05.mandant_id = CASE
      WHEN V01.mandant_id_empfaenger IS NULL OR V01.mandant_id_empfaenger = 0
      THEN V01.mandant_id
      ELSE V01.mandant_id_empfaenger
      END AND V01.empfaenger_wup_id = V05.wup_id AND (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1
      AND V05.wup_id = 0) AND V01.bestellart_id NOT IN ('ZFHS', 'ZWFH', 'ZWHM', 'ZWHS', 'ZLUB', 'UB2K', 'UBF1', 'UBFL',
    'ZFLS', 'ZFW1')
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_kurs AS KURS ON V01.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_tag AS T ON V01.dat_lief_soll = T.dat
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS USER_WRG ON TRUE
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02
      .art_id AND V01.wup_id = V02.wup_id AND V01.nb_id = V02.nb_id AND V01.dat_lief_soll BETWEEN V02.dat_von AND V02.dat_bis
   
WHERE T.akt_kj BETWEEN - 2 AND 0;