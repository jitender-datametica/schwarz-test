CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_f_kostenrechnung (kj_ker_mo_id, mandant_id,
betrag_gesamtkosten, betrag_verrechnung_int, kostenrechnung_betrag) AS SELECT V01.kj_ker_mo_id,
  CASE
  WHEN V01.pc_id IN ('DE9611-0', 'DE9611-0B', 'DE9611-0DL')
  THEN 99
  ELSE V01.mandant_id
  END AS mandant_id,
 SUM(CASE
   WHEN V02.ka_lv4 = 'UGK'
   THEN V01.kostenrechnung_betrag * V05.umrechnungskurs
   ELSE NULL
   END) AS betrag_gesamtkosten,
 SUM(CASE
   WHEN V02.ka_lv7 = 'U323-4'
   THEN V01.kostenrechnung_betrag * V05.umrechnungskurs
   ELSE NULL
   END) AS betrag_verrechnung_int,
   (COALESCE(SUM(CASE
       WHEN V02.ka_lv4 = 'UGK'
       THEN V01.kostenrechnung_betrag * V05.umrechnungskurs
       ELSE NULL
       END), 0) - COALESCE(SUM(CASE
       WHEN V02.ka_lv7 = 'U323-4'
       THEN V01.kostenrechnung_betrag * V05.umrechnungskurs
       ELSE NULL
       END), 0)) * - 1 AS kostenrechnung_betrag
FROM kfl_production_dbp_view.v_kostenrechnung AS V01
 INNER JOIN kfl_production_dbp_msi_v_view.v_ka_ka_grp_denorm AS V02 ON V01.kostenart_id = V02.ka_lv11
 INNER JOIN kfl_production_dbp_view.v_mandant AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN (SELECT MAX(dat) AS max_dat,
   kjmo
  FROM kfl_production_dbp_view.v_tag
  GROUP BY kjmo) AS v04 ON V01.kj_ker_mo_id = v04.kjmo
 INNER JOIN kfl_production_dbp_view.v_kurs AS V05 ON V03.default_wrg = V05.von_wrg_id AND v04.max_dat BETWEEN V05.dat_von
     AND V05.dat_bis AND V05.kurstyp_id = 9 AND V05.nach_wrg_id = 'EUR'
WHERE V01.pc_id IN ('DE9111-0', 'CZ9531-0', 'SK9531-0', 'HR9531-0', 'PL9531-0', 'RO9531-0', 'BG9531-0', 'DE9611-0',
   'DE9611-0B', 'DE9611-0DL')
 AND V01.plan_fg = 0
GROUP BY V01.kj_ker_mo_id,
 mandant_id;