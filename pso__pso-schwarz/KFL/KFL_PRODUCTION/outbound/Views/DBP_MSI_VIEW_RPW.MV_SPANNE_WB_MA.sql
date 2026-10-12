CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_spanne_wb_ma (rcv_id, nb_id, dat, mandant_id, system_id,
art_id, belastungsart_id, belastungsart_vd_id, wrg_id, bezugsweg_id, owg_id, absch_menge, aufsch_menge, ek_netto,
vk_netto, vk_brutto) AS SELECT MA.wup_id AS rcv_id,
 MA.nb_id,
 MA.dat,
 MA.mandant_id,
 7 AS system_id,
 MA.art_id,
 SUBSTR(CAST(MA.abschriftart_id AS STRING), 1, 4) AS belastungsart_id,
  CASE
  WHEN MA.abschriftart_id IN (8, 99, 190)
  THEN 3
  ELSE 2
  END AS belastungsart_vd_id,
 MA.wrg_id,
 EK_MAPPING.bezugsweg_id,
 OWG.owg_id,
 SUM(CASE
    WHEN MA.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto
        > 0 OR MA.abschrift_menge_einh_id = 'G' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto > 0
    THEN CAST(MA.menge_abschrift AS NUMERIC) / 1000
    WHEN MA.abschriftbetrag_netto > 0 AND MA.abschriftart_id >= 100
    THEN CAST(MA.menge_abschrift AS NUMERIC)
    ELSE 0
    END * - 1) AS absch_menge,
 SUM(CASE
    WHEN MA.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto
        < 0 OR MA.abschrift_menge_einh_id = 'G' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto < 0
    THEN CAST(MA.menge_abschrift AS NUMERIC) / 1000
    WHEN MA.abschriftbetrag_netto < 0 AND MA.abschriftart_id >= 100
    THEN CAST(MA.menge_abschrift AS NUMERIC)
    ELSE 0
    END * - 1) AS aufsch_menge,
  CASE
  WHEN OWG.owg_id <> 1092 AND EK_MAPPING.bezugsweg_id = 1
  THEN (SUM(CASE
        WHEN MA.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto
            > 0 OR MA.abschrift_menge_einh_id = 'G' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto > 0
        THEN CAST(MA.menge_abschrift AS NUMERIC) / 1000
        WHEN MA.abschriftbetrag_netto > 0 AND MA.abschriftart_id >= 100
        THEN CAST(MA.menge_abschrift AS NUMERIC)
        ELSE 0
        END * - 1) + SUM(CASE
        WHEN MA.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto
            < 0 OR MA.abschrift_menge_einh_id = 'G' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto < 0
        THEN CAST(MA.menge_abschrift AS NUMERIC) / 1000
        WHEN MA.abschriftbetrag_netto < 0 AND MA.abschriftart_id >= 100
        THEN CAST(MA.menge_abschrift AS NUMERIC)
        ELSE 0
        END * - 1)) * AVG(CASE
     WHEN MA.abschriftart_id >= 100
     THEN EK_GP.ek_netto_bnk * EK_GP.komponentenmenge
     ELSE 0
     END)
  WHEN OWG.owg_id <> 1092 AND EK_MAPPING.bezugsweg_id <> 1
  THEN (SUM(CASE
        WHEN MA.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto
            > 0 OR MA.abschrift_menge_einh_id = 'G' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto > 0
        THEN CAST(MA.menge_abschrift AS NUMERIC) / 1000
        WHEN MA.abschriftbetrag_netto > 0 AND MA.abschriftart_id >= 100
        THEN CAST(MA.menge_abschrift AS NUMERIC)
        ELSE 0
        END * - 1) + SUM(CASE
        WHEN MA.abschrift_menge_einh_id IS NULL AND art.gewart_id = 'KG' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto
            < 0 OR MA.abschrift_menge_einh_id = 'G' AND MA.abschriftart_id >= 100 AND MA.abschriftbetrag_netto < 0
        THEN CAST(MA.menge_abschrift AS NUMERIC) / 1000
        WHEN MA.abschriftbetrag_netto < 0 AND MA.abschriftart_id >= 100
        THEN CAST(MA.menge_abschrift AS NUMERIC)
        ELSE 0
        END * - 1)) * AVG(CASE
     WHEN MA.abschriftart_id >= 100
     THEN COALESCE(EK_VZ.ek_netto_bnk, EK_GP.ek_netto_bnk) * COALESCE(EK_VZ.komponentenmenge, EK_GP.komponentenmenge)
     ELSE 0
     END)
  ELSE CAST(SUM(CASE
      WHEN MA.abschriftart_id >= 100
      THEN MA.abschriftbetrag_brutto
      ELSE 0
      END) * - 1 AS FLOAT64)
  END AS ek_netto,
 SUM(MA.abschriftbetrag_netto * - 1) AS vk_netto,
 SUM(MA.abschriftbetrag_brutto * - 1) AS vk_brutto
FROM kfl_production_dbp_view.v_marktabschriften AS MA
 LEFT JOIN kfl_production_dbp_data.art_wg_zu_per AS WG ON MA.mandant_id = WG.mandant_id AND MA.art_id = WG.art_id AND MA
    .dat BETWEEN WG.dat_von AND WG.dat_bis AND WG.arthiertyp_id = 2
 INNER JOIN kfl_production_dbp_data.wg_per AS OWG ON MA.mandant_id = OWG.mandant_id AND WG.wg_id = OWG.wg_id AND MA.dat
   BETWEEN OWG.dat_von AND OWG.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS EK_MAPPING ON MA.mandant_id = EK_MAPPING.mandant_id AND MA.art_id
      = EK_MAPPING.art_id AND MA.wup_id = EK_MAPPING.wup_id AND MA.dat BETWEEN EK_MAPPING.dat_von AND EK_MAPPING.dat_bis
   
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS EK_VZ ON EK_MAPPING.mandant_id = EK_VZ.mandant_id AND
       EK_MAPPING.art_id = EK_VZ.art_id AND EK_MAPPING.gp_id = EK_VZ.gp_id AND MA.dat BETWEEN EK_VZ.dat_von AND EK_VZ.dat_bis
      AND EK_MAPPING.vz_wup_id = EK_VZ.wup_id AND EK_VZ.wup_id > - 1
 LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS EK_GP ON EK_MAPPING.mandant_id = EK_GP.mandant_id AND
      EK_MAPPING.art_id = EK_GP.art_id AND EK_MAPPING.gp_id = EK_GP.gp_id AND MA.dat BETWEEN EK_GP.dat_von AND EK_GP.dat_bis
     AND EK_GP.wup_id = - 1
 INNER JOIN (SELECT art_id,
   gewart_id
  FROM kfl_production_dbp_view.v_art
  WHERE mandant_id = 1) AS art ON MA.art_id = art.art_id
WHERE MA.mandant_id = 1
GROUP BY rcv_id,
 MA.nb_id,
 MA.dat,
 MA.mandant_id,
 system_id,
 MA.art_id,
 belastungsart_id,
 belastungsart_vd_id,
 MA.wrg_id,
 EK_MAPPING.bezugsweg_id,
 OWG.owg_id;