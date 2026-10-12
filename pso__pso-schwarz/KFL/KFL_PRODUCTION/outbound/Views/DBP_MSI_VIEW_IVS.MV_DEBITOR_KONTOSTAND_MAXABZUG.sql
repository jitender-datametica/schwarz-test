CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_debitor_kontostand_maxabzug AS SELECT DK.mandant_id,
 DK.debitor_id,
 DK.kjmo,
 sub01.last_abzug_id AS abzug_id,
  DK.saldo_vortrag * KURS.kurs AS saldo_vortrag,
  DK.summe_soll * KURS.kurs AS summe_soll,
  DK.summe_haben * KURS.kurs AS summe_haben,
  sub01.summe_haben_10 * KURS.kurs AS summe_haben_abzug_10,
  sub01.summe_haben_20 * KURS.kurs AS summe_haben_abzug_20,
  sub01.summe_haben_30 * KURS.kurs AS summe_haben_abzug_30,
  sub01.summe_haben_0 * KURS.kurs AS summe_haben_abzug_0,
  DK.saldo_soll * KURS.kurs AS saldo_soll,
  DK.saldo_haben * KURS.kurs AS saldo_haben,
  DK.saldo_konto * KURS.kurs AS saldo_konto,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM kfl_production_dbp_view.v_ivs_debitor_kontostand AS DK
 INNER JOIN (SELECT mandant_id,
   debitor_id,
   kjmo,
    CASE
    WHEN MIN(abzug_id) = 0
    THEN 0
    ELSE MAX(abzug_id)
    END AS last_abzug_id,
   SUM(CASE
     WHEN abzug_id = 10
     THEN summe_haben
     ELSE 0
     END) AS summe_haben_10,
   SUM(CASE
     WHEN abzug_id = 20
     THEN summe_haben
     ELSE 0
     END) AS summe_haben_20,
   SUM(CASE
     WHEN abzug_id = 30
     THEN summe_haben
     ELSE 0
     END) AS summe_haben_30,
   SUM(CASE
     WHEN abzug_id = 0
     THEN summe_haben
     ELSE 0
     END) AS summe_haben_0
  FROM kfl_production_dbp_view.v_ivs_debitor_kontostand
  GROUP BY mandant_id,
   debitor_id,
   kjmo) AS sub01 ON DK.mandant_id = sub01.mandant_id AND DK.debitor_id = sub01.debitor_id AND DK.kjmo = sub01.kjmo AND
   DK.abzug_id = sub01.last_abzug_id
 INNER JOIN kfl_production_dbp_view.v_monat AS ZEIT ON DK.kjmo = ZEIT.kjmo
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per AS KURS ON DK.mandant_id = KURS.mandant_id;