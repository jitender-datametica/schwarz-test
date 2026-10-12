CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_soll_ist AS SELECT V01.mandant_id,
 V01.in_art_id,
 V01.charge_id,
 V01.werk_id,
 V01.dat_soll_ist,
 V01.auftrag_id,
 V01.wechsel_id,
 V01.in_lief_id,
 V01.ist_menge_bme,
 V01.ist_menge_dme,
 V01.dme_einh_id,
 V01.basismenge_einh_id,
 V01.best_beleg_id,
 V01.input_material_typ_id,
 V01.soll_menge_bme,
 V01.zerl_soll_menge_bme,
 V01.betrag_soll_ist,
 V01.wrg_id,
 V01.trennprozess_id,
 V01.schnittliste_id,
 V01.sek_schl_id,
 V01.soll_ohne_ist_fg,
 CAST(CASE
   WHEN V01.wrg_id_dt8 <> V01.default_wrg AND V200.wrg_typ_id = 0 OR V01.wrg_id_dt8 = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN 1.0000
   WHEN V01.wrg_id_dt8 = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V500.umrechnungskurs
   WHEN V01.wrg_id_dt8 <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN 1.0000 / V500.umrechnungskurs
   ELSE NULL
   END AS BIGNUMERIC) AS umrechkurs_mbew,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0 OR V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN 1.0000
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V500.umrechnungskurs
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN 1.0000 / V500.umrechnungskurs
   ELSE NULL
   END AS BIGNUMERIC) AS umrechkurs_sollist,
 CAST(CASE
   WHEN V01.wrg_id_v06 <> V01.default_wrg AND V200.wrg_typ_id = 0 OR V01.wrg_id_v06 = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN 1.0000
   WHEN V01.wrg_id_v06 = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V500.umrechnungskurs
   WHEN V01.wrg_id_v06 <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN 1.0000 / V500.umrechnungskurs
   ELSE NULL
   END AS BIGNUMERIC) AS umrechkurs_marktpreis,
 CAST(CASE
    WHEN V01.preis_steuer_kz = 'V'
    THEN COALESCE(V01.gld / V01.preis_faktor, 0)
    WHEN V01.preis_steuer_kz = 'S'
    THEN COALESCE(V01.standard_preis / V01.preis_faktor, 0)
    ELSE NULL
    END * CAST(CASE
     WHEN V01.wrg_id_dt8 <> V01.default_wrg AND V200.wrg_typ_id = 0 OR V01.wrg_id_dt8 = V01.default_wrg AND V200.wrg_typ_id = 1
     THEN 1.0000
     WHEN V01.wrg_id_dt8 = V01.default_wrg AND V200.wrg_typ_id = 0
     THEN V500.umrechnungskurs
     WHEN V01.wrg_id_dt8 <> V01.default_wrg AND V200.wrg_typ_id = 1
     THEN 1.0000 / V500.umrechnungskurs
     ELSE NULL
     END AS BIGNUMERIC) AS NUMERIC) AS bewertungspreis_me,
 ROUND(CAST(V01.betrag_soll_ist * CAST(CASE
      WHEN V01.wrg_id_dt8 <> V01.default_wrg AND V200.wrg_typ_id = 0 OR V01.wrg_id_dt8 = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1.0000
      WHEN V01.wrg_id_dt8 = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id_dt8 <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1.0000 / V500.umrechnungskurs
      ELSE NULL
      END AS BIGNUMERIC) AS NUMERIC), 6) AS preis_kalk,
 ROUND(CAST(V01.bruttopreis * CAST(CASE
      WHEN V01.wrg_id_v06 <> V01.default_wrg AND V200.wrg_typ_id = 0 OR V01.wrg_id_v06 = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1.0000
      WHEN V01.wrg_id_v06 = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id_v06 <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1.0000 / V500.umrechnungskurs
      ELSE NULL
      END AS BIGNUMERIC) AS NUMERIC), 6) AS markt_preis,
 ROUND(CAST(V01.nettopreis * CAST(CASE
      WHEN V01.wrg_id_v06 <> V01.default_wrg AND V200.wrg_typ_id = 0 OR V01.wrg_id_v06 = V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1.0000
      WHEN V01.wrg_id_v06 = V01.default_wrg AND V200.wrg_typ_id = 0
      THEN V500.umrechnungskurs
      WHEN V01.wrg_id_v06 <> V01.default_wrg AND V200.wrg_typ_id = 1
      THEN 1.0000 / V500.umrechnungskurs
      ELSE NULL
      END AS BIGNUMERIC) AS NUMERIC), 6) AS markt_preis_netto
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_soll_ist AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id_dt8 = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_soll_ist BETWEEN V500.dat_von AND V500.dat_bis;