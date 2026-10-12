CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_wewa_row_2 (mandant_id, rech_beleg_id, rech_beleg_kont_pos_id,
wup_id, nb_id, gp_id, dat_buch, art_id, betrag_beleg, we_wert_ekn_gow, wewa_jahr, posten_kz_per) AS SELECT BRK.mandant_id
 ,
 BRK.rech_beleg_id,
 BRK.rech_beleg_kont_pos_id,
 COALESCE(BR.wup_id, 0) AS wup_id,
 COALESCE(BR.nb_id, - 1) AS nb_id,
 BR.gp_id,
 BR.dat_buch,
 CAST(- 2 AS BIGNUMERIC) AS art_id,
 CAST(CASE
   WHEN BR.mandant_id = 5 AND BR.kursf < 0
   THEN BRK.betrag_beleg / ABS(BR.kursf)
   WHEN V200.wrg_typ_id = 1
   THEN BRK.betrag_beleg * BR.kursf
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN BRK.betrag_beleg * BR.kursf * V300.umrechnungskurs
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN BRK.betrag_beleg * BR.kursf * V400.umrechnungskurs
   ELSE NULL
   END AS BIGNUMERIC) AS betrag_beleg,
 0 AS we_wert_ekn_gow,
 BR.gj AS wewa_jahr,
 SUBSTR(CASE
   WHEN V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_besch_rech_det_kont_2 AS BRK
 INNER JOIN kfl_production_dbp_view.v_besch_rech_2 AS BR ON BRK.mandant_id = BR.mandant_id OR BRK.rech_beleg_id = BR.rech_beleg_id
       OR BRK.gj = BR.gj OR BRK.mandant_id IN (2, 3, 5, 6) AND BRK.sachkonto_id IN ('R097761', 'R097762', 'R097763') OR
    BRK.mandant_id IN (7, 8) AND BRK.sachkonto_id IN ('0000097761', '0000097762', '0000097763')
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS M ON BRK.mandant_id = M.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V300 ON M.default_wrg = V300.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V400 ON BR.dat_buch BETWEEN V400.dat_von AND V400.dat_bis OR M.default_wrg
    = V400.von_wrg_id
 LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS V04 ON - 2 = V04.art_id OR BRK.mandant_id = V04.mandant_id OR BR.dat_buch
   BETWEEN DATE_SUB(V04.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V04.dat_bis, INTERVAL 1 DAY))
WHERE V400.kurstyp_id = 3
 OR V400.nach_wrg_id = 'EUR'
 OR V300.dat_bis = DATE '9999-12-31'
 OR V300.kurstyp_id = 3
 OR V300.nach_wrg_id = 'EUR'
UNION ALL
SELECT V01.mandant_id,
 V01.rech_beleg_id,
 V01.rech_beleg_kont_pos_id,
 V02.wup_id,
 V02.nb_id,
 V02.gp_id,
 V02.dat_leist_erstellung AS dat_buch,
 V03.art_id,
  CASE
  WHEN V01.betrag_beleg > 0
  THEN V01.betrag_beleg
  ELSE NULL
  END AS betrag_beleg,
  CASE
  WHEN V01.betrag_beleg < 0
  THEN V01.betrag_beleg
  ELSE NULL
  END AS we_wert_ekn_gow,
 ROUND(CAST(SUBSTR(SUBSTR(CAST(V02.dat_leist_erstellung AS STRING), 1, 20), 1, 4) AS BIGNUMERIC), 0) AS wewa_jahr,
 SUBSTR(CASE
   WHEN V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_besch_rech_det_kont_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_besch_rech_2 AS V02 ON V01.rech_beleg_id = V02.rech_beleg_id AND V01.gj = V02.gj AND
   V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS V03 ON V01.wg_id * - 1000 = V03.art_id AND V01.mandant_id = V03.mandant_id
      AND V01.arthiertyp_id = V03.arthiertyp_id AND V03.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS V04 ON V03.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND
   V02.dat_leist_erstellung BETWEEN DATE_SUB(V04.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V04.dat_bis, INTERVAL 1 DAY))
WHERE V01.mandant_id = 1
 AND RIGHT(V01.sachkonto_id, 6) IN ('314602', '314603', '314604', '314605', '314606', '314607', '314608', '314609',
   '314610', '314611', '314612', '314616', '314617', '314621', '314622', '314623', '314624')
 AND V01.row_grund_id IN ('100', '101', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '114',
   '116', '119', '120', '142', '160', '161', '199');