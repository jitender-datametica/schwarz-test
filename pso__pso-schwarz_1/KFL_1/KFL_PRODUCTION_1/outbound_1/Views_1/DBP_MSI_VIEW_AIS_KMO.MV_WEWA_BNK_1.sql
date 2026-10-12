CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wewa_bnk_1 (mandant_id, art_id, gp_id, wewa_beleg_id,
wewa_beleg_pos_id, wewa_jahr, konditionsart_id, dat_buch, wup_id, nb_id, betrag_bnk, wewa_betrag_bnk_zl,
wewa_betrag_bnk_dz, wewa_betrag_bnk_ret_zl, wewa_betrag_bnk_ret_dz, vorz, posten_kz_per) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.gp_id,
 V01.wewa_beleg_id,
 V01.wewa_beleg_pos_id,
 V01.wewa_jahr,
 V02.konditionsart_id,
 V01.dat_buch,
 V01.wup_id,
 V01.nb_id,
   CASE
   WHEN V02.soll_haben_kz = 'H'
   THEN 1
   ELSE - 1
   END * CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN V02.betrag_kondition
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN V02.betrag_kondition * V300.umrechnungskurs
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN V02.betrag_kondition * V400.umrechnungskurs
    ELSE NULL
    END AS NUMERIC) AS betrag_bnk,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = - 111
  THEN CASE
    WHEN V02.soll_haben_kz = 'H'
    THEN 1
    ELSE - 1
    END * CAST(CASE
     WHEN V200.wrg_typ_id = 1
     THEN V02.betrag_kondition
     WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
     THEN V02.betrag_kondition * V300.umrechnungskurs
     WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
     THEN V02.betrag_kondition * V400.umrechnungskurs
     ELSE NULL
     END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_bnk_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (101, 102, 901, 902) AND V01.nb_id = 0
  THEN CASE
    WHEN V02.soll_haben_kz = 'H'
    THEN 1
    ELSE - 1
    END * CAST(CASE
     WHEN V200.wrg_typ_id = 1
     THEN V02.betrag_kondition
     WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
     THEN V02.betrag_kondition * V300.umrechnungskurs
     WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
     THEN V02.betrag_kondition * V400.umrechnungskurs
     ELSE NULL
     END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_bnk_dz,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = - 111
  THEN CASE
    WHEN V02.soll_haben_kz = 'H'
    THEN 1
    ELSE - 1
    END * CAST(CASE
     WHEN V200.wrg_typ_id = 1
     THEN V02.betrag_kondition
     WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
     THEN V02.betrag_kondition * V300.umrechnungskurs
     WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
     THEN V02.betrag_kondition * V400.umrechnungskurs
     ELSE NULL
     END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_bnk_ret_zl,
  CASE
  WHEN CAST(V01.lager_bewart_id AS INTEGER) IN (161, 162) AND V01.nb_id = 0
  THEN CASE
    WHEN V02.soll_haben_kz = 'H'
    THEN 1
    ELSE - 1
    END * CAST(CASE
     WHEN V200.wrg_typ_id = 1
     THEN V02.betrag_kondition
     WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
     THEN V02.betrag_kondition * V300.umrechnungskurs
     WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
     THEN V02.betrag_kondition * V400.umrechnungskurs
     ELSE NULL
     END AS NUMERIC)
  ELSE NULL
  END AS wewa_betrag_bnk_ret_dz,
  CASE
  WHEN V02.soll_haben_kz = 'H'
  THEN 1
  ELSE - 1
  END AS vorz,
 SUBSTR(CASE
   WHEN V04.posten_id NOT IN ('1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_wewa_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_best_belegfluss_bnk_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wewa_beleg_id
      = V02.folge_beleg_id AND V01.wewa_beleg_pos_id = V02.folge_beleg_pos_id AND V01.wewa_jahr = V02.kj
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V300 ON V02.wrg_id = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V400 ON V01.dat_buch BETWEEN V400.dat_von AND V400.dat_bis AND V02.wrg_id
   = V400.von_wrg_id
 LEFT JOIN kfl_production_dbp_view.v_art_per_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND
   V01.dat_buch BETWEEN DATE_SUB(V04.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V04.dat_bis, INTERVAL 1 DAY))
WHERE V400.kurstyp_id = 3
 AND V400.nach_wrg_id = 'EUR'
 AND V300.dat_bis = DATE '9999-12-31'
 AND V300.kurstyp_id = 3
 AND V300.nach_wrg_id = 'EUR'
 AND V02.best_entw_typ_id = 'C'
 AND V01.menge_basis <> 0
 AND V01.mandant_id <> 1;