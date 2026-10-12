CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_block_vk_1 (mandant_id, muki_block_vk_id,
muki_block_vk_kl_id_lang, muki_block_vk_kl_art_id, muki_block_vk_bez, muki_block_vk_bez_de, muki_block_vk_bez_cz,
muki_block_vk_bez_sk, muki_block_vk_bez_hr, muki_block_vk_bez_pl, muki_block_vk_bez_ro, muki_block_vk_bez_bg,
muki_block_kz_vk_id, muki_block_vk_id_sal) AS SELECT V01.mandant_id,
 V01.art_id AS muki_block_vk_id,
 LPAD(SUBSTR(CAST(V01.kl_art_id AS STRING), 1, 10), 8, '0') AS muki_block_vk_kl_id_lang,
 V01.kl_art_id AS muki_block_vk_kl_art_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.art_bez
    ELSE NULL
    END), 'N/A') AS muki_block_vk_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.art_bez
    ELSE NULL
    END), 'N/A') AS muki_block_vk_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.art_bez
     ELSE NULL
     END), 'N/A')) AS muki_block_vk_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.art_bez
     ELSE NULL
     END), 'N/A')) AS muki_block_vk_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.art_bez
     ELSE NULL
     END), 'N/A')) AS muki_block_vk_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.art_bez
     ELSE NULL
     END), 'N/A')) AS muki_block_vk_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.art_bez
     ELSE NULL
     END), 'N/A')) AS muki_block_vk_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.art_bez
     ELSE NULL
     END), 'N/A')) AS muki_block_vk_bez_bg,
  CASE
  WHEN V01.mutter_vk_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_vk_id,
  CASE
  WHEN CASE
    WHEN V01.mutter_vk_id IS NULL
    THEN 'W'
    ELSE 'M'
    END = 'M'
  THEN LPAD(SUBSTR(CAST(V01.kl_art_id AS STRING), 1, 10), 8, '0')
  ELSE ' '
  END AS muki_block_vk_id_sal
FROM kfl_production_dbp_view.v_art_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id <> 1
 AND (V01.mutter_vk_id IS NULL OR V01.mutter_vk_id = V01.art_id)
 AND V01.dat_bis = DATE '9999-12-31'
GROUP BY V01.mandant_id,
 muki_block_vk_id,
 muki_block_vk_kl_art_id,
 V01.mutter_vk_id;