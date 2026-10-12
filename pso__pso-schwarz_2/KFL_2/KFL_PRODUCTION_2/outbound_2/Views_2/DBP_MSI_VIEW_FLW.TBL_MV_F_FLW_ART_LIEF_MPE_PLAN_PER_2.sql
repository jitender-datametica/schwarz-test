CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_art_lief_mpe_plan_per_2 (mandant_id, in_art_id,
in_lief_id, werk_id, flw_version_id, menge, pjwo, pjwo_vw, dat_aenderung, default_wrg, wrg_id, bruttopreis, nettopreis)
AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.flw_lief_id AS in_lief_id,
 V01.werk_id,
 V01.flw_version_id,
 V01.menge,
 v02.pjwo,
 v02.pjwo_vw,
 V03.dat_aenderung,
 V100.default_wrg,
 V01.wrg_id,
 V01.bruttopreis,
 V01.nettopreis
FROM kfl_production_dbp_view.v_flw_art_lief_mpe_plan_per_2 AS V01
 INNER JOIN (SELECT V001.dat,
   V001.pjwo,
   V002.pjwo AS pjwo_vw
  FROM kfl_production_dbp_view.v_tag_2 AS V001
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS V002 ON DATE_SUB(V001.dat, INTERVAL 7 DAY) = V002.dat AND V001.dat <=
     DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY)
  GROUP BY V001.dat,
   V001.pjwo,
   pjwo_vw) AS v02 ON v02.dat BETWEEN V01.dat_von AND V01.dat_bis
 INNER JOIN kfl_production_dbp_view.v_flw_art_marktpreis_per_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.flw_art_id
       = V03.flw_art_id AND V01.werk_id = V03.werk_id AND V01.flw_version_id = V03.flw_version_id AND V01.dat_von = V03
   .dat_von
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id;