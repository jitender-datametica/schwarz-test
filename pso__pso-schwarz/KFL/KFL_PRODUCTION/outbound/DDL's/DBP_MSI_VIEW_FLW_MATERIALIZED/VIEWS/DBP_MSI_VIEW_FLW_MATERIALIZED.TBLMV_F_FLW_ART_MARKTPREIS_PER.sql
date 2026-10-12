CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.tblmv_f_flw_art_marktpreis_per (mandant_id,
in_art_id, werk_id, flw_version_id, menge, nicht_relevant_fg, pjwo, pjwo_vw, default_wrg, wrg_id, bruttopreis,
dat_aenderung) AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
 V01.flw_version_id,
 V01.menge,
 V01.nicht_relevant_fg,
 v02.pjwo,
 v02.pjwo_vw,
 V100.default_wrg,
 V01.wrg_id,
 V01.bruttopreis,
 V01.dat_aenderung
FROM kfl_production_dbp_view.v_flw_art_marktpreis_per AS V01
 INNER JOIN (SELECT V001.dat,
   V001.pjwo,
   V001.wtag_id,
   V002.pjwo AS pjwo_vw
  FROM kfl_production_dbp_view.v_tag AS V001
   INNER JOIN kfl_production_dbp_view.v_tag AS V002 ON DATE_SUB(V001.dat, INTERVAL 7 DAY) = V002.dat AND V001.dat <=
     DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY)
  GROUP BY V001.dat,
   V001.pjwo,
   V001.wtag_id,
   pjwo_vw) AS v02 ON V01.dat_von = v02.dat AND v02.wtag_id = 6
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id;