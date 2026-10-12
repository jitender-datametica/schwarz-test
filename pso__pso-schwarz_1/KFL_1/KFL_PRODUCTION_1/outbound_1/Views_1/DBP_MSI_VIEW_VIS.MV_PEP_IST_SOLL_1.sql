CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_pep_ist_soll_1 AS SELECT v05.mandant_id,
 v01.idcompany,
 v05.wup_id,
 v05.dat,
 v01.anz_pzw_ma,
 v01.anz_nzw_ma,
 v03.umsatz_brutto,
 v05.ums_brutto_plan_dwh,
 v05.ums_brutto_plan_hl,
 v02.ist_zeit_stupf,
 COALESCE(v01.plan_zeit_pep, 0) AS plan_zeit_pep,
 COALESCE(v04.fehl_zeit, 0) AS fehl_zeit
FROM (SELECT 1 AS mandant_id,
   P.idcompany,
   W.wup_id,
   P.dat,
   SUM(CASE
     WHEN P.pzw_fg = 1
     THEN 1
     ELSE 0
     END) AS anz_pzw_ma,
   SUM(CASE
     WHEN P.pzw_fg <> 1
     THEN 1
     ELSE 0
     END) AS anz_nzw_ma,
   SUM(P.nettozeit) AS plan_zeit_pep
  FROM kfl_production_dbp_view.v_pep_planung_1 AS P
   INNER JOIN kfl_production_dbp_view.v_pep_filiale_1 AS W ON P.idcompany = W.idcompany
   INNER JOIN kfl_production_dbp_view.v_pep_personal_1 AS PERS ON P.idpersonal = PERS.idpersonal
  WHERE PERS.dat_austritt IS NULL
   OR PERS.dat_austritt > P.dat
  GROUP BY mandant_id,
   P.idcompany,
   W.wup_id,
   P.dat) AS v01
 LEFT JOIN (SELECT 1 AS mandant_id,
   dt1.idcompany,
   dt1.buchungsdatum AS dat,
    TIMESTAMP_DIFF(dt2.zeit_kom_geh, dt1.zeit_kom_geh, SECOND) / 3600 AS ist_zeit_stupf
  FROM (SELECT idpersonal,
     idcompany,
     kom_geh_fg,
     zeit_kom_geh,
     DATE(DATETIME_SUB(zeit_kom_geh, INTERVAL 3 HOUR)) AS buchungsdatum,
     SUM(1) OVER (PARTITION BY CAST(idpersonal AS STRING), CAST(idcompany AS STRING), DATE(DATETIME_SUB(zeit_kom_geh,
          INTERVAL 3 HOUR)) ORDER BY zeit_kom_geh IS NULL, zeit_kom_geh ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) AS order_num
    FROM kfl_production_dbp_view.v_pep_personal_bew_1 AS T01) AS dt1
   INNER JOIN (SELECT idpersonal,
     idcompany,
     kom_geh_fg,
     zeit_kom_geh,
     DATE(DATETIME_SUB(zeit_kom_geh, INTERVAL 3 HOUR)) AS buchungsdatum,
       (SUM(1) OVER (PARTITION BY CAST(idpersonal AS STRING), CAST(idcompany AS STRING), DATE(DATETIME_SUB(zeit_kom_geh
            ,INTERVAL 3 HOUR)) ORDER BY zeit_kom_geh IS NULL, zeit_kom_geh ROWS BETWEEN UNBOUNDED PRECEDING AND
        CURRENT ROW)) - 1 AS order_num
    FROM kfl_production_dbp_view.v_pep_personal_bew_1 AS T02) AS dt2 ON dt1.idpersonal = dt2.idpersonal AND dt1.idcompany
       = dt2.idcompany AND dt1.order_num = dt2.order_num AND dt1.buchungsdatum = dt2.buchungsdatum
   INNER JOIN kfl_production_dbp_view.v_pep_personal_per_1 AS PP ON dt1.idpersonal = PP.idpersonal AND dt1.buchungsdatum
     BETWEEN PP.dat_von AND PP.dat_bis
  WHERE dt1.kom_geh_fg = 0
   AND dt2.kom_geh_fg = 1) AS v02 ON v01.mandant_id = v02.mandant_id AND v01.dat = v02.dat AND v01.idcompany = v02.idcompany
   
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   dat,
   SUM(umsatz_brutto) AS umsatz_brutto
  FROM kfl_production_dbp_v_ods.v_ods_bon_agg_15min_1 AS O
  WHERE mandant_id = 1
   AND kasse_nr BETWEEN 1 AND 49
  GROUP BY dat,
   mandant_id,
   wup_id) AS v03 ON v01.mandant_id = v03.mandant_id AND v01.dat = v03.dat AND v01.wup_id = v03.wup_id
 LEFT JOIN (SELECT 1 AS mandant_id,
   P0.idcompany,
   P0.dat,
   SUM(P0.nettozeit) AS fehl_zeit
  FROM kfl_production_dbp_view.v_pep_planung_1 AS P0
   INNER JOIN kfl_production_dbp_view.v_pep_planung_fehlgrund_1 AS F ON P0.idpersonal = F.idpersonal AND P0.idcompany = F
      .idcompany AND P0.dat = F.dat
  GROUP BY mandant_id,
   P0.idcompany,
   P0.dat) AS v04 ON v01.mandant_id = v04.mandant_id AND v01.dat = v04.dat AND v01.idcompany = v04.idcompany
 RIGHT JOIN (SELECT mandant_id,
   wup_id,
   dat_plan AS dat,
   SUM(ums_brutto_plan) AS ums_brutto_plan_dwh,
   SUM(ums_brutto_plan_man) AS ums_brutto_plan_hl
  FROM kfl_production_dbp_msi_v_view.v_pep_plan_tag_1 AS PEP
  WHERE mandant_id = 1
  GROUP BY mandant_id,
   wup_id,
   dat) AS v05 ON v01.mandant_id = v05.mandant_id AND v01.dat = v05.dat AND v01.wup_id = v05.wup_id;