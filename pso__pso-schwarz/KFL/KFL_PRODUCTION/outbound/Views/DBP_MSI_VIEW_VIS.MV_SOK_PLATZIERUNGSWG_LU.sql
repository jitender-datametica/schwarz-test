CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_platzierungswg_lu (mandant_id, sok_platzierungswg_id,
sok_platzierungswg_nr, sok_primaere_platzierungswg_nr, sok_primaere_relevant_fg, sok_mgg_gruppe_id, sok_kategorie_id,
sok_platzierungswg_bez_de, sok_platzierungswg_bez, sok_platzierungswg_bez_cz, sok_platzierungswg_bez_sk,
sok_platzierungswg_bez_hr, sok_platzierungswg_bez_pl, sok_platzierungswg_bez_ro, sok_platzierungswg_bez_bg) AS SELECT
 PWG.mandant_id,
 PWG.platzierungswg_id AS sok_platzierungswg_id,
 PWG.platzierungswg_nr AS sok_platzierungswg_nr,
 PWG.primaere_platzierungswg_nr AS sok_primaere_platzierungswg_nr,
 PWG.primaere_relevant_fg AS sok_primaere_relevant_fg,
 PWG.mgg_gruppe_id AS sok_mgg_gruppe_id,
 PWG.sok_kategorie_id,
 MAX(CASE
   WHEN PWGS.spr_id = 22
   THEN PWGS.platzierungswg_bez
   ELSE TRIM(SUBSTR(CAST(PWGS.platzierungswg_id AS STRING), 1, 39))
   END) AS sok_platzierungswg_bez_de,
 MAX(CASE
   WHEN PWGS.spr_id = 22
   THEN PWGS.platzierungswg_bez
   ELSE TRIM(SUBSTR(CAST(PWGS.platzierungswg_id AS STRING), 1, 39))
   END) AS sok_platzierungswg_bez,
 COALESCE(MAX(CASE
    WHEN PWGS.spr_id = 124
    THEN PWGS.platzierungswg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PWGS.spr_id = 22
    THEN PWGS.platzierungswg_bez
    ELSE TRIM(SUBSTR(CAST(PWGS.platzierungswg_id AS STRING), 1, 39))
    END)) AS sok_platzierungswg_bez_cz,
 COALESCE(MAX(CASE
    WHEN PWGS.spr_id = 108
    THEN PWGS.platzierungswg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PWGS.spr_id = 22
    THEN PWGS.platzierungswg_bez
    ELSE TRIM(SUBSTR(CAST(PWGS.platzierungswg_id AS STRING), 1, 39))
    END)) AS sok_platzierungswg_bez_sk,
 COALESCE(MAX(CASE
    WHEN PWGS.spr_id = 65
    THEN PWGS.platzierungswg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PWGS.spr_id = 22
    THEN PWGS.platzierungswg_bez
    ELSE TRIM(SUBSTR(CAST(PWGS.platzierungswg_id AS STRING), 1, 39))
    END)) AS sok_platzierungswg_bez_hr,
 COALESCE(MAX(CASE
    WHEN PWGS.spr_id = 90
    THEN PWGS.platzierungswg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PWGS.spr_id = 22
    THEN PWGS.platzierungswg_bez
    ELSE TRIM(SUBSTR(CAST(PWGS.platzierungswg_id AS STRING), 1, 39))
    END)) AS sok_platzierungswg_bez_pl,
 COALESCE(MAX(CASE
    WHEN PWGS.spr_id = 95
    THEN PWGS.platzierungswg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PWGS.spr_id = 22
    THEN PWGS.platzierungswg_bez
    ELSE TRIM(SUBSTR(CAST(PWGS.platzierungswg_id AS STRING), 1, 39))
    END)) AS sok_platzierungswg_bez_ro,
 COALESCE(MAX(CASE
    WHEN PWGS.spr_id = 18
    THEN PWGS.platzierungswg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PWGS.spr_id = 22
    THEN PWGS.platzierungswg_bez
    ELSE TRIM(SUBSTR(CAST(PWGS.platzierungswg_id AS STRING), 1, 39))
    END)) AS sok_platzierungswg_bez_bg
FROM kfl_production_dbp_view.v_l_platzierungswg AS PWG
 INNER JOIN kfl_production_dbp_view.v_platzierungswg_spr_zu AS PWGS ON PWG.mandant_id = PWGS.mandant_id AND PWG.platzierungswg_id
    = PWGS.platzierungswg_id
GROUP BY PWG.mandant_id,
 sok_platzierungswg_id,
 sok_platzierungswg_nr,
 sok_primaere_platzierungswg_nr,
 sok_primaere_relevant_fg,
 sok_mgg_gruppe_id,
 PWG.sok_kategorie_id;