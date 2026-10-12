CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_block_wb_en_2 (mandant_id, muki_block_wb_id,
muki_block_wb_kl_id, muki_block_wb_bez, muki_block_kz_wb_id) AS SELECT V01.mandant_id,
 V01.art_id AS muki_block_wb_id,
 V01.kl_art_id AS muki_block_wb_kl_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.art_bez
    ELSE NULL
    END)) AS muki_block_wb_bez,
  CASE
  WHEN V01.mutter_wb_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_wb_id
FROM kfl_production_dbp_view.v_art_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
WHERE V02.spr_id IN (22, 24)
 AND (V01.mutter_wb_id IS NULL OR V01.mutter_wb_id = V01.art_id)
 AND V01.dat_bis = PARSE_DATE('%F', '9999-12-31')
GROUP BY V01.mandant_id,
 muki_block_wb_id,
 muki_block_wb_kl_id,
 muki_block_kz_wb_id;