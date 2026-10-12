CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wg_spr_zu AS SELECT DISTINCT arthiertyp_id,
  CASE
  WHEN wg_id = - 3
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE wg_id
  END AS wg_id,
 MAX(CASE
   WHEN wg_id = - 3
   THEN 'Alle (DIF)'
   WHEN spr_id = 22
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez,
 MAX(CASE
   WHEN wg_id = - 3
   THEN 'Alle (DIF)'
   WHEN spr_id = 22
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN wg_id = - 3
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END)) AS wg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN wg_id = - 3
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END)) AS wg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN wg_id = - 3
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END)) AS wg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN wg_id = - 3
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END)) AS wg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN wg_id = - 3
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END)) AS wg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN wg_id = - 3
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END)) AS wg_bez_bg
FROM kfl_production_dbp_view.v_wg_spr_zu AS V01
WHERE arthiertyp_id = 2
 AND wg_id >= - 3
GROUP BY arthiertyp_id,
 V01.wg_id;