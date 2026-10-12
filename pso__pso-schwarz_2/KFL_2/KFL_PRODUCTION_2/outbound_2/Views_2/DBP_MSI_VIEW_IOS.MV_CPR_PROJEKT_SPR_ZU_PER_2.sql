CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_projekt_spr_zu_per_2 AS SELECT V11.projekt_id,
 V11.projekt_nr,
 V11.spr_id,
 V11.cpr_projekt_bez,
 COALESCE(V03.cpr_projekt_langtext, '') AS cpr_projekt_langtext,
 V11.projekt_kbez,
 V11.mandant_id,
 V11.dat_von,
 V11.dat_bis,
 V11.dat
FROM (SELECT V02.projekt_id,
   V04.cpr_ext_id AS projekt_nr,
   V02.spr_id,
   V02.cpr_projekt_bez,
   CAST(SUBSTR(V02.cpr_projekt_bez, 4, 80) AS STRING) AS projekt_kbez,
   V04.mandant_id,
   V02.dat_von,
   V02.dat_bis,
   T.dat
  FROM kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_2 AS V02
   LEFT JOIN kfl_production_dbp_view.v_tag_2 AS T ON T.dat BETWEEN V02.dat_von AND V02.dat_bis AND T.dat <= CURRENT_DATE
   INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_2 AS V04 ON V02.projekt_id = V04.projekt_id AND T.dat BETWEEN V04
     .dat_von AND V04.dat_bis
   INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V06 ON V02.spr_id = V06.spr_id) AS V11
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_2 AS V03 ON V11.projekt_id = V03.projekt_id AND V03.spr_id =
    22 AND V11.dat BETWEEN V03.dat_von AND V03.dat_bis;