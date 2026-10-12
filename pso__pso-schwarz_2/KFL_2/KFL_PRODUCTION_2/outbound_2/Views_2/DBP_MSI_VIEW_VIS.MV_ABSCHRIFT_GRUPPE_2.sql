CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abschrift_gruppe_2 AS SELECT mandant_id,
 abschriftgruppe_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschriftgrp_bez
   ELSE NULL
   END) AS abschriftgrp_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschriftgrp_bez
   ELSE NULL
   END) AS abschriftgrp_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN abschriftgrp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftgrp_bez
    ELSE NULL
    END)) AS abschriftgrp_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN abschriftgrp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftgrp_bez
    ELSE NULL
    END)) AS abschriftgrp_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN abschriftgrp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftgrp_bez
    ELSE NULL
    END)) AS abschriftgrp_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN abschriftgrp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftgrp_bez
    ELSE NULL
    END)) AS abschriftgrp_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN abschriftgrp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftgrp_bez
    ELSE NULL
    END)) AS abschriftgrp_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN abschriftgrp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftgrp_bez
    ELSE NULL
    END)) AS abschriftgrp_bez_bg
FROM kfl_production_dbp_view.v_abschrift_gruppe_spr_zu_2 AS V01
GROUP BY mandant_id,
 abschriftgruppe_id;