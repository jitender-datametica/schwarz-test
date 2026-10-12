-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_prioritaet_spr_zu_2 (geku_prioritaet_id, geku_prioritaet_bez,
geku_prioritaet_bez_cz, geku_prioritaet_bez_pl, geku_prioritaet_bez_sk) AS SELECT geku_prioritaet_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN CASE
    WHEN geku_prioritaet_id = 0
    THEN
    ' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez   --standard=deutsch\n   , MAX(CASE WHEN v01.spr_id = 124 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '
    ELSE geku_prioritaet_bez
    END
   ELSE NULL
   END) AS geku_prioritaet_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN CASE
    WHEN geku_prioritaet_id = 0
    THEN
    ' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez_pl\n   , MAX(CASE WHEN v01.spr_id = 108 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '
    ELSE geku_prioritaet_bez
    END
   ELSE NULL
   END) AS geku_prioritaet_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN CASE
    WHEN geku_prioritaet_id = 0
    THEN
    ' ELSE geku_prioritaet_bez END) ELSE NULL END)  AS geku_prioritaet_bez_hr\n   , MAX(CASE WHEN v01.spr_id =   95 THEN (CASE WHEN geku_prioritaet_id = 0 THEN '
    ELSE geku_prioritaet_bez
    END
   ELSE NULL
   END) AS geku_prioritaet_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN CASE
    WHEN geku_prioritaet_id = 0
    THEN ''
    ELSE geku_prioritaet_bez
    END
   ELSE NULL
   END) AS geku_prioritaet_bez_bg
FROM kfl_production_dbp_view.v_geku_prioritaet_spr_zu_2 AS v01
GROUP BY geku_prioritaet_id;