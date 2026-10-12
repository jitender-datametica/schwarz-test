CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_pep_stunden_soll_2 AS SELECT sub00.mandant_id,
 sub00.nb_id,
 sub00.wup_id,
 sub00.dat,
 sub00.ums_netto_plan_wup,
 0 AS ums_netto_wup,
 0 AS ums_brutto_wup,
 sub01.anzahl_ma_pzw,
 sub01.anzahl_ma_nzw,
 sub01.stunden_pep_plan,
 sub01.anzahl_ma_pzw_fehl,
 sub01.anzahl_ma_nzw_fehl,
 sub01.stunden_pep_fehl,
  sub01.stunden_pep_plan - sub01.stunden_pep_fehl AS stunden_pep_plan_fehl,
 sub02.stunden_pep_ist,
 sub03.ums_brutto_ist,
 sub03.ums_brutto_plan_dwh,
 sub03.ums_brutto_plan_hl,
 0 AS umsatz_brutto_ma_stunde_plan,
 0 AS regression_faktor,
 0 AS brutto_netto_faktor,
 COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh) AS ums_brutto_plan,
 0 AS ums_brutto_plan_co,
 0 AS stunden_soll_plan_co,
 0 AS ums_brutto_plan_diff,
 0 AS ums_brutto_plan_regr,
 ROUND(CAST(LN(CASE
       WHEN COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh) = 0
       THEN NULL
       ELSE COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh)
       END) * sub05.regression_faktor_var + sub05.regression_faktor_fix AS BIGNUMERIC), 5) AS stunden_soll_plan,
 0 AS ums_brutto_ist_diff,
 0 AS ums_brutto_ist_regr,
 ROUND(CAST(LN(CASE
       WHEN sub03.ums_brutto_ist = 0
       THEN NULL
       ELSE sub03.ums_brutto_ist
       END) * sub05.regression_faktor_var + sub05.regression_faktor_fix AS BIGNUMERIC), 5) AS stunden_soll_ist,
  sub03.ums_brutto_ist - COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh) AS ums_brutto_abw,
  COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh) - sub03.ums_brutto_ist AS ums_brutto_diff,
  ROUND(CAST(LN(CASE
        WHEN COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh) = 0
        THEN NULL
        ELSE COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh)
        END) * sub05.regression_faktor_var + sub05.regression_faktor_fix AS BIGNUMERIC), 5) - sub01.stunden_pep_plan AS
 stunden_plan_abw,
  ROUND(CAST(LN(CASE
        WHEN COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh) = 0
        THEN NULL
        ELSE COALESCE(sub03.ums_brutto_plan_hl, sub03.ums_brutto_plan_dwh)
        END) * sub05.regression_faktor_var + sub05.regression_faktor_fix AS BIGNUMERIC), 5) - (sub01.stunden_pep_plan -
    sub01.stunden_pep_fehl) AS stunden_plan_abw_fehl,
  ROUND(CAST(LN(CASE
        WHEN sub03.ums_brutto_ist = 0
        THEN NULL
        ELSE sub03.ums_brutto_ist
        END) * sub05.regression_faktor_var + sub05.regression_faktor_fix AS BIGNUMERIC), 5) - sub02.stunden_pep_ist AS
 stunden_ist_abw
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.dat,
   VIS.ums_netto_plan AS ums_netto_plan_wup
  FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 AS VIS
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS ZEIT_2 ON VIS.dat = ZEIT.dat AND ZEIT.akt_mo BETWEEN - 15 AND 2
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wup_2 AS WP ON VIS.mandant_id = WP.mandant_id AND VIS.wup_id = WP.wup_id
     AND WP.mandant_id = 1 AND WP.nb_id = 0) AS sub00
 LEFT JOIN (SELECT FIL.mandant_id,
   FIL.nb_id,
   FIL.wup_id,
   PLAN.dat,
   SUM(CASE
     WHEN PLAN.pzw_fg = 1
     THEN 1
     ELSE 0
     END) AS anzahl_ma_pzw,
   SUM(CASE
     WHEN PLAN.pzw_fg <> 1
     THEN 1
     ELSE 0
     END) AS anzahl_ma_nzw,
   SUM(IFNULL(PLAN.nettozeit, 0)) AS stunden_pep_plan,
   SUM(CASE
     WHEN FEHL.idfehlgrund <> 0 AND PLAN.pzw_fg = 1
     THEN 1
     ELSE 0
     END) AS anzahl_ma_pzw_fehl,
   SUM(CASE
     WHEN FEHL.idfehlgrund <> 0 AND PLAN.pzw_fg <> 1
     THEN 1
     ELSE 0
     END) AS anzahl_ma_nzw_fehl,
   SUM(CASE
     WHEN FEHL.idfehlgrund <> 0
     THEN PLAN.nettozeit
     ELSE 0
     END) AS stunden_pep_fehl
  FROM kfl_production_dbp_view.v_pep_planung_2 AS PLAN
   INNER JOIN kfl_production_dbp_view.v_pep_filiale_2 AS FIL ON PLAN.idcompany = FIL.idcompany
   INNER JOIN kfl_production_dbp_view.v_pep_personal_2 AS PERS ON PLAN.idpersonal = PERS.idpersonal
   LEFT JOIN kfl_production_dbp_view.v_pep_planung_fehlgrund_2 AS FEHL ON PLAN.idpersonal = FEHL.idpersonal AND PLAN.idcompany
       = FEHL.idcompany AND PLAN.dat = FEHL.dat
  WHERE COALESCE(PERS.dat_austritt, PARSE_DATE('%F', '9999-12-31')) > PLAN.dat
   AND PLAN.plan_fg = 1
  GROUP BY FIL.mandant_id,
   FIL.nb_id,
   FIL.wup_id,
   PLAN.dat) AS sub01 ON sub00.mandant_id = sub01.mandant_id AND sub00.wup_id = sub01.wup_id AND sub00.dat = sub01.dat
 LEFT JOIN (SELECT FIL0.mandant_id,
   FIL0.nb_id,
   FIL0.wup_id,
   PZEIT.dat,
   SUM(PZEIT.zeit_sekunden) AS zeit_stupf_ist,
    SUM(PZEIT.zeit_sekunden) / 3600.00 AS stunden_pep_ist
  FROM kfl_production_dbp_view.v_pep_personal_bew_zeit_2 AS PZEIT
   INNER JOIN kfl_production_dbp_view.v_pep_filiale_2 AS FIL0 ON PZEIT.mandant_id = FIL0.mandant_id AND PZEIT.idcompany =
     FIL0.idcompany
   INNER JOIN kfl_production_dbp_view.v_pep_personal_per_2 AS PERS0 ON PZEIT.idpersonal = PERS0.idpersonal
  WHERE PZEIT.dat BETWEEN PERS0.dat_von AND PERS0.dat_bis
  GROUP BY PZEIT.dat,
   FIL0.wup_id,
   FIL0.nb_id,
   FIL0.mandant_id) AS sub02 ON sub00.mandant_id = sub02.mandant_id AND sub00.wup_id = sub02.wup_id AND sub00.dat =
   sub02.dat
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   dat_plan AS dat,
   SUM(ums_brutto_ist_bondaten) AS ums_brutto_ist,
   SUM(ums_brutto_plan) AS ums_brutto_plan_dwh,
   SUM(ums_brutto_plan_man) AS ums_brutto_plan_hl
  FROM kfl_production_dbp_msi_v_view.v_pep_plan_tag_2 AS PEP
  WHERE mandant_id = 1
   AND nb_id = 0
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   dat) AS sub03 ON sub00.mandant_id = sub03.mandant_id AND sub00.wup_id = sub03.wup_id AND sub00.dat = sub03.dat
 LEFT JOIN (SELECT mandant_id,
   nb_id,
   wup_id,
   dat,
   regression_faktor_var,
   regression_faktor_fix
  FROM kfl_production_dbp_view.v_wup_plan_tag_co_v2_2 AS PLANC2
  WHERE mandant_id = 1
   AND nb_id = 0) AS sub05 ON sub00.mandant_id = sub05.mandant_id AND sub00.wup_id = sub05.wup_id AND sub00.dat = sub05
   .dat;