CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_as_food_gesamt_1 (art_id, mandant_id, nb_id, wup_id,
dat_auslistung, phase_id, kjwo, phase_wo, phase_vk_brutto, phase_vk_netto, gp_id, phase_status, erl_fg, dat_final,
erl_kz, dat_aend, menge_abschrift_22, abschriftbetrag_netto_22, menge_abschrift_122, abschriftbetrag_netto_122,
menge_endbestand_phase, vk_menge, umsatz_netto, betrag_ek_nettonetto, betrag_ek_mep, betrag_einstandspreis,
betrag_logkostenzuschlag, betrag_ek_mep_vor_fwu, menge_startbestand, vk_netto, vk_netto_start_bestand, menge_endbestand
, phase_id_max_vk_brutto) AS SELECT V01.art_id,
 V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.dat_auslistung,
 V01.phase_id,
 V01.kjwo,
 V01.phase_wo,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.phase_vk_brutto * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.phase_vk_brutto
  END AS phase_vk_brutto,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.phase_vk_netto * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.phase_vk_netto
  END AS phase_vk_netto,
 V02.gp_id,
 V02.phase_status,
 V02.erl_fg,
 V02.dat_final,
 V02.erl_kz,
 V02.dat_aend,
 V01.menge_preisabschrift AS menge_abschrift_22,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.betrag_preisabschrift_netto * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.betrag_preisabschrift_netto
  END AS abschriftbetrag_netto_22,
 V01.menge_totalabschrift AS menge_abschrift_122,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.betrag_totalabschrift_netto * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.betrag_totalabschrift_netto
  END AS abschriftbetrag_netto_122,
 V01.menge_endbestand_phase,
 V01.menge_absatz AS vk_menge,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.umsatz_netto * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.umsatz_netto
  END AS umsatz_netto,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.betrag_ek_nettonetto * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.betrag_ek_nettonetto
  END AS betrag_ek_nettonetto,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.betrag_ek_mep * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.betrag_ek_mep
  END AS betrag_ek_mep,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.betrag_einstandspreis * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.betrag_einstandspreis
  END AS betrag_einstandspreis,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.betrag_logkostenzuschlag * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.betrag_logkostenzuschlag
  END AS betrag_logkostenzuschlag,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(V01.betrag_ek_mep_vor_fwu * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE V01.betrag_ek_mep_vor_fwu
  END AS betrag_ek_mep_vor_fwu,
 IFNULL(v04.menge_startbestand, 0) AS menge_startbestand,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST(v04.vk_netto * V03.umrechnungskurs AS BIGNUMERIC), 4)
  ELSE v04.vk_netto
  END AS vk_netto_converted,
  v04.menge_startbestand * CASE
   WHEN V2.wrg_typ_id = 0
   THEN ROUND(CAST(v04.vk_netto * V03.umrechnungskurs AS BIGNUMERIC), 4)
   ELSE v04.vk_netto
   END AS vk_netto_start_bestand,
 IFNULL(v05.menge_endbestand, 0) AS menge_endbestand,
  CASE
  WHEN V2.wrg_typ_id = 0
  THEN ROUND(CAST((FIRST_VALUE(V01.phase_vk_brutto) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING)
         , CAST(V01.wup_id AS STRING), CAST(V01.nb_id AS STRING), V01.dat_auslistung ORDER BY V01.phase_id IS NULL DESC
         , V01.phase_id DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * V03.umrechnungskurs AS
    BIGNUMERIC), 4)
  ELSE FIRST_VALUE(V01.phase_vk_brutto) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.art_id AS STRING), CAST(V01.wup_id AS STRING)
     , CAST(V01.nb_id AS STRING), V01.dat_auslistung ORDER BY V01.phase_id IS NULL DESC, V01.phase_id DESC RANGE BETWEEN
   UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  END AS phase_id_max_vk_brutto
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
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V1 ON V01.mandant_id = V1.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V2 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V03 ON CURRENT_DATE BETWEEN V03.dat_von AND V03.dat_bis AND V1.wrg_id =
   V03.von_wrg_id
WHERE V03.kurstyp_id = 3
 AND V03.nach_wrg_id = 'EUR'
 AND V1.wrg_typ_id = 1
 AND V01.phase_id <> 4
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.art_id AS STRING), CAST(V01.mandant_id AS STRING), CAST(V01.nb_id AS STRING)
      , CAST(V01.wup_id AS STRING), V01.dat_auslistung, CAST(V01.kjwo AS STRING) ORDER BY V01.phase_id IS NULL DESC, V01
      .phase_id DESC)) = 1;