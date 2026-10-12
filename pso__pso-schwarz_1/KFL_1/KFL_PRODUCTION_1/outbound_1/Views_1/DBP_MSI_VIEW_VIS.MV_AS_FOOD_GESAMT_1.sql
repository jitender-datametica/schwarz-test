CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_as_food_gesamt_1 (art_id, mandant_id, nb_id, wup_id, wrg_id,
dat_auslistung, phase_id, kjwo, phase_wo, phase_vk_brutto, phase_vk_netto, gp_id, phase_status, erl_fg, dat_final,
erl_kz, dat_aend, menge_preisabschrift, betrag_preisabschrift_netto, menge_totalabschrift, betrag_totalabschrift_netto,
menge_endbestand_phase, menge_absatz, umsatz_netto, menge_startbestand, vk_netto, vk_netto_start_bestand,
menge_endbestand, rank_phase_wo) AS SELECT V01.art_id,
 V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 krs.nach_wrg_id AS wrg_id,
 V01.dat_auslistung,
 V01.phase_id,
 V01.kjwo,
 V01.phase_wo,
  V01.phase_vk_brutto * krs.umrechnungskurs AS phase_vk_brutto,
  V01.phase_vk_netto * krs.umrechnungskurs AS phase_vk_netto,
 V02.gp_id,
 V02.phase_status,
 V02.erl_fg,
 V02.dat_final,
 V02.erl_kz,
 V02.dat_aend,
 V01.menge_preisabschrift,
  V01.betrag_preisabschrift_netto * krs.umrechnungskurs AS betrag_preisabschrift_netto,
 V01.menge_totalabschrift,
  V01.betrag_totalabschrift_netto * krs.umrechnungskurs AS betrag_totalabschrift_netto,
 V01.menge_endbestand_phase,
 V01.menge_absatz,
  V01.umsatz_netto * krs.umrechnungskurs AS umsatz_netto,
 IFNULL(v04.menge_startbestand, 0) AS menge_startbestand,
  v04.vk_netto * krs.umrechnungskurs AS vk_netto,
   v04.menge_startbestand * v04.vk_netto * krs.umrechnungskurs AS vk_netto_start_bestand,
 IFNULL(v05.menge_endbestand, 0) AS menge_endbestand,
 RANK() OVER (PARTITION BY CAST(V01.art_id AS STRING), CAST(V01.mandant_id AS STRING), WUP.aktuell_wup_id, CAST(V01.kjwo AS STRING)
    ORDER BY V01.phase_wo IS NULL DESC, V01.phase_wo DESC) AS rank_phase_wo
FROM kfl_production_dbp_view.v_as_food_det_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_as_food_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id AND
     V01.wup_id = V02.wup_id AND V01.nb_id = V02.nb_id AND V01.dat_auslistung = V02.dat_auslistung
 LEFT JOIN (SELECT V020.mandant_id,
   V020.art_id,
   V020.wup_id,
   V020.nb_id,
   V020.dat_auslistung,
   V010.phase_id,
   V020.menge_startbestand,
   V020.vk_netto,
   MIN(V010.kjwo) AS kjwo
  FROM kfl_production_dbp_view.v_as_food_det_1 AS V010
   INNER JOIN kfl_production_dbp_view.v_as_food_1 AS V020 ON V010.mandant_id = V020.mandant_id AND V010.art_id = V020.art_id
         AND V010.wup_id = V020.wup_id AND V010.nb_id = V020.nb_id AND V010.dat_auslistung = V020.dat_auslistung
  WHERE V010.phase_id = 0
  GROUP BY V010.phase_id,
   V020.art_id,
   V020.mandant_id,
   V020.nb_id,
   V020.wup_id,
   V020.dat_auslistung,
   V020.menge_startbestand,
   V020.vk_netto) AS v04 ON V01.mandant_id = v04.mandant_id AND V01.art_id = v04.art_id AND V01.wup_id = v04.wup_id AND
      V01.nb_id = v04.nb_id AND V01.dat_auslistung = v04.dat_auslistung AND V01.phase_id = v04.phase_id AND V01.kjwo =
   v04.kjwo
 LEFT JOIN (SELECT V021.mandant_id,
   V021.art_id,
   V021.wup_id,
   V021.nb_id,
   V021.dat_auslistung,
   V021.menge_endbestand,
   V021.vk_netto,
   MAX(V011.phase_id) AS phase_id,
   MAX(V011.kjwo) AS kjwo
  FROM kfl_production_dbp_view.v_as_food_det_1 AS V011
   INNER JOIN kfl_production_dbp_view.v_as_food_1 AS V021 ON V011.mandant_id = V021.mandant_id AND V011.art_id = V021.art_id
         AND V011.wup_id = V021.wup_id AND V011.nb_id = V021.nb_id AND V011.dat_auslistung = V021.dat_auslistung
  WHERE V011.phase_id IS NOT NULL
  GROUP BY V021.art_id,
   V021.mandant_id,
   V021.nb_id,
   V021.wup_id,
   V021.dat_auslistung,
   V021.vk_netto,
   V021.menge_endbestand) AS v05 ON V01.mandant_id = v05.mandant_id AND V01.art_id = v05.art_id AND V01.wup_id = v05.wup_id
        AND V01.nb_id = v05.nb_id AND V01.dat_auslistung = v05.dat_auslistung AND V01.phase_id = v05.phase_id AND V01.kjwo
    = v05.kjwo
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V03 ON V01.mandant_id = V03.mandant_id
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_1 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON V03.default_wrg = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;