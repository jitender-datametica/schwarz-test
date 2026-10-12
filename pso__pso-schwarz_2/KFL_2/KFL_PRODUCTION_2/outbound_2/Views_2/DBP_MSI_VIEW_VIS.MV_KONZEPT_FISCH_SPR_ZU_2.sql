CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_konzept_fisch_spr_zu_2 AS SELECT T01.rpm_feld_auspr_id AS
 bed_fisch_id,
 MAX(CASE
   WHEN T01.spr_id = 22
   THEN T01.rpm_feld_auspr_bez
   ELSE NULL
   END) AS bed_fisch_bez,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 124
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS bed_fisch_bez_cz,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 108
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS bed_fisch_bez_sk,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 65
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS bed_fisch_bez_hr,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 90
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS bed_fisch_bez_pl,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 95
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS bed_fisch_bez_ro,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 18
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.rpm_feld_auspr_bez
    ELSE NULL
    END)) AS bed_fisch_bez_bg,
 MAX(CASE
   WHEN T01.spr_id = 22
   THEN T01.rpm_feld_auspr_bez
   ELSE NULL
   END) AS bed_fisch_bez_de
FROM kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_2 AS T01
 INNER JOIN kfl_production_dbp_view.v_l_rpm_feld_2 AS T02 ON T01.rpm_feld_id = T02.rpm_feld_id
WHERE T02.rpm_feld_bez = 'ZPPM_FISCH'
 AND T01.rpm_tab_id = 3
GROUP BY bed_fisch_id;