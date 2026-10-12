CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_gewerk_spr_zu (mandant_id, gewerk_id, gewerk_bez, gewerk_bez_de
, gewerk_bez_cz, gewerk_bez_sk, gewerk_bez_hr, gewerk_bez_pl, gewerk_bez_ro, gewerk_bez_bg) AS SELECT mandant_id,
 gewerk_id,
  CASE
  WHEN gewerk_id < 8
  THEN COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN gewerk_bez
     ELSE NULL
     END), 'N/A')
  WHEN gewerk_id = 8
  THEN 'Baukostenzuschüsse'
  WHEN gewerk_id = 9
  THEN 'Förderungen'
  ELSE NULL
  END AS gewerk_bez,
  CASE
  WHEN gewerk_id < 8
  THEN COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN gewerk_bez
     ELSE NULL
     END), 'N/A')
  WHEN gewerk_id = 8
  THEN 'Baukostenzuschüsse'
  WHEN gewerk_id = 9
  THEN 'Förderungen'
  ELSE NULL
  END AS gewerk_bez_de,
  CASE
  WHEN gewerk_id < 8
  THEN COALESCE(MAX(CASE
     WHEN spr_id = 124
     THEN gewerk_bez
     ELSE NULL
     END), CASE
    WHEN gewerk_id < 8
    THEN COALESCE(MAX(CASE
       WHEN spr_id = 22
       THEN gewerk_bez
       ELSE NULL
       END), 'N/A')
    WHEN gewerk_id = 8
    THEN 'Baukostenzuschüsse'
    WHEN gewerk_id = 9
    THEN 'Förderungen'
    ELSE NULL
    END)
  WHEN gewerk_id = 8
  THEN 'Baukostenzuschüsse'
  WHEN gewerk_id = 9
  THEN 'Förderungen'
  ELSE NULL
  END AS gewerk_bez_cz,
  CASE
  WHEN gewerk_id < 8
  THEN COALESCE(MAX(CASE
     WHEN spr_id = 108
     THEN gewerk_bez
     ELSE NULL
     END), CASE
    WHEN gewerk_id < 8
    THEN COALESCE(MAX(CASE
       WHEN spr_id = 22
       THEN gewerk_bez
       ELSE NULL
       END), 'N/A')
    WHEN gewerk_id = 8
    THEN 'Baukostenzuschüsse'
    WHEN gewerk_id = 9
    THEN 'Förderungen'
    ELSE NULL
    END)
  WHEN gewerk_id = 8
  THEN 'Baukostenzuschüsse'
  WHEN gewerk_id = 9
  THEN 'Förderungen'
  ELSE NULL
  END AS gewerk_bez_sk,
  CASE
  WHEN gewerk_id < 8
  THEN COALESCE(MAX(CASE
     WHEN spr_id = 65
     THEN gewerk_bez
     ELSE NULL
     END), CASE
    WHEN gewerk_id < 8
    THEN COALESCE(MAX(CASE
       WHEN spr_id = 22
       THEN gewerk_bez
       ELSE NULL
       END), 'N/A')
    WHEN gewerk_id = 8
    THEN 'Baukostenzuschüsse'
    WHEN gewerk_id = 9
    THEN 'Förderungen'
    ELSE NULL
    END)
  WHEN gewerk_id = 8
  THEN 'Baukostenzuschüsse'
  WHEN gewerk_id = 9
  THEN 'Förderungen'
  ELSE NULL
  END AS gewerk_bez_hr,
  CASE
  WHEN gewerk_id < 8
  THEN COALESCE(MAX(CASE
     WHEN spr_id = 90
     THEN gewerk_bez
     ELSE NULL
     END), CASE
    WHEN gewerk_id < 8
    THEN COALESCE(MAX(CASE
       WHEN spr_id = 22
       THEN gewerk_bez
       ELSE NULL
       END), 'N/A')
    WHEN gewerk_id = 8
    THEN 'Baukostenzuschüsse'
    WHEN gewerk_id = 9
    THEN 'Förderungen'
    ELSE NULL
    END)
  WHEN gewerk_id = 8
  THEN 'Baukostenzuschüsse'
  WHEN gewerk_id = 9
  THEN 'Förderungen'
  ELSE NULL
  END AS gewerk_bez_pl,
  CASE
  WHEN gewerk_id < 8
  THEN COALESCE(MAX(CASE
     WHEN spr_id = 95
     THEN gewerk_bez
     ELSE NULL
     END), CASE
    WHEN gewerk_id < 8
    THEN COALESCE(MAX(CASE
       WHEN spr_id = 22
       THEN gewerk_bez
       ELSE NULL
       END), 'N/A')
    WHEN gewerk_id = 8
    THEN 'Baukostenzuschüsse'
    WHEN gewerk_id = 9
    THEN 'Förderungen'
    ELSE NULL
    END)
  WHEN gewerk_id = 8
  THEN 'Baukostenzuschüsse'
  WHEN gewerk_id = 9
  THEN 'Förderungen'
  ELSE NULL
  END AS gewerk_bez_ro,
  CASE
  WHEN gewerk_id < 8
  THEN COALESCE(MAX(CASE
     WHEN spr_id = 18
     THEN gewerk_bez
     ELSE NULL
     END), CASE
    WHEN gewerk_id < 8
    THEN COALESCE(MAX(CASE
       WHEN spr_id = 22
       THEN gewerk_bez
       ELSE NULL
       END), 'N/A')
    WHEN gewerk_id = 8
    THEN 'Baukostenzuschüsse'
    WHEN gewerk_id = 9
    THEN 'Förderungen'
    ELSE NULL
    END)
  WHEN gewerk_id = 8
  THEN 'Baukostenzuschüsse'
  WHEN gewerk_id = 9
  THEN 'Förderungen'
  ELSE NULL
  END AS gewerk_bez_bg
FROM kfl_production_dbp_data.gewerk_spr_zu
GROUP BY mandant_id,
 gewerk_id;