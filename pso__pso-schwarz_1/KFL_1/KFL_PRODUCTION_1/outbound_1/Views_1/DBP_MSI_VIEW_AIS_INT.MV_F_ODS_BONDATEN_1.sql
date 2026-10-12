CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_f_ods_bondaten_1 (mandant_id, bon_dat, bon_booking, wup_id,
nb_id, wrg_id, turnover_fg, kunde_fg, suspended_fg, kl_art_id, art_id, wg_id, letzter_bon, menge_vk, umsatz_brutto_vk,
menge_ret, umsatz_brutto_ret, menge_vk_af, menge_vk_sa, menge_ret_af, menge_ret_sa, umsatz_brutto_vk_af,
umsatz_brutto_vk_sa, umsatz_brutto_ret_af, umsatz_brutto_ret_sa) AS SELECT t48.mandant_id,
 t48.bon_dat,
 t48.bon_booking,
 t48.wup_id,
 t48.nb_id,
  CASE
  WHEN t48.wrg_typ_id = 0
  THEN t48.nach_wrg_id
  ELSE t48.default_wrg
  END AS wrg_id,
 t48.turnover_fg,
 t48.kunde_fg,
 t48.suspended_fg,
 t48.kl_art_id,
 t48.art_id,
 t48.wg_id,
 t48.letzter_bon,
 t48.menge_vk,
  CASE
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 0
  THEN t48.a0 * t48.umrechnungskurs
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 1
  THEN t48.a0 * t48.umrechnungskurs0
  ELSE t48.a0
  END AS umsatz_brutto_vk,
 t48.menge_ret,
  CASE
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 0
  THEN t48.a0_0 * t48.umrechnungskurs
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 1
  THEN t48.a0_0 * t48.umrechnungskurs0
  ELSE t48.a0_0
  END AS umsatz_brutto_ret,
 t48.menge_vk_af,
 t48.menge_vk_sa,
 t48.menge_ret_af,
 t48.menge_ret_sa,
  CASE
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 0
  THEN t48.a0_1 * t48.umrechnungskurs
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 1
  THEN t48.a0_1 * t48.umrechnungskurs0
  ELSE t48.a0_1
  END AS umsatz_brutto_vk_af,
  CASE
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 0
  THEN t48.a0_2 * t48.umrechnungskurs
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 1
  THEN t48.a0_2 * t48.umrechnungskurs0
  ELSE t48.a0_2
  END AS umsatz_brutto_vk_sa,
  CASE
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 0
  THEN t48.a0_3 * t48.umrechnungskurs
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 1
  THEN t48.a0_3 * t48.umrechnungskurs0
  ELSE t48.a0_3
  END AS umsatz_brutto_ret_af,
  CASE
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 0
  THEN t48.a0_4 * t48.umrechnungskurs
  WHEN t48.wrg_typ_id = 0 AND t48.berichtskurs_typ_id = 1
  THEN t48.a0_4 * t48.umrechnungskurs0
  ELSE t48.a0_4
  END AS umsatz_brutto_ret_sa
FROM (SELECT bon.mandant_id,
   bon.bon_dat,
   bon.bon_booking,
   bon.wup_id,
   0 AS nb_id,
   bon.wrg_id,
   bon.turnover_fg,
   bon.kunde_fg,
   bon.suspended_fg,
   bon.kl_art_id,
   V99.art_id,
   bon.wg_id,
   V100.wrg_typ_id,
   V100.berichtskurs_typ_id,
   V200.nach_wrg_id,
   V102.default_wrg,
   V200.umrechnungskurs,
   V300.umrechnungskurs AS umrechnungskurs0,
   MAX(bon.bon_booking) AS letzter_bon,
   SUM(IFNULL(bon.menge_vk, 0)) AS menge_vk,
   SUM(IFNULL(bon.umsatz_brutto_vk, 0)) AS a0,
   SUM(IFNULL(bon.menge_ret, 0)) AS menge_ret,
   SUM(IFNULL(bon.umsatz_brutto_ret, 0)) AS a0_0,
   SUM(IFNULL(bon.menge_vk_af, 0)) AS menge_vk_af,
   SUM(IFNULL(bon.menge_vk_sa, 0)) AS menge_vk_sa,
   SUM(IFNULL(bon.menge_ret_af, 0)) AS menge_ret_af,
   SUM(IFNULL(bon.menge_ret_sa, 0)) AS menge_ret_sa,
   SUM(IFNULL(bon.umsatz_brutto_vk_af, 0)) AS a0_1,
   SUM(IFNULL(bon.umsatz_brutto_vk_sa, 0)) AS a0_2,
   SUM(IFNULL(bon.umsatz_brutto_ret_af, 0)) AS a0_3,
   SUM(IFNULL(bon.umsatz_brutto_ret_sa, 0)) AS a0_4
  FROM (SELECT t35.bon_id,
      t35.bon_dat,
      t35.wup_id,
      t35.mandant_id,
      t35.wrg_id,
      t35.turnover_fg,
      t35.suspended_fg,
      t35.kunde_fg,
      t35.kl_art_id,
      t35.wg_id,
      t35.bon_booking,
      t35.`_sa_tracker`,
      t35.`_af_tracker`,
      CAST(t35.`_af_tracker_ret` AS STRING) AS `_af_tracker_ret`,
      CAST(t35.`_af_tracker_ret` AS STRING) AS `_sa_tracker_ret`,
      t35.menge_vk,
      t35.umsatz_brutto_vk,
      CAST(t35.`_af_tracker_ret` AS NUMERIC) AS menge_ret,
      CAST(t35.`_af_tracker_ret` AS NUMERIC) AS umsatz_brutto_ret,
       CASE
       WHEN t35.`_af_tracker` = 'af'
       THEN t35.menge_vk
       ELSE 0
       END AS menge_vk_af,
       CASE
       WHEN t35.`_sa_tracker` = 'sa'
       THEN t35.menge_vk
       ELSE 0
       END AS menge_vk_sa,
      CAST(t35.`_af_tracker_ret` AS BIGNUMERIC) AS menge_ret_af,
      CAST(t35.`_af_tracker_ret` AS BIGNUMERIC) AS menge_ret_sa,
       CASE
       WHEN t35.`_af_tracker` = 'af'
       THEN t35.umsatz_brutto_vk
       ELSE 0
       END AS umsatz_brutto_vk_af,
       CASE
       WHEN t35.`_sa_tracker` = 'sa'
       THEN t35.umsatz_brutto_vk
       ELSE 0
       END AS umsatz_brutto_vk_sa,
      CAST(t35.`_af_tracker_ret` AS BIGNUMERIC) AS umsatz_brutto_ret_af,
      CAST(t35.`_af_tracker_ret` AS BIGNUMERIC) AS umsatz_brutto_ret_sa
     FROM (SELECT ok.bon_id,
        ok.bon_dat,
        ok.wup_id,
        ok.mandant_id,
        ok.wrg_id,
        ok.turnover_fg,
        ok.suspended_fg,
        ok.kunde_fg,
        vk.kl_art_id,
        vk.wg_id,
        ok.bon_booking,
         CASE
         WHEN po_sa.tracker = 'sa_bby' AND vk.tracker = 'sa' AND (po_af.tracker IS NULL OR po_af.tracker = 'unique' OR
                 po_af.tracker LIKE 'bonrabatt%' OR po_af.tracker LIKE 'mhd%' OR po_af.tracker LIKE 'smp%') OR po_sa.tracker
               = 'sa_bby' AND vk.tracker = 'af' AND (po_af.tracker IS NULL OR po_af.tracker = 'unique' OR po_af.tracker
                 LIKE 'bonrabatt%' OR po_af.tracker LIKE 'mhd%' OR po_af.tracker LIKE 'smp%') OR po_sa.tracker IS NULL
            AND vk.tracker = 'sa' AND (po_af.tracker IS NULL OR po_af.tracker = 'unique' OR po_af.tracker LIKE
                'bonrabatt%' OR po_af.tracker LIKE 'mhd%' OR po_af.tracker LIKE 'smp%')
         THEN 'sa'
         ELSE NULL
         END AS `_sa_tracker`,
         CASE
         WHEN vk.tracker = 'af' AND po_sa.tracker IS NULL AND (po_af.tracker IS NULL OR po_af.tracker = 'unique' OR
               po_af.tracker LIKE 'bonrabatt%' OR po_af.tracker LIKE 'mhd%' OR po_af.tracker LIKE 'smp%')
         THEN 'af'
         ELSE NULL
         END AS `_af_tracker`,
        NULL AS `_af_tracker_ret`,
        NULL AS `_sa_tracker_ret`,
        NULL AS menge_ret,
        NULL AS umsatz_brutto_ret,
        NULL AS menge_ret_af,
        NULL AS menge_ret_sa,
        NULL AS umsatz_brutto_ret_af,
        NULL AS umsatz_brutto_ret_sa,
        SUM(vk.menge) AS menge_vk,
        SUM(vk.umsatz_brutto) AS umsatz_brutto_vk
       FROM (SELECT *
         FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1
         WHERE bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)) AS ok
        FULL JOIN (SELECT mandant_id,
          wup_id,
          bon_dat,
          bon_id,
          bon_zeile,
          kl_art_id,
          wg_id,
           CASE
           WHEN aktion_id IN ('0', '0000000000', '')
           THEN 'af'
           ELSE 'sa'
           END AS tracker,
          menge,
          umsatz_brutto
         FROM kfl_production_dbp_v_ods.v_ods_bon_verkauf_1
         WHERE bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
          AND wg_id <> 961
         GROUP BY mandant_id,
          wup_id,
          bon_dat,
          bon_id,
          bon_zeile,
          kl_art_id,
          wg_id,
          tracker,
          menge,
          umsatz_brutto) AS vk_1 ON ok.mandant_id = vk.mandant_id AND ok.bon_dat = vk.bon_dat AND ok.bon_id = vk.bon_id
         AND ok.wup_id = vk.wup_id
        FULL JOIN (SELECT PO.mandant_id,
          PO.wup_id,
          PO.bon_dat,
          PO.bon_id,
          PO.bon_zeile,
          PO.kl_art_id,
          'sa_bby' AS tracker
         FROM kfl_production_dbp_v_ods.v_ods_promotion_1 AS PO
          FULL JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf_1 AS VK_1 ON PO.mandant_id = VK.mandant_id AND PO.wup_id = VK_1
               .wup_id AND PO.bon_dat = VK.bon_dat AND PO.bon_id = VK.bon_id AND PO.bon_zeile = VK.bon_zeile
         WHERE PO.promotion_art <> 'PERSONAL_SMP'
          AND PO.bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
          AND (VK.wg_id <> 822 OR VK.aktion_id NOT IN ('0', '0000000000', '') OR PO.promotion_art <> 'PERSONAL')
          AND PO.konditionsart_id NOT IN ('ZRT3', 'ZBON', 'ZBOV')
         GROUP BY PO.mandant_id,
          PO.wup_id,
          PO.bon_dat,
          PO.bon_id,
          PO.bon_zeile,
          PO.kl_art_id,
          tracker) AS po_sa ON vk.mandant_id = po_sa.mandant_id AND vk.wup_id = po_sa.wup_id AND vk.bon_dat = po_sa.bon_dat
              AND vk.bon_id = po_sa.bon_id AND vk.bon_zeile = po_sa.bon_zeile AND vk.kl_art_id = po_sa.kl_art_id
        FULL JOIN (SELECT *
          FROM (SELECT mandant_id,
              wup_id,
              bon_dat,
              bon_id,
              bon_zeile,
              kl_art_id,
              'unique' AS tracker
             FROM kfl_production_dbp_v_ods.v_ods_promotion_1 AS PO
             WHERE bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
              AND (mandant_id, wup_id, bon_dat, bon_id, bon_zeile, kl_art_id) IN (SELECT (mandant_id, wup_id, bon_dat,
                  bon_id, bon_zeile, kl_art_id)
                FROM (SELECT mandant_id,
                   bon_id,
                   wup_id,
                   bon_zeile,
                   kl_art_id,
                   bon_dat,
                   COUNT(*) AS dist
                  FROM kfl_production_dbp_v_ods.v_ods_promotion_1 AS PO
                  WHERE bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
                  GROUP BY mandant_id,
                   bon_id,
                   wup_id,
                   bon_zeile,
                   kl_art_id,
                   bon_dat
                  HAVING dist = 1) AS t10)
              AND (konditionsart_id IN ('ZRT3', 'ZBON', 'ZBOV') OR promotion_art = 'PERSONAL_SMP')
             UNION DISTINCT
             SELECT PO.mandant_id,
              PO.wup_id,
              PO.bon_dat,
              PO.bon_id,
              PO.bon_zeile,
              PO.kl_art_id,
              'unique' AS tracker
             FROM kfl_production_dbp_v_ods.v_ods_bon_verkauf_1 AS VK_1
              INNER JOIN kfl_production_dbp_v_ods.v_ods_promotion_1 AS PO ON VK.mandant_id = PO.mandant_id AND VK.bon_id =
                   PO.bon_id AND VK.wup_id = PO.wup_id AND VK.bon_dat = PO.bon_dat AND VK.bon_zeile = PO.bon_zeile
             WHERE VK.bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
              AND VK.wg_id = 822
              AND VK.aktion_id IN ('0', '0000000000', '')
              AND PO.promotion_art = 'PERSONAL'
              AND (PO.mandant_id, PO.wup_id, PO.bon_dat, PO.bon_id, PO.bon_zeile, PO.kl_art_id) IN (SELECT (mandant_id,
                  wup_id, bon_dat, bon_id, bon_zeile, kl_art_id)
                FROM (SELECT mandant_id,
                   bon_id,
                   wup_id,
                   bon_zeile,
                   kl_art_id,
                   bon_dat,
                   COUNT(*) AS dist
                  FROM kfl_production_dbp_v_ods.v_ods_promotion_1 AS PO
                  WHERE bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
                  GROUP BY mandant_id,
                   bon_id,
                   wup_id,
                   bon_zeile,
                   kl_art_id,
                   bon_dat
                  HAVING dist = 1) AS t16))
          UNION ALL
          SELECT mandant_id,
           wup_id,
           bon_dat,
           bon_id,
           bon_zeile,
           kl_art_id,
           STRING_AGG(DISTINCT CAST(tracker AS STRING), ',' ORDER BY  tracker) AS `_tracker`
          FROM (SELECT b.mandant_id,
             b.wup_id,
             b.bon_dat,
             b.bon_id,
             b.bon_zeile,
             A.kl_art_id,
             A.konditionsart_id,
              CASE
              WHEN A.konditionsart_id IN ('ZBON', 'ZBOV')
              THEN 'bonrabatt'
              WHEN A.promotion_art IN ('PERSONAL_SMP')
              THEN 'smp'
              WHEN A.konditionsart_id IN ('ZRT3')
              THEN 'mhd'
              ELSE 'bby'
              END AS tracker
            FROM kfl_production_dbp_v_ods.v_ods_promotion_1 AS A
             INNER JOIN (SELECT mandant_id,
               wup_id,
               bon_dat,
               bon_id,
               bon_zeile,
               kl_art_id,
               COUNT(*) AS dist
              FROM kfl_production_dbp_v_ods.v_ods_promotion_1 AS PO
              WHERE bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
              GROUP BY mandant_id,
               bon_id,
               wup_id,
               bon_zeile,
               kl_art_id,
               bon_dat
              HAVING dist > 1) AS b ON A.mandant_id = b.mandant_id AND A.bon_dat = b.bon_dat AND A.wup_id = b.wup_id AND
                 A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile AND A.kl_art_id = b.kl_art_id
            GROUP BY b.mandant_id,
             b.wup_id,
             b.bon_dat,
             b.bon_id,
             b.bon_zeile,
             A.kl_art_id,
             A.konditionsart_id,
             tracker
            ORDER BY 1 NULLS LAST,
             2 NULLS LAST,
             3 NULLS LAST,
             4 NULLS LAST) AS a
          GROUP BY mandant_id,
           wup_id,
           bon_dat,
           bon_id,
           bon_zeile,
           kl_art_id
          HAVING `_tracker` NOT LIKE 'bby%') AS po_af ON vk.mandant_id = po_af.mandant_id AND vk.wup_id = po_af.wup_id
            AND vk.bon_dat = po_af.bon_dat AND vk.bon_id = po_af.bon_id AND vk.bon_zeile = po_af.bon_zeile AND vk.kl_art_id
           = po_af.kl_art_id
       GROUP BY ok.bon_id,
        ok.bon_dat,
        ok.wup_id,
        ok.mandant_id,
        ok.wrg_id,
        ok.turnover_fg,
        ok.suspended_fg,
        ok.kunde_fg,
        vk.kl_art_id,
        vk.wg_id,
        ok.bon_booking,
        `_sa_tracker`,
        `_af_tracker`,
        `_af_tracker_ret`,
        `_sa_tracker_ret`,
        menge_ret,
        umsatz_brutto_ret,
        menge_ret_af,
        menge_ret_sa,
        umsatz_brutto_ret_af,
        umsatz_brutto_ret_sa) AS t35
     UNION ALL
     SELECT t42.bon_id,
      t42.bon_dat,
      t42.wup_id,
      t42.mandant_id,
      t42.wrg_id,
      t42.turnover_fg,
      t42.suspended_fg,
      t42.kunde_fg,
      t42.kl_art_id,
      t42.wg_id,
      t42.bon_booking,
      CAST(t42.`_sa_tracker` AS STRING) AS `_sa_tracker`,
      CAST(t42.`_sa_tracker` AS STRING) AS `_af_tracker`,
      t42.`_af_tracker_ret`,
      t42.`_sa_tracker_ret`,
      CAST(t42.`_sa_tracker` AS NUMERIC) AS menge_vk,
      CAST(t42.`_sa_tracker` AS NUMERIC) AS umsatz_brutto_vk,
      t42.menge_ret,
      t42.umsatz_brutto_ret,
      CAST(t42.`_sa_tracker` AS BIGNUMERIC) AS menge_vk_af,
      CAST(t42.`_sa_tracker` AS BIGNUMERIC) AS menge_vk_sa,
       CASE
       WHEN t42.`_af_tracker_ret` = 'af_ret'
       THEN t42.menge_ret
       ELSE 0
       END AS menge_ret_af,
       CASE
       WHEN t42.`_sa_tracker_ret` = 'sa_ret'
       THEN t42.menge_ret
       ELSE 0
       END AS menge_ret_sa,
      CAST(t42.`_sa_tracker` AS BIGNUMERIC) AS umsatz_brutto_vk_af,
      CAST(t42.`_sa_tracker` AS BIGNUMERIC) AS umsatz_brutto_sa_sa,
       CASE
       WHEN t42.`_af_tracker_ret` = 'af_ret'
       THEN t42.umsatz_brutto_ret
       ELSE 0
       END AS umsatz_brutto_ret_af,
       CASE
       WHEN t42.`_sa_tracker_ret` = 'sa_ret'
       THEN t42.umsatz_brutto_ret
       ELSE 0
       END AS umsatz_brutto_ret_sa
     FROM (SELECT OK.bon_id,
        OK.bon_dat,
        OK.wup_id,
        OK.mandant_id,
        OK.wrg_id,
        OK.turnover_fg,
        OK.suspended_fg,
        OK.kunde_fg,
        ret.kl_art_id,
        ret.wg_id,
        OK.bon_booking,
        NULL AS `_sa_tracker`,
        NULL AS `_af_tracker`,
         CASE
         WHEN ret.tracker_ret = 'af_ret'
         THEN 'af_ret'
         ELSE NULL
         END AS `_af_tracker_ret`,
         CASE
         WHEN ret.tracker_ret = 'sa_ret'
         THEN 'sa_ret'
         ELSE NULL
         END AS `_sa_tracker_ret`,
        NULL AS menge_vk,
        NULL AS umsatz_brutto_vk,
        NULL AS menge_vk_af,
        NULL AS menge_vk_sa,
        NULL AS umsatz_brutto_vk_af,
        NULL AS umsatz_brutto_sa_sa,
        SUM(ret.menge) AS menge_ret,
        SUM(ret.umsatz_brutto) AS umsatz_brutto_ret
       FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS OK
        INNER JOIN (SELECT RET.mandant_id,
          RET.wup_id,
          RET.bon_dat,
          RET.bon_id,
          RET.bon_zeile,
          RET.kl_art_id,
          RET.wg_id,
           CASE
           WHEN RET.aktion_id NOT IN ('0', '0000000000', '') OR PO.promotion_art <> 'PERSONAL_SMP' AND PO.bonuskauf_id
                NOT IN ('0', '0000000000', '') AND PO.konditionsart_id NOT IN ('ZRT3', 'ZBON', 'ZBOV') OR RET.wg_id =
               822 AND PO.promotion_art <> 'PERSONAL' AND RET.aktion_id NOT IN ('0', '0000000000', '')
           THEN 'sa_ret'
           ELSE 'af_ret'
           END AS tracker_ret,
          RET.menge,
          RET.umsatz_brutto
         FROM kfl_production_dbp_v_ods.v_ods_bon_retoure_1 AS RET
          FULL JOIN kfl_production_dbp_v_ods.v_ods_promotion_1 AS PO ON RET.bon_id = PO.bon_id AND RET.mandant_id = PO.mandant_id
                AND RET.wup_id = PO.wup_id AND RET.bon_dat = PO.bon_dat AND RET.bon_zeile = PO.bon_zeile
         WHERE RET.bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 14 DAY) AND (CURRENT_DATE)
          AND RET.wg_id <> 961
         GROUP BY RET.mandant_id,
          RET.wup_id,
          RET.bon_dat,
          RET.bon_id,
          RET.bon_zeile,
          RET.kl_art_id,
          RET.wg_id,
          tracker_ret,
          RET.menge,
          RET.umsatz_brutto) AS ret ON OK.mandant_id = ret.mandant_id AND OK.wup_id = ret.wup_id AND OK.bon_id = ret.bon_id
            AND OK.bon_dat = ret.bon_dat
       GROUP BY OK.bon_id,
        OK.bon_dat,
        OK.wup_id,
        OK.mandant_id,
        OK.wrg_id,
        OK.turnover_fg,
        OK.suspended_fg,
        OK.kunde_fg,
        ret.kl_art_id,
        ret.wg_id,
        OK.bon_booking,
        `_sa_tracker`,
        `_af_tracker`,
        `_af_tracker_ret`,
        `_sa_tracker_ret`,
        menge_vk,
        umsatz_brutto_vk,
        menge_vk_af,
        menge_vk_sa,
        umsatz_brutto_vk_af,
        umsatz_brutto_sa_sa) AS t42) AS bon
   INNER JOIN kfl_production_dbp_view.v_art_1 AS V99 ON bon.kl_art_id = V99.kl_art_id AND bon.mandant_id = V99.mandant_id
    AND bon.bon_dat BETWEEN V99.dat_von AND V99.dat_bis
   INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V100 ON TRUE
   INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V200 ON bon.wrg_id = V200.von_wrg_id
   INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V300 ON bon.bon_dat BETWEEN V300.dat_von AND V300.dat_bis AND bon.wrg_id
      = V300.von_wrg_id
   INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V102 ON bon.mandant_id = V102.mandant_id
  WHERE V300.kurstyp_id = 3
   AND V300.nach_wrg_id = 'EUR'
   AND V200.dat_bis = DATE '9999-12-31'
   AND V200.kurstyp_id = 3
   AND V200.nach_wrg_id = 'EUR'
   AND (bon.bon_id, bon.wup_id, bon.mandant_id) NOT IN (SELECT (bon_id, cast(wup_id as INT64), cast(mandant_id as INT64))
     FROM kfl_production_dbp_v_ods.v_ods_bon_storno_1)
  GROUP BY bon.mandant_id,
   bon.bon_dat,
   bon.bon_booking,
   bon.wup_id,
   nb_id,
   bon.wrg_id,
   bon.turnover_fg,
   bon.kunde_fg,
   bon.suspended_fg,
   bon.kl_art_id,
   V99.art_id,
   bon.wg_id,
   V100.wrg_typ_id,
   V100.berichtskurs_typ_id,
   V200.nach_wrg_id,
   V102.default_wrg,
   V200.umrechnungskurs,
   umrechnungskurs0) AS t48
ORDER BY t48.mandant_id NULLS LAST,
 t48.bon_dat NULLS LAST,
 t48.bon_booking NULLS LAST,
 t48.wup_id NULLS LAST,
 t48.kl_art_id NULLS LAST,
 t48.turnover_fg NULLS LAST;