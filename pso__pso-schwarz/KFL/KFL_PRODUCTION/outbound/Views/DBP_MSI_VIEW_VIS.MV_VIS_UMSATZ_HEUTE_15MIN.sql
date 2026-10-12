CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_umsatz_heute_15min AS WITH VIS01 AS (SELECT VIS0.mandant_id
   ,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   CURRENT_DATE AS dat,
   bn_kpf.bon_dat AS dat_wvj,
   bn_kpf.zeit_stunde,
   bn_kpf.zeit_15min,
   bn_kpf.bon_ende_min_wvj,
   bn_kpf.bon_ende_max_wvj,
   bn_kpf.bon_kunden_anz_wvj,
   bn_kpf.bon_kassen_anz_wvj,
   bn_kpf.bon_kpf_umsatz_brutto_wvj,
   bn_kpf.bon_vkf_umsatz_brutto_wvj,
   bn_kpf.bon_rtr_umsatz_brutto_wvj,
   bn_kpf.bon_kpf_umsatz_netto_wvj,
   bn_kpf.bon_vkf_umsatz_netto_wvj,
   bn_kpf.bon_rtr_umsatz_netto_wvj,
   bn_kpf.bon_vkf_menge_wvj,
   bn_kpf.bon_rtr_menge_wvj
  FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup AS VIS0
   INNER JOIN (SELECT BNK.mandant_id,
     BNK.wup_id,
     KRS.nach_wrg_id AS wrg_id,
     BNK.bon_dat,
     EXTRACT(HOUR FROM BNK.bon_ende) AS zeit_stunde,
      CAST(FLOOR(EXTRACT(MINUTE FROM BNK.bon_ende) / 15) AS INTEGER) * 15 AS zeit_15min,
     MIN(BNK.bon_ende) AS bon_ende_min_wvj,
     MAX(BNK.bon_ende) AS bon_ende_max_wvj,
     COUNT(DISTINCT BNK.bon_id) AS bon_kunden_anz_wvj,
     COUNT(DISTINCT BNK.kasse_nr) AS bon_kassen_anz_wvj,
     SUM(BNK.umsatz_brutto * KRS.umrechnungskurs) AS bon_kpf_umsatz_brutto_wvj,
     SUM(bnv.ums_brutto * KRS.umrechnungskurs) AS bon_vkf_umsatz_brutto_wvj,
     SUM(bnr.ums_brutto * KRS.umrechnungskurs) AS bon_rtr_umsatz_brutto_wvj,
     SUM((BNK.umsatz_brutto - BNK.umsatz_mwst) * KRS.umrechnungskurs) AS bon_kpf_umsatz_netto_wvj,
     SUM(bnv.ums_netto * KRS.umrechnungskurs) AS bon_vkf_umsatz_netto_wvj,
     SUM(bnr.ums_netto * KRS.umrechnungskurs) AS bon_rtr_umsatz_netto_wvj,
     SUM(bnv.menge) AS bon_vkf_menge_wvj,
     SUM(bnr.menge) AS bon_rtr_menge_wvj
    FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS BNK
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung AS KRS ON BNK.wrg_id = KRS.von_wrg_id
     LEFT JOIN (SELECT V.mandant_id,
       V.wup_id,
       V.bon_dat,
       V.bon_id,
       SUM(V.umsatz_brutto) AS ums_brutto,
       SUM(V.umsatz_brutto * 100 / (VM.mwst + 100)) AS ums_netto,
       SUM(V.menge) AS menge
      FROM kfl_production_dbp_v_ods.v_ods_bon_verkauf AS V
       INNER JOIN kfl_production_dbp_view.v_mwst_per AS VM ON V.mandant_id = VM.mandant_id AND V.mwst_id = VM.mwst_id
        AND V.bon_dat BETWEEN VM.dat_von AND VM.dat_bis
      WHERE (V.mandant_id, V.kl_art_id) NOT IN (SELECT (ART.mandant_id, ART.kl_art_id)
         FROM kfl_production_dbp_data.art AS ART
          INNER JOIN kfl_production_dbp_data.art_wg_zu_per AS WG ON ART.mandant_id = WG.mandant_id AND ART.art_id = WG.art_id
            
         WHERE ART.dat_bis = DATE '9999-12-31'
          AND WG.arthiertyp_id = 2
          AND WG.dat_bis = DATE '9999-12-31'
          AND (WG.mandant_id = 1 AND WG.wg_id IN (818, 969) AND ART.mwst_id IN (0, 9) OR WG.mandant_id = 1 AND WG.art_id
                      IN (590006700, 590006900) OR WG.mandant_id = 2 AND WG.art_id IN (818410, 202685400, 1485930,
                     207699370) OR WG.mandant_id = 2 AND WG.wg_id = 969 AND WG.wug_id BETWEEN 1 AND 4 OR WG.mandant_id =
                   5 AND WG.wg_id = 969 AND WG.wug_id BETWEEN 1 AND 4 OR WG.mandant_id = 6 AND WG.art_id IN (98001300,
                  98001310, 98001320) OR WG.mandant_id = 6 AND WG.wg_id = 969 AND WG.wug_id BETWEEN 1 AND 4 OR WG.mandant_id
                 = 7 AND WG.wg_id = 969 AND WG.wug_id = 6 OR WG.mandant_id = 7 AND WG.wg_id = 980))
       AND V.wg_id NOT IN (961, 962)
      GROUP BY V.bon_id,
       V.mandant_id,
       V.wup_id,
       V.bon_dat) AS bnv ON BNK.bon_id = bnv.bon_id AND BNK.wup_id = bnv.wup_id AND BNK.mandant_id = bnv.mandant_id AND
       BNK.bon_dat = bnv.bon_dat
     LEFT JOIN (SELECT R.mandant_id,
       R.wup_id,
       R.bon_id,
       R.bon_dat,
       SUM(R.umsatz_brutto) AS ums_brutto,
       SUM(R.umsatz_brutto * 100 / (RM.mwst + 100)) AS ums_netto,
       SUM(R.menge) AS menge
      FROM kfl_production_dbp_v_ods.v_ods_bon_retoure AS R
       INNER JOIN kfl_production_dbp_view.v_mwst_per AS RM ON R.mandant_id = RM.mandant_id AND R.mwst_id = RM.mwst_id
        AND R.bon_dat BETWEEN RM.dat_von AND RM.dat_bis
      WHERE (R.mandant_id, R.kl_art_id) NOT IN (SELECT (ART0.mandant_id, ART0.kl_art_id)
         FROM kfl_production_dbp_data.art AS ART0
          INNER JOIN kfl_production_dbp_data.art_wg_zu_per AS WG0 ON ART0.mandant_id = WG0.mandant_id AND ART0.art_id =
            WG0.art_id
         WHERE ART0.dat_bis = DATE '9999-12-31'
          AND WG0.arthiertyp_id = 2
          AND WG0.dat_bis = DATE '9999-12-31'
          AND (WG0.mandant_id = 1 AND WG0.wg_id IN (818, 969) AND ART0.mwst_id IN (0, 9) OR WG0.mandant_id = 1 AND WG0.art_id
                      IN (590006700, 590006900) OR WG0.mandant_id = 2 AND WG0.art_id IN (818410, 202685400, 1485930,
                     207699370) OR WG0.mandant_id = 2 AND WG0.wg_id = 969 AND WG0.wug_id BETWEEN 1 AND 4 OR WG0.mandant_id
                    = 5 AND WG0.wg_id = 969 AND WG0.wug_id BETWEEN 1 AND 4 OR WG0.mandant_id = 6 AND WG0.art_id IN (98001300
                  , 98001310, 98001320) OR WG0.mandant_id = 6 AND WG0.wg_id = 969 AND WG0.wug_id BETWEEN 1 AND 4 OR WG0
                .mandant_id = 7 AND WG0.wg_id = 969 AND WG0.wug_id = 6 OR WG0.mandant_id = 7 AND WG0.wg_id = 980))
       AND R.wg_id NOT IN (961, 962)
      GROUP BY R.bon_id,
       R.mandant_id,
       R.wup_id,
       R.bon_dat) AS bnr ON BNK.bon_id = bnr.bon_id AND BNK.wup_id = bnr.wup_id AND BNK.mandant_id = bnr.mandant_id AND
       BNK.bon_dat = bnr.bon_dat
    WHERE BNK.turnover_fg = 1
     AND (bnv.bon_id IS NOT NULL OR bnr.bon_id IS NOT NULL)
     AND BNK.bon_dat = DATE_SUB(CURRENT_DATE, INTERVAL 364 DAY)
     AND (BNK.bon_id, BNK.wup_id, BNK.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
       FROM kfl_production_dbp_v_ods.v_ods_bon_storno)
    GROUP BY BNK.mandant_id,
     BNK.wup_id,
     wrg_id,
     BNK.bon_dat,
     zeit_stunde,
     zeit_15min) AS bn_kpf ON VIS0.mandant_id = bn_kpf.mandant_id AND VIS0.wup_id = bn_kpf.wup_id AND VIS0.wrg_id =
      bn_kpf.wrg_id AND VIS0.dat = bn_kpf.bon_dat
  WHERE VIS0.nb_id = 0
   AND VIS0.dat = DATE_SUB(CURRENT_DATE, INTERVAL 364 DAY)), WUP_ID_CHANGE AS (SELECT mandant_id,
   wup_id,
   orig_wup_id,
   aktuell_wup_id,
   wup_name_e,
   wup_standort,
   dat_von,
   dat_bis,
   dat_eroeffnung,
   wup_aenderung_grund_id
  FROM kfl_production_dbp_view.v_wup
  QUALIFY (COUNT(*) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(orig_wup_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1), VIS02 AS (SELECT VIS00.mandant_id,
   VIS00.nb_id,
   VIS00.wup_id,
   VIS00.wrg_id,
   VIS00.dat,
   VIS00.ums_netto_plan,
   VIS00.ums_netto_wvj,
   bn_kpf.zeit_stunde,
   bn_kpf.zeit_15min,
   bn_kpf.bon_ende_min,
   bn_kpf.bon_ende_max,
   bn_kpf.bon_kunden_anz,
   bn_kpf.bon_kassen_anz,
   bn_kpf.bon_kpf_umsatz_brutto,
   bn_kpf.bon_vkf_umsatz_brutto,
   bn_kpf.bon_rtr_umsatz_brutto,
   bn_kpf.bon_kpf_umsatz_netto,
   bn_kpf.bon_vkf_umsatz_netto,
   bn_kpf.bon_rtr_umsatz_netto,
   bn_kpf.bon_vkf_menge,
   bn_kpf.bon_rtr_menge
  FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup AS VIS00
   INNER JOIN (SELECT BNK0.mandant_id,
     BNK0.wup_id,
     KRS0.nach_wrg_id AS wrg_id,
     BNK0.bon_dat,
     EXTRACT(HOUR FROM BNK0.bon_ende) AS zeit_stunde,
      CAST(FLOOR(EXTRACT(MINUTE FROM BNK0.bon_ende) / 15) AS INTEGER) * 15 AS zeit_15min,
     MIN(BNK0.bon_ende) AS bon_ende_min,
     MAX(BNK0.bon_ende) AS bon_ende_max,
     COUNT(DISTINCT BNK0.bon_id) AS bon_kunden_anz,
     COUNT(DISTINCT BNK0.kasse_nr) AS bon_kassen_anz,
     SUM(BNK0.umsatz_brutto * KRS0.umrechnungskurs) AS bon_kpf_umsatz_brutto,
     SUM(bnv.ums_brutto * KRS0.umrechnungskurs) AS bon_vkf_umsatz_brutto,
     SUM(bnr.ums_brutto * KRS0.umrechnungskurs) AS bon_rtr_umsatz_brutto,
     SUM((BNK0.umsatz_brutto - BNK0.umsatz_mwst) * KRS0.umrechnungskurs) AS bon_kpf_umsatz_netto,
     SUM(bnv.ums_netto * KRS0.umrechnungskurs) AS bon_vkf_umsatz_netto,
     SUM(bnr.ums_netto * KRS0.umrechnungskurs) AS bon_rtr_umsatz_netto,
     SUM(bnv.menge) AS bon_vkf_menge,
     SUM(bnr.menge) AS bon_rtr_menge
    FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS BNK0
     INNER JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung AS KRS0 ON BNK0.wrg_id = KRS0.von_wrg_id
     LEFT JOIN (SELECT V0.mandant_id,
       V0.wup_id,
       V0.bon_dat,
       V0.bon_id,
       SUM(V0.umsatz_brutto) AS ums_brutto,
       SUM(V0.umsatz_brutto * 100 / (VM0.mwst + 100)) AS ums_netto,
       SUM(V0.menge) AS menge
      FROM kfl_production_dbp_v_ods.v_ods_bon_verkauf AS V0
       INNER JOIN kfl_production_dbp_view.v_mwst_per AS VM0 ON V0.mandant_id = VM0.mandant_id AND V0.mwst_id = VM0.mwst_id
           AND V0.bon_dat BETWEEN VM0.dat_von AND VM0.dat_bis
      WHERE (V0.mandant_id, V0.kl_art_id) NOT IN (SELECT (ART1.mandant_id, ART1.kl_art_id)
         FROM kfl_production_dbp_data.art AS ART1
          INNER JOIN kfl_production_dbp_data.art_wg_zu_per AS WG1 ON ART1.mandant_id = WG1.mandant_id AND ART1.art_id =
            WG1.art_id
         WHERE ART1.dat_bis = DATE '9999-12-31'
          AND WG1.arthiertyp_id = 2
          AND WG1.dat_bis = DATE '9999-12-31'
          AND (WG1.mandant_id = 1 AND WG1.wg_id IN (818, 969) AND ART1.mwst_id IN (0, 9) OR WG1.mandant_id = 1 AND WG1.art_id
                      IN (590006700, 590006900) OR WG1.mandant_id = 2 AND WG1.art_id IN (818410, 202685400, 1485930,
                     207699370) OR WG1.mandant_id = 2 AND WG1.wg_id = 969 AND WG1.wug_id BETWEEN 1 AND 4 OR WG1.mandant_id
                    = 5 AND WG1.wg_id = 969 AND WG1.wug_id BETWEEN 1 AND 4 OR WG1.mandant_id = 6 AND WG1.art_id IN (98001300
                  , 98001310, 98001320) OR WG1.mandant_id = 6 AND WG1.wg_id = 969 AND WG1.wug_id BETWEEN 1 AND 4 OR WG1
                .mandant_id = 7 AND WG1.wg_id = 969 AND WG1.wug_id = 6 OR WG1.mandant_id = 7 AND WG1.wg_id = 980))
       AND V0.wg_id NOT IN (961, 962)
      GROUP BY V0.bon_id,
       V0.mandant_id,
       V0.wup_id,
       V0.bon_dat) AS bnv ON BNK0.bon_id = bnv.bon_id AND BNK0.wup_id = bnv.wup_id AND BNK0.mandant_id = bnv.mandant_id
      AND BNK0.bon_dat = bnv.bon_dat
     LEFT JOIN (SELECT R0.mandant_id,
       R0.wup_id,
       R0.bon_id,
       R0.bon_dat,
       SUM(R0.umsatz_brutto) AS ums_brutto,
       SUM(R0.umsatz_brutto * 100 / (RM0.mwst + 100)) AS ums_netto,
       SUM(R0.menge) AS menge
      FROM kfl_production_dbp_v_ods.v_ods_bon_retoure AS R0
       INNER JOIN kfl_production_dbp_view.v_mwst_per AS RM0 ON R0.mandant_id = RM0.mandant_id AND R0.mwst_id = RM0.mwst_id
           AND R0.bon_dat BETWEEN RM0.dat_von AND RM0.dat_bis
      WHERE (R0.mandant_id, R0.kl_art_id) NOT IN (SELECT (ART2.mandant_id, ART2.kl_art_id)
         FROM kfl_production_dbp_data.art AS ART2
          INNER JOIN kfl_production_dbp_data.art_wg_zu_per AS WG2 ON ART2.mandant_id = WG2.mandant_id AND ART2.art_id =
            WG2.art_id
         WHERE ART2.dat_bis = DATE '9999-12-31'
          AND WG2.arthiertyp_id = 2
          AND WG2.dat_bis = DATE '9999-12-31'
          AND (WG2.mandant_id = 1 AND WG2.wg_id IN (818, 969) AND ART2.mwst_id IN (0, 9) OR WG2.mandant_id = 1 AND WG2.art_id
                      IN (590006700, 590006900) OR WG2.mandant_id = 2 AND WG2.art_id IN (818410, 202685400, 1485930,
                     207699370) OR WG2.mandant_id = 2 AND WG2.wg_id = 969 AND WG2.wug_id BETWEEN 1 AND 4 OR WG2.mandant_id
                    = 5 AND WG2.wg_id = 969 AND WG2.wug_id BETWEEN 1 AND 4 OR WG2.mandant_id = 6 AND WG2.art_id IN (98001300
                  , 98001310, 98001320) OR WG2.mandant_id = 6 AND WG2.wg_id = 969 AND WG2.wug_id BETWEEN 1 AND 4 OR WG2
                .mandant_id = 7 AND WG2.wg_id = 969 AND WG2.wug_id = 6 OR WG2.mandant_id = 7 AND WG2.wg_id = 980))
       AND R0.wg_id NOT IN (961, 962)
      GROUP BY R0.bon_id,
       R0.mandant_id,
       R0.wup_id,
       R0.bon_dat) AS bnr ON BNK0.bon_id = bnr.bon_id AND BNK0.wup_id = bnr.wup_id AND BNK0.mandant_id = bnr.mandant_id
      AND BNK0.bon_dat = bnr.bon_dat
    WHERE BNK0.turnover_fg = 1
     AND (bnv.bon_id IS NOT NULL OR bnr.bon_id IS NOT NULL)
     AND BNK0.bon_dat = CURRENT_DATE
     AND (BNK0.bon_id, BNK0.wup_id, BNK0.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
       FROM kfl_production_dbp_v_ods.v_ods_bon_storno)
    GROUP BY BNK0.mandant_id,
     BNK0.wup_id,
     wrg_id,
     BNK0.bon_dat,
     zeit_stunde,
     zeit_15min) AS bn_kpf ON VIS00.mandant_id = bn_kpf.mandant_id AND VIS00.wup_id = bn_kpf.wup_id AND VIS00.wrg_id =
      bn_kpf.wrg_id AND VIS00.dat = bn_kpf.bon_dat
  WHERE VIS00.nb_id = 0
   AND VIS00.dat = CURRENT_DATE) (SELECT DISTINCT COALESCE(t17.mandant_id, t39.mandant_id) AS mandant_id,
   COALESCE(t17.nb_id, t39.nb_id) AS nb_id,
   COALESCE(t20.aktuell_wup_id, t17.wup_id, t39.wup_id) AS wup_id,
   COALESCE(t17.wrg_id, t39.wrg_id) AS wrg_id,
   COALESCE(t17.dat, t39.dat) AS dat,
   COALESCE(t17.zeit_stunde, t39.zeit_stunde) AS zeit_stunde,
   COALESCE(t17.zeit_15min, t39.zeit_15min) AS zeit_15min,
   t17.zeit_stunde AS z1,
   t39.zeit_stunde AS z2,
   t39.bon_ende_min,
   t39.bon_ende_max,
   t17.bon_ende_min_wvj,
   t17.bon_ende_max_wvj,
   t39.bon_kunden_anz,
   t17.bon_kunden_anz_wvj,
   t39.bon_kassen_anz,
   t17.bon_kassen_anz_wvj,
   NULLIF(COALESCE(t39.bon_vkf_umsatz_netto, 0) + COALESCE(t39.bon_rtr_umsatz_netto, 0), 0) AS bon_umsatz_netto,
   NULLIF(COALESCE(t17.bon_vkf_umsatz_netto_wvj, 0) + COALESCE(t17.bon_rtr_umsatz_netto_wvj, 0), 0) AS
   bon_umsatz_netto_wvj,
   t39.ums_netto_plan,
   t39.ums_netto_wvj,
   t39.bon_vkf_umsatz_netto,
   t39.bon_rtr_umsatz_netto,
   t39.bon_kpf_umsatz_netto,
   t17.bon_vkf_umsatz_netto_wvj,
   t17.bon_rtr_umsatz_netto_wvj,
   t17.bon_kpf_umsatz_netto_wvj,
   NULLIF(COALESCE(t39.bon_vkf_umsatz_brutto, 0) + COALESCE(t39.bon_rtr_umsatz_brutto, 0), 0) AS bon_umsatz_brutto,
   NULLIF(COALESCE(t17.bon_vkf_umsatz_brutto_wvj, 0) + COALESCE(t17.bon_rtr_umsatz_brutto_wvj, 0), 0) AS
   bon_umsatz_brutto_wvj,
   t39.bon_vkf_umsatz_brutto,
   t39.bon_rtr_umsatz_brutto,
   t39.bon_kpf_umsatz_brutto,
   t17.bon_vkf_umsatz_brutto_wvj,
   t17.bon_rtr_umsatz_brutto_wvj,
   t17.bon_kpf_umsatz_brutto_wvj
  FROM VIS01 AS t17
   LEFT JOIN WUP_ID_CHANGE AS t20 ON t17.mandant_id = t20.mandant_id AND t17.wup_id = t20.wup_id AND t17.dat_wvj BETWEEN
     t20.dat_von AND t20.dat_bis
   FULL JOIN VIS02 AS t39 ON t17.mandant_id = t39.mandant_id AND COALESCE(t20.aktuell_wup_id, t17.wup_id) = t39.wup_id
       AND t17.wrg_id = t39.wrg_id AND t17.dat = t39.dat AND t17.zeit_stunde = t39.zeit_stunde AND t17.zeit_15min = t39
     .zeit_15min);