CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_scm_materialized.mv_fehlmengen_1(USERID STRING) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.lagerort_id,
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
  ELSE -1
  END AS prio_id,
 V02.loesch_id AS loesch_id_hist
FROM kfl_production_dbp_view.v_besch_lief_fehlmengen_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V05.mandant_id = CASE
      WHEN V01.mandant_id_empfaenger IS NULL OR V01.mandant_id_empfaenger = 0
      THEN V01.mandant_id
      ELSE V01.mandant_id_empfaenger
      END AND V01.empfaenger_wup_id = V05.wup_id AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND
       V05.wup_id = 0) AND V01.bestellart_id NOT IN ('ZFHS', 'ZWFH', 'ZWHM', 'ZWHS', 'ZLUB', 'UB2K', 'UBF1', 'UBFL',
    'ZFLS', 'ZFW1')
 INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_kurs_1 AS KURS_1 ON V01.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON V01.dat_lief_soll = T.dat
 INNER JOIN kfl_production_dbp_msi_view_scm_materialized.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS USER_WRG ON TRUE
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02
      .art_id AND V01.wup_id = V02.wup_id AND V01.nb_id = V02.nb_id AND V01.dat_lief_soll BETWEEN V02.dat_von AND V02.dat_bis
   
WHERE T.akt_kj BETWEEN -2 AND 0;