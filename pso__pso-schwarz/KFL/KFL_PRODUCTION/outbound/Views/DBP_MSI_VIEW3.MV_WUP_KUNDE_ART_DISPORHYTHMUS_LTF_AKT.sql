CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wup_kunde_art_disporhythmus_ltf_akt (mandant_id, wup_id, nb_id,
mandant_id_kunde, kunde_id, art_id, wg_id, arthiertyp_id, disposition_rhythmus_ltf_id, terminierungsgruppe_1_id,
terminierungsgruppe_2_id, terminierungsgruppe_3_id, auslieferungsgruppe_id, disponent_id, wg_verkett_id,
ausg_menge_einh_id) AS SELECT V02.mandant_id,
 V02.wup_id,
 - 111 AS nb_id,
 V01.mandant_id AS mandant_id_kunde,
  CASE
  WHEN SAFE_CAST(V01.wup_id AS BIGNUMERIC) = 0
  THEN NULL
  ELSE V02.aktuell_wup_id
  END AS kunde_id,
 V01.art_id,
 V03.wg_id,
 V03.arthiertyp_id,
 SUBSTR(CAST(COALESCE(V04.disposition_rhythmus_ltf_id, '-1') AS STRING), 1, 3) AS disposition_rhythmus_ltf_id,
 V01.terminierungsgruppe_1_id,
 V01.terminierungsgruppe_2_id,
 V01.terminierungsgruppe_3_id,
 SUBSTR(CAST(COALESCE(V04.auslieferungsgruppe_id, '-1') AS STRING), 1, 4) AS auslieferungsgruppe_id,
 V01.disponent_id,
 V01.wg_verkett_id,
 V05.ausg_menge_einh_id
FROM kfl_production_dbp_view.v_art_wup_status_per AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V02.wup_id = CASE
     WHEN SAFE_CAST(V01.wup_id AS BIGNUMERIC) = 0
     THEN NULL
     ELSE SAFE_CAST(V01.wup_id AS BIGNUMERIC)
     END AND (V02.nb_id IN (2, 0, - 111) AND V02.wup_id > 0 OR V02.nb_id = - 1 AND V02.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
      AND V03.arthiertyp_id = 2 AND V03.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_wup_kunde_art_disporhythmus_ltf_akt AS V04 ON V02.mandant_id = V04.mandant_id AND
     V01.art_id = V04.art_id AND V01.wup_id = V04.kunde_id AND V02.wup_id = V04.wup_id
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per AS V05 ON V01.mandant_id = V05.mandant_id AND V01.art_id =
    V05.art_id AND V05.dat_bis = DATE '9999-12-31'
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V02.dat_bis = DATE '9999-12-31'
 AND V02.nb_id = - 111
 AND LEFT(V02.wup_standort, 4) = 'VZ, ';