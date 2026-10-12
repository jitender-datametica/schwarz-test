-- standard == DE
 -- HR
 -- PL
 -- DE
 -- CZ
 -- SK
 -- BG
 -- 2022.03.28, AP0124145_SPEC0149178, dknop, initial

-- RO
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_sperrgrund_spr_zu (sperrgrund_id, mandant_id
, sperrgrund_bez, sperrgrund_bez_de, sperrgrund_bez_cz, sperrgrund_bez_sk, sperrgrund_bez_hr, sperrgrund_bez_pl,
sperrgrund_bez_ro, sperrgrund_bez_bg) AS SELECT sperrgrund_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN sperrgrund_bez
   ELSE NULL
   END) AS sperrgrund_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN sperrgrund_bez
   ELSE NULL
   END) AS sperrgrund_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN sperrgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sperrgrund_bez
    ELSE NULL
    END)) AS sperrgrund_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN sperrgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sperrgrund_bez
    ELSE NULL
    END)) AS sperrgrund_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN sperrgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sperrgrund_bez
    ELSE NULL
    END)) AS sperrgrund_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN sperrgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sperrgrund_bez
    ELSE NULL
    END)) AS sperrgrund_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN sperrgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sperrgrund_bez
    ELSE NULL
    END)) AS sperrgrund_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN sperrgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sperrgrund_bez
    ELSE NULL
    END)) AS sperrgrund_bez_bg
FROM kfl_production_dbp_view.v_sperrgrund_spr_zu AS V01
GROUP BY sperrgrund_id,
 mandant_id;