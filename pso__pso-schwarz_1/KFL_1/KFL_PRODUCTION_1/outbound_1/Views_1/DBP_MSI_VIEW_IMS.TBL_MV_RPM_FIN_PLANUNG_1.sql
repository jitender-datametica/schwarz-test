CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.tbl_mv_rpm_fin_planung_1 AS SELECT V01.dat_von,
 V03.rpm_hierarchie_id,
 V03.fin_kat_hierarchie_id,
 V03.fin_kategorie_id,
 COALESCE(V03.fin_kat_version_id, ' ') AS fin_kat_version_id,
 V03.fin_kat_version_dat,
 V02.fin_gruppe_hierarchie_id,
 V02.fin_gruppe_id,
 V01.rpm_plantyp_id,
 V02.fin_gruppe_version_id,
 V02.fin_gruppe_version_dat,
 V01.dat_start,
 COALESCE(V020.maxkp_fg, 0) AS maxkp_fg,
 V300.umrechnungskurs,
 V01.betrag
FROM kfl_production_dbp_view.v_rpm_fin_kategorie_1 AS V03
 LEFT JOIN kfl_production_dbp_view.v_rpm_fin_gruppe_1 AS V02 ON V03.fin_kategorie_id = V02.fin_kategorie_id AND V03.fin_kat_hierarchie_id
    = V02.fin_kat_hierarchie_id
 LEFT JOIN kfl_production_dbp_view.v_rpm_fin_plan_1 AS V01 ON V02.fin_gruppe_hierarchie_id = V01.fin_gruppe_hierarchie_id
  AND V01.dat_bis = DATE '9999-12-31'
 LEFT JOIN (SELECT t1.rpm_hierarchie_id,
   t1.rpm_plantyp_id,
   1 AS maxkp_fg
  FROM (SELECT FK.rpm_hierarchie_id,
     MAX(FP.rpm_plantyp_id) AS rpm_plantyp_id,
     SUM(FP.betrag) AS a0
    FROM kfl_production_dbp_view.v_rpm_fin_plan_1 AS FP
     INNER JOIN kfl_production_dbp_view.v_rpm_fin_gruppe_1 AS FG ON FP.fin_gruppe_hierarchie_id = FG.fin_gruppe_hierarchie_id
      
     INNER JOIN kfl_production_dbp_view.v_rpm_fin_kategorie_1 AS FK ON FG.fin_kat_hierarchie_id = FK.fin_kat_hierarchie_id
      
    WHERE FP.dat_bis = DATE '9999-12-31'
     AND FP.rpm_plantyp_id IN (1, 2, 3, 4, 11, 21, 22, 23, 24, 25, 26)
    GROUP BY FK.rpm_hierarchie_id
    HAVING a0 <> 0) AS t1_1) AS V020 ON V03.rpm_hierarchie_id = V020.rpm_hierarchie_id AND V01.rpm_plantyp_id = V020.rpm_plantyp_id
   
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V300 ON V01.dat_von BETWEEN V300.dat_von AND V300.dat_bis AND V01.wrg_id =
     V300.von_wrg_id AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR';