CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_l_in_art_spr_zu_2 (mandant_id, in_art_id, spr_id, art_bez)
AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.spr_id,
 V01.art_bez
FROM kfl_production_dbp_view.v_flw_art_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_art_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02.flw_art_id
   
WHERE (V02.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW',
     'ZFLV') OR V01.flw_art_id = - 1)
 AND V01.mandant_id IN (1, 2)
UNION DISTINCT
SELECT V01.mandant_id,
  CASE
  WHEN V01.art_id < 0
  THEN V01.art_id * - 1 + 10000000
  ELSE V01.art_id * - 1
  END AS in_art_id,
 V01.spr_id,
 V01.art_bez
FROM kfl_production_dbp_view.v_art_spr_zu_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_art_2 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
   
WHERE V01.mandant_id IN (1, 2)
 AND V02.dat_bis = DATE '9999-12-31'
 AND V02.arthiertyp_id = 2
 AND V02.wg_id IN (3, 122, 128, 134, 135, 136, 137, 138, 139, 141, 142, 144, 145, 146, 147, 158, 159, 184, 186, 232, 233
   , 234, 235, 236, 237, 238, 239, 331, 242, 243, 244, 245, 246)
 AND V04.flw_art_id IS NULL;