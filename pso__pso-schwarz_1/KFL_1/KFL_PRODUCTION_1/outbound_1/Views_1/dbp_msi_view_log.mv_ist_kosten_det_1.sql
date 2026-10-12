-- 2023-03-13, dknop, adding storno_fg
 -- 2023-02-07, AP0133256,SPEC0166769,dknop, adding auftragsart_id

-- 2024-03-12, dknop, correcting joint to dbp_msi_view_log.v_ts_in_werk_flaeche_per_1

-- 2024-02-19, dknop, adding TECHN_PLATZ_ID
 -- 2024-03-11, updating definition of flaeche_qm

-- 2024-08-27, AP0226234,SPEC0255818, dknop, change tp_objekt_id source from v_in_instandhaltung_objekt_qual_1 to v_in_instandhaltung_1, adding REFERENZ_AUFTRAG_ID, LEISTUNGSART_REFERENZBELEG, FOLGEAUFTRAG_FG,KOSTENSTELLE_ID,VERANTW_ARBEITSPLATZ_NAME,STANDORT_ID,

-- 2022-08-19, AP0133256,SPEC0166769,dknop, initial

-- 2025-04-15, dknop, correcting CROSS JOIN to v_in_instandhaltung_1 for referenz_auftrag_id

-- 2024-12-13, dknop, removing try_cast from standort_id definition and changing it to STRING from INTEGER

-- 2024-03-12, dknop, updating definition of tp_objekt_id to avoid duplications

-- 2022-12-19, AP0133256,SPEC0166769,dknop, adding flaeche_qm

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_ist_kosten_det_1(USERID STRING) AS SELECT V01.mandant_id,
 V01.psp_id,
 V01.gj,
 V01.buchungsperiode_id,
 V01.krk_id,
 V01.soll_haben_kz,
 V01.kostenart_id,
 V01.dat_beleg,
 V01.beleg_id,
 V01.beleg_pos_id,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.betrag * V02.umrechnungskurs
  ELSE V01.betrag
  END AS betrag,
 V03.wrg_id,
 V03.wrg_typ_id,
 V01.geschaeftsbereich_id,
 V01.beleg_bez,
 V01.in_lief_id,
 V01.nebenkontierung_id,
 COALESCE(V01.nebenkontierungsart_id, '') AS nebenkontierungsart_id,
 V01.berichts_position_it_id,
 V01.berichts_position_invest_id,
 V01.sparte_id,
 V01.auftrag_id,
 V05.referenz_auftrag_id AS referenzbeleg,
 V07B.instandhaltung_leistungsart_id AS leistungsart_referenzbeleg,
  CASE
  WHEN COALESCE(V07.instandhaltung_leistungsart_id, V07A.instandhaltung_leistungsart_id) = '003' AND V07B.instandhaltung_leistungsart_id
     IN ('001', '002', '012', '019')
  THEN 1
  ELSE 0
  END AS folgeauftrag_fg,
 V05.kostenstelle_id AS kostenstelle_id_auftrag,
 V05.verantw_arbeitsplatz_name,
 COALESCE(COALESCE(CAST(V09.aktuell_wup_id AS STRING), V05.standort_id), '-1') AS standort_id,
 V01.in_art_id,
 V01.buchungskreis_id,
 COALESCE(V01.anlage_id, '-1') AS anlage_id,
 V01.anlage_sub_id,
 V01.dat_buch,
 V01.menge,
 V01.menge_einh_id
 -- ,COALESCE(CASE WHEN v01.kostenstelle_id = '' THEN NULL ELSE v01.kostenstelle_id END,'-1') AS kostenstelle_id
,
 COALESCE(CASE
   WHEN V01.kostenstelle_id = ''
   THEN NULL
   ELSE V01.kostenstelle_id
   END, '') AS kostenstelle_id,
 V01.gegenkonto_id,
 V01.gegenkontoart_id,
 V01.ref_beleg_id,
 V01.ref_fi_beleg_id,
 V01.in_fi_belegkopftext,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.partner_objektart_id,
 V01.partner_objekt_id,
 V01.bestell_text,
 V01.ref_buchungskreis_id,
 V01.belegart_id,
 V01.belastungs_kz,
 V01.ref_vorgang_id,
  CASE
  WHEN V01.co_leistungsart_id = ''
  THEN '-1'
  ELSE V01.co_leistungsart_id
  END AS co_leistungsart_id,
 V05.auftragsart_id,
 V05.werk_id,
  CASE
  WHEN V05.auftragsart_id IN ('CS76', 'CS77', 'CS46', 'CS47')
  THEN V06.flaeche_qm
  ELSE NULL
  END AS flaeche_qm,
 COALESCE(COALESCE(V07.tp_objekt_id, V07A.tp_objekt_id), -1) AS tp_objekt_id,
 V05.auftrag_kurztext,
 COALESCE(v08.storno_fg, 0) AS storno_fg,
 COALESCE(V05.techn_platz_id, '-1') AS techn_platz_id
FROM kfl_production_dbp_view.v_ist_kosten_det_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_1 AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS V04 ON V03.wrg_typ_id = V04.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_in_auftrag_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.auftrag_id = V05.auftrag_id
   
 LEFT JOIN kfl_production_dbp_msi_view_log.v_ts_in_werk_flaeche_per_1 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.werk_id
      = V06.werk_id AND LOWER(V06.gebaeude_bez) LIKE LOWER('TOTAL') AND V01.dat_buch BETWEEN V06.dat_von AND V06.dat_bis
   
 LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_1 AS V07 ON V01.auftrag_id = V07.auftrag_id AND V01.mandant_id =
    V07.mandant_id AND V07.tp_objekt_id <> 0
 LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_1 AS V07A ON V01.auftrag_id = V07A.auftrag_id AND V01.mandant_id =
    V07A.mandant_id AND V07A.tp_objekt_id = 0
 LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_1 AS V07B ON V05.referenz_auftrag_id = V07B.auftrag_id AND V05.mandant_id
    = V07B.mandant_id
 LEFT JOIN kfl_production_dbp_data.wup_1 AS V09 ON ROUND(SAFE_CAST(V05.standort_id AS BIGNUMERIC), 0) = V09.wup_id AND V05
   .mandant_id = V09.mandant_id
 LEFT JOIN (SELECT DISTINCT auftrag_id,
   mandant_id,
   dat_buch,
   storno_fg
  FROM kfl_production_dbp_view.v_in_auftrag_rm_1) AS v08 ON V01.auftrag_id = v08.auftrag_id AND V01.mandant_id = v08.mandant_id
     AND V01.dat_buch = v08.dat_buch
WHERE EXTRACT(YEAR FROM V01.dat_buch) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;