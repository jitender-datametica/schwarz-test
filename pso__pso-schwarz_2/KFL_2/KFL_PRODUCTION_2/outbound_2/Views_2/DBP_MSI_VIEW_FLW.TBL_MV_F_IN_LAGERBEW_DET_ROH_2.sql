CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_in_lagerbew_det_roh_2 (mandant_id, werk_id, dat_buch,
wrg_id_org, best_beleg_id, in_art_id, wrg_id, preis_steuer_kz, default_wrg, betrag_lagerbew, betrag_lagerbew_altnv) AS
SELECT v02.mandant_id,
 v02.werk_id,
 v04.dat_buch,
 v04.wrg_id AS wrg_id_org,
 v02.best_beleg_id,
 v02.flw_art_id AS in_art_id,
 v02.wrg_id,
 V06.preis_steuer_kz,
 V100.default_wrg,
 v04.betrag_lagerbew,
 v04.betrag_lagerbew_altnv
FROM (SELECT mandant_id,
   flw_art_id,
   wrg_id,
   best_beleg_id,
   werk_id
  FROM kfl_production_dbp_view.v_flw_lagerbew_det_2
  WHERE lager_bewart_id IN ('643')
   AND mandant_id IN (1, 2)
  GROUP BY mandant_id,
   flw_art_id,
   wrg_id,
   werk_id,
   best_beleg_id) AS v02
 INNER JOIN (SELECT V04A.mandant_id,
   V04A.best_beleg_id,
   V04A.wrg_id,
   V04A.flw_art_id,
   V04A.flw_lief_id,
   V04A.werk_id,
   V03.dat_buch,
   SUM(V04A.betrag_lagerbew_altnv) AS betrag_lagerbew_altnv,
   SUM(V04A.betrag_lagerbew) AS betrag_lagerbew
  FROM kfl_production_dbp_view.v_flw_lagerbew_det_2 AS V04A
   INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_2 AS V03 ON V04A.mandant_id = V03.mandant_id AND V04A.lagerbew_beleg_id
       = V03.lagerbew_beleg_id AND V04A.kj = V03.kj
  WHERE V04A.lager_bewart_id IN ('101', '102')
   AND V04A.mandant_id IN (1, 2)
  GROUP BY V04A.mandant_id,
   V04A.flw_art_id,
   V04A.flw_lief_id,
   V04A.wrg_id,
   V04A.werk_id,
   V04A.best_beleg_id,
   V03.dat_buch) AS v04 ON v02.mandant_id = v04.mandant_id AND v02.best_beleg_id = v04.best_beleg_id AND v02.flw_art_id
   = v04.flw_art_id
 INNER JOIN kfl_production_dbp_view.v_flw_lieferant_2 AS V05A ON v04.mandant_id = V05A.mandant_id AND v04.flw_lief_id =
   V05A.flw_lief_id
 INNER JOIN kfl_production_dbp_view.v_flw_werk_2 AS V05B ON v04.mandant_id = V05B.mandant_id AND v04.werk_id = V05B.werk_id
   
 INNER JOIN kfl_production_dbp_view.v_flw_art_bewertungskreis_per_2 AS V06 ON v02.mandant_id = V06.mandant_id AND v02.flw_art_id
      = V06.flw_art_id AND v04.dat_buch BETWEEN V06.dat_von AND V06.dat_bis AND V05B.werk_nr = V06.bewertungskreis_id
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON v02.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_art_2 AS V07 ON v02.mandant_id = V07.mandant_id AND v02.flw_art_id = V07.flw_art_id
   
WHERE V07.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW',
   'ZFLV')
 AND COLLATE(LTRIM(COLLATE(V05A.flw_lief_nr, ''), '0'), 'und:ci') IN ('834590', '124425', '237400', '835192', '337028',
   '10258', '10259', '10753', '10083478', '10092461', '10093675', '10120130');