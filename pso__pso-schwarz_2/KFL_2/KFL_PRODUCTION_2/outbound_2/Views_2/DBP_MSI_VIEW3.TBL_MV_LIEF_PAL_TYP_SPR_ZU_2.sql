CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_lief_pal_typ_spr_zu_2 AS SELECT lief_pal_typ_bez,
 lief_pal_typ_id,
 mandant_id,
 spr_id
FROM ((SELECT lief_pal_typ_bez,
     ROUND(SAFE_CAST(lief_pal_typ_id AS BIGNUMERIC), 0) AS lief_pal_typ_id,
     mandant_id,
     spr_id
    FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_2
    UNION DISTINCT
    SELECT 'Mix on GP_2 - GP_2 Anteil' AS lief_pal_typ_bez,
     61 AS lief_pal_typ_id,
     mandant_id,
     spr_id
    FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_2)
   UNION DISTINCT
   SELECT 'Mix on GP_2 - MP Anteil' AS lief_pal_typ_bez,
    64 AS lief_pal_typ_id,
    mandant_id,
    spr_id
   FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_2) AS v01;