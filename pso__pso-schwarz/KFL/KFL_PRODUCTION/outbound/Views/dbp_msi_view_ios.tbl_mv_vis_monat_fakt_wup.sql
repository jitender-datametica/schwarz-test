CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.tbl_mv_vis_monat_fakt_wup AS SELECT V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V888.rpm_hierarchie_id,
 COALESCE(V999.vs_id, 0) AS vs_id,
 V01.kjmo,
 DATE_SUB(DATE(EXTRACT(YEAR FROM CURRENT_DATE()), 3, 1), INTERVAL 24 MONTH ) AS expansionsbereinigung_dat,
 V999.dat_eroeffnung,
 CAST(COALESCE(V01.ums_netto_plan, 0) AS NUMERIC) AS umsatz_netto_plan_euro,
 CAST(COALESCE(V01.ums_netto_kvj, 0) AS NUMERIC) AS umsatz_netto_vj_euro,
 V01.ums_netto,
 V01.ums_netto_kvj,
 V01.ums_netto_kvvj,
 V01.ums_netto_plan,
 V01.wrg_id
FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup AS V01
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_mandant AS V250 ON V01.mandant_id = V250.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_kurs AS V300 ON V300.dat_bis = DATE '9999-12-31' AND V250.default_wrg =
     V300.von_wrg_id AND V300.kurstyp_id = 3 AND V01.wrg_id = V300.nach_wrg_id
 INNER JOIN kfl_production_dbp_view.v_rpm_immobilie_per AS V888 ON V01.wup_id = V888.wup_id AND V01.nb_id = V888.nb_id
   AND V01.mandant_id = V888.mandant_id AND V888.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_msi_view_ios.mv_wup AS V999 ON V01.wup_id = V999.wup_id AND V01.nb_id = V999.nb_id AND
   V01.mandant_id = V999.mandant_id
 INNER JOIN (SELECT wup_id,
   nb_id,
   mandant_id,
       (CAST(MIN(kjmo) / 100 AS BIGNUMERIC) - 1900) * 10000 + MOD(CAST(MIN(kjmo) AS BIGNUMERIC), 100) * 100 + 1 AS
   min_kjmo_wup_umsatz
  FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup AS V98
  GROUP BY mandant_id,
   nb_id,
   wup_id) AS v97 ON V999.wup_id = v97.wup_id AND V999.nb_id = v97.nb_id AND V999.mandant_id = v97.mandant_id
WHERE V01.wrg_id = 'EUR';