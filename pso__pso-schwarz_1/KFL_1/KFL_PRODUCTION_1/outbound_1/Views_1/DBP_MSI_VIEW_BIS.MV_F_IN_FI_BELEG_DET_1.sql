CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_in_fi_beleg_det_1 AS SELECT V01.mandant_id,
 V01.buchungskreis_id,
 V01.in_fi_beleg_id,
 V01.in_fi_beleg_pos_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.bsak_bschl_id,
 V01.bseg_bschl_id,
 V01.werk_id,
  CASE
  WHEN V01.soll_haben_kz = 'S'
  THEN 1
  ELSE - 1
  END AS ind_vz,
  CASE
  WHEN V04.wrg_typ_id = 1
  THEN V01.betrag_fi_beleg * CASE
    WHEN V01.soll_haben_kz = 'S'
    THEN 1
    ELSE - 1
    END
  ELSE V01.betrag_fi_beleg * CASE
     WHEN V01.soll_haben_kz = 'S'
     THEN 1
     ELSE - 1
     END * V01.umrechnungskurs
  END AS betrag_fi_beleg,
  CASE
  WHEN V01.bsak_bschl_id IN ('21', '32') AND V04.wrg_typ_id = 1
  THEN V01.betrag_fi_beleg * CASE
    WHEN V01.soll_haben_kz = 'S'
    THEN 1
    ELSE - 1
    END
  WHEN V01.bsak_bschl_id IN ('21', '32') AND V04.wrg_typ_id = 0
  THEN V01.betrag_fi_beleg * CASE
     WHEN V01.soll_haben_kz = 'S'
     THEN 1
     ELSE - 1
     END * V01.umrechnungskurs
  ELSE NULL
  END AS gutschrift_betrag,
  CASE
  WHEN V01.bsak_bschl_id IN ('22', '31') AND V04.wrg_typ_id = 1
  THEN V01.betrag_fi_beleg * CASE
    WHEN V01.soll_haben_kz = 'S'
    THEN 1
    ELSE - 1
    END
  WHEN V01.bsak_bschl_id IN ('22', '31') AND V04.wrg_typ_id = 0
  THEN V01.betrag_fi_beleg * CASE
     WHEN V01.soll_haben_kz = 'S'
     THEN 1
     ELSE - 1
     END * V01.umrechnungskurs
  ELSE NULL
  END AS rechnung_betrag,
  V01.menge_fi_beleg * CASE
   WHEN V01.soll_haben_kz = 'S'
   THEN 1
   ELSE - 1
   END AS menge_fi_beleg,
 V01.in_art_id,
 V01.in_lief_id,
 V01.menge_einh_id,
 V01.dat_buch
FROM kfl_production_dbp_msi_view_bis.tbl_mv_f_in_fi_beleg_det_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V04 ON TRUE;