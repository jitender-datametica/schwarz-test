CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_umsatz_heute_stunde AS WITH VIS01 AS (SELECT VIS0.mandant_id
   ,
   VIS0.nb_id,
   VIS0.wup_id,
   VIS0.wrg_id,
   VIS0.dat,
   bn_agg.dat AS dat_wvj,
   VIS0.ums_netto_plan,
   VIS0.ums_netto_wvj,
   bn_agg.zeit_stunde,
   bn_agg.bon_kunden_anz_wvj,
   bn_agg.bon_kassen_anz_wvj,
   bn_agg.bon_umsatz_brutto_wvj,
   bn_agg.bon_umsatz_netto_wvj,
   bn_agg.bon_anz_artikel_wvj
  FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup AS VIS0
   INNER JOIN (SELECT mandant_id,
     wup_id,
     wrg_id,
     dat,
     zeit_stunde,
     SUM(anz_kunden) AS bon_kunden_anz_wvj,
     COUNT(DISTINCT kasse_nr) AS bon_kassen_anz_wvj,
     SUM(umsatz_brutto) AS bon_umsatz_brutto_wvj,
     SUM(umsatz_netto) AS bon_umsatz_netto_wvj,
     SUM(anz_artikel) AS bon_anz_artikel_wvj
    FROM (SELECT AGG.mandant_id,
        AGG.wup_id,
        MDT.default_wrg AS wrg_id,
        AGG.dat,
        AGG.zeit_stunde,
        AGG.kasse_nr,
        AGG.anz_kunden,
        AGG.umsatz_brutto,
        AGG.umsatz_netto,
        AGG.anz_artikel
       FROM kfl_production_dbp_v_ods.v_ods_bon_agg_15min AS AGG
        INNER JOIN kfl_production_dbp_view.v_mandant AS MDT ON AGG.mandant_id = MDT.mandant_id
       WHERE AGG.dat = DATE_SUB(CURRENT_DATE, INTERVAL 364 DAY)
       UNION ALL
       SELECT AGG.mandant_id,
        AGG.wup_id,
        KRS.nach_wrg_id AS wrg_id,
        AGG.dat,
        AGG.zeit_stunde,
        AGG.kasse_nr,
        AGG.anz_kunden,
         AGG.umsatz_brutto * KRS.umrechnungskurs AS umsatz_brutto,
         AGG.umsatz_netto * KRS.umrechnungskurs AS umsatz_netto,
        AGG.anz_artikel
       FROM kfl_production_dbp_v_ods.v_ods_bon_agg_15min AS AGG
        INNER JOIN kfl_production_dbp_view.v_mandant AS MDT ON AGG.mandant_id = MDT.mandant_id AND MDT.default_wrg <>
          'EUR'
        INNER JOIN kfl_production_dbp_view.v_kurs AS KRS ON MDT.default_wrg = KRS.von_wrg_id AND KRS.kurstyp_id = 3 AND
          KRS.dat_bis = PARSE_DATE('%Y%m%d', '99991231')
       WHERE AGG.dat = DATE_SUB(CURRENT_DATE, INTERVAL 364 DAY)) AS agg
    GROUP BY mandant_id,
     wup_id,
     wrg_id,
     dat,
     zeit_stunde) AS bn_agg ON VIS0.mandant_id = bn_agg.mandant_id AND VIS0.wup_id = bn_agg.wup_id AND VIS0.wrg_id =
      bn_agg.wrg_id AND VIS0.dat = DATE_ADD(bn_agg.dat, INTERVAL 364 DAY)
  WHERE VIS0.nb_id = 0
   AND VIS0.dat = CURRENT_DATE), WUP_ID_CHANGE AS (SELECT mandant_id,
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
   INNER JOIN (SELECT mandant_id,
     wup_id,
     wrg_id,
     bon_dat,
     EXTRACT(HOUR FROM bon_ende) AS zeit_stunde,
     MIN(bon_ende) AS bon_ende_min,
     MAX(bon_ende) AS bon_ende_max,
     COUNT(DISTINCT bon_id) AS bon_kunden_anz,
     COUNT(DISTINCT kasse_nr) AS bon_kassen_anz,
     SUM(kpf_ums_brutto) AS bon_kpf_umsatz_brutto,
     SUM(vkf_ums_brutto) AS bon_vkf_umsatz_brutto,
     SUM(rtr_ums_brutto) AS bon_rtr_umsatz_brutto,
     SUM(kpf_ums_netto) AS bon_kpf_umsatz_netto,
     SUM(vkf_ums_netto) AS bon_vkf_umsatz_netto,
     SUM(rtr_ums_netto) AS bon_rtr_umsatz_netto,
     SUM(vkf_menge) AS bon_vkf_menge,
     SUM(rtr_menge) AS bon_rtr_menge
    FROM (SELECT BNK.mandant_id,
        BNK.wup_id,
        BNK.wrg_id,
        BNK.bon_dat,
        BNK.bon_beginn,
        BNK.bon_ende,
        BNK.bon_id,
        BNK.kasse_nr,
        BNK.umsatz_brutto AS kpf_ums_brutto,
         BNK.umsatz_brutto - BNK.umsatz_mwst AS kpf_ums_netto,
        bnv.ums_brutto AS vkf_ums_brutto,
        bnv.ums_netto AS vkf_ums_netto,
        bnv.menge AS vkf_menge,
        bnr.ums_brutto AS rtr_ums_brutto,
        bnr.ums_netto AS rtr_ums_netto,
        bnr.menge AS rtr_menge
       FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS BNK
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
         WHERE V.wg_id <> 961
         GROUP BY V.mandant_id,
          V.wup_id,
          V.bon_dat,
          V.bon_id) AS bnv ON BNK.bon_id = bnv.bon_id AND BNK.wup_id = bnv.wup_id AND BNK.mandant_id = bnv.mandant_id
         AND BNK.bon_dat = bnv.bon_dat
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
         WHERE R.wg_id <> 961
         GROUP BY R.mandant_id,
          R.wup_id,
          R.bon_dat,
          R.bon_id) AS bnr ON BNK.bon_id = bnr.bon_id AND BNK.wup_id = bnr.wup_id AND BNK.mandant_id = bnr.mandant_id
         AND BNK.bon_dat = bnr.bon_dat
       WHERE BNK.turnover_fg = 1
        AND BNK.bon_dat = CURRENT_DATE
        AND (BNK.bon_id, BNK.wup_id, BNK.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
          FROM kfl_production_dbp_v_ods.v_ods_bon_storno)
       UNION ALL
       SELECT BNK.mandant_id,
        BNK.wup_id,
        KRS.nach_wrg_id AS wrg_id,
        BNK.bon_dat,
        BNK.bon_beginn,
        BNK.bon_ende,
        BNK.bon_id,
        BNK.kasse_nr,
         BNK.umsatz_brutto * KRS.umrechnungskurs AS kpf_ums_brutto,
          (BNK.umsatz_brutto - BNK.umsatz_mwst) * KRS.umrechnungskurs AS kpf_ums_netto,
         bnv.ums_brutto * KRS.umrechnungskurs AS vkf_ums_brutto,
         bnv.ums_netto * KRS.umrechnungskurs AS vkf_ums_netto,
        bnv.menge AS vkf_menge,
         bnr.ums_brutto * KRS.umrechnungskurs AS rtr_ums_brutto,
         bnr.ums_netto * KRS.umrechnungskurs AS rtr_ums_netto,
        bnr.menge AS rtr_menge
       FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS BNK
        INNER JOIN kfl_production_dbp_view.v_mandant AS MDT ON BNK.mandant_id = MDT.mandant_id AND MDT.default_wrg <>
          'EUR'
        INNER JOIN kfl_production_dbp_view.v_kurs AS KRS ON BNK.wrg_id = KRS.von_wrg_id AND KRS.kurstyp_id = 3 AND KRS.dat_bis
           = PARSE_DATE('%Y%m%d', '99991231')
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
         WHERE V.wg_id <> 961
         GROUP BY V.mandant_id,
          V.wup_id,
          V.bon_dat,
          V.bon_id) AS bnv ON BNK.bon_id = bnv.bon_id AND BNK.wup_id = bnv.wup_id AND BNK.mandant_id = bnv.mandant_id
         AND BNK.bon_dat = bnv.bon_dat
        LEFT JOIN (SELECT R.mandant_id,
          R.wup_id,
          R.bon_id,
          R.bon_dat,
          SUM(R.umsatz_brutto) AS ums_brutto,
          SUM(R.umsatz_brutto / 100 * (RM.mwst + 100)) AS ums_netto,
          SUM(R.menge) AS menge
         FROM kfl_production_dbp_v_ods.v_ods_bon_retoure AS R
          INNER JOIN kfl_production_dbp_view.v_mwst_per AS RM ON R.mandant_id = RM.mandant_id AND R.mwst_id = RM.mwst_id
              AND R.bon_dat BETWEEN RM.dat_von AND RM.dat_bis
         WHERE R.wg_id <> 961
         GROUP BY R.mandant_id,
          R.wup_id,
          R.bon_dat,
          R.bon_id) AS bnr ON BNK.bon_id = bnr.bon_id AND BNK.wup_id = bnr.wup_id AND BNK.mandant_id = bnr.mandant_id
         AND BNK.bon_dat = bnr.bon_dat
       WHERE BNK.turnover_fg = 1
        AND BNK.bon_dat = CURRENT_DATE
        AND (BNK.bon_id, BNK.wup_id, BNK.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
          FROM kfl_production_dbp_v_ods.v_ods_bon_storno)) AS bnk
    GROUP BY mandant_id,
     wup_id,
     wrg_id,
     bon_dat,
     zeit_stunde) AS bn_kpf ON VIS00.mandant_id = bn_kpf.mandant_id AND VIS00.wup_id = bn_kpf.wup_id AND VIS00.wrg_id =
      bn_kpf.wrg_id AND VIS00.dat = bn_kpf.bon_dat
  WHERE VIS00.nb_id = 0
   AND VIS00.dat = CURRENT_DATE) (SELECT DISTINCT COALESCE(t7.mandant_id, t36.mandant_id) AS mandant_id,
   COALESCE(t7.nb_id, t36.nb_id) AS nb_id,
   COALESCE(t10.aktuell_wup_id, t7.wup_id, t36.wup_id) AS wup_id,
   COALESCE(t7.wrg_id, t36.wrg_id) AS wrg_id,
   COALESCE(t7.dat, t36.dat) AS dat,
   COALESCE(t7.zeit_stunde, t36.zeit_stunde) AS zeit_stunde,
   t7.zeit_stunde AS z1,
   t36.zeit_stunde AS z2,
   t36.bon_ende_min,
   t36.bon_ende_max,
   t36.bon_kunden_anz,
   t7.bon_kunden_anz_wvj,
   t36.bon_kassen_anz,
   t7.bon_kassen_anz_wvj,
   t36.bon_vkf_umsatz_netto,
   t36.bon_rtr_umsatz_netto,
   t36.bon_kpf_umsatz_netto,
   COALESCE(NULLIF(COALESCE(t36.bon_vkf_umsatz_netto, 0) + COALESCE(t36.bon_rtr_umsatz_netto, 0), 0), t36.bon_kpf_umsatz_netto
    ) AS bon_umsatz_netto_mix,
   NULLIF(COALESCE(t36.bon_vkf_umsatz_netto, 0) + COALESCE(t36.bon_rtr_umsatz_netto, 0), 0) AS bon_umsatz_netto,
   t7.bon_umsatz_netto_wvj,
   t36.bon_vkf_umsatz_brutto,
   t36.bon_rtr_umsatz_brutto,
   t36.bon_kpf_umsatz_brutto,
   COALESCE(NULLIF(COALESCE(t36.bon_vkf_umsatz_brutto, 0) + COALESCE(t36.bon_rtr_umsatz_brutto, 0), 0), t36.bon_kpf_umsatz_brutto
    ) AS bon_umsatz_brutto_mix,
   NULLIF(COALESCE(t36.bon_vkf_umsatz_brutto, 0) + COALESCE(t36.bon_rtr_umsatz_brutto, 0), 0) AS bon_umsatz_brutto,
   t7.bon_umsatz_brutto_wvj,
   COALESCE(t7.ums_netto_plan, t36.ums_netto_plan) AS ums_netto_plan,
   COALESCE(t7.ums_netto_wvj, t36.ums_netto_wvj) AS ums_netto_wvj
  FROM VIS01 AS t7
   LEFT JOIN WUP_ID_CHANGE AS t10 ON t7.mandant_id = t10.mandant_id AND t7.wup_id = t10.wup_id AND t7.dat_wvj BETWEEN
     t10.dat_von AND t10.dat_bis
   FULL JOIN VIS02 AS t36 ON t7.mandant_id = t36.mandant_id AND COALESCE(t10.aktuell_wup_id, t7.wup_id) = t36.wup_id AND
       t7.wrg_id = t36.wrg_id AND t7.dat = t36.dat AND t7.zeit_stunde = t36.zeit_stunde);