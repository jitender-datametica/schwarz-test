CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_grund AS SELECT mandant_id,
 ausgeber_typ_id,
 ausgeber_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ausgeber_bez
   ELSE NULL
   END) AS ausgeber_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN ausgeber_bez
   ELSE NULL
   END) AS ausgeber_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ausgeber_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ausgeber_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ausgeber_bez
    ELSE NULL
    END)
  END AS ausgeber_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ausgeber_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ausgeber_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ausgeber_bez
    ELSE NULL
    END)
  END AS ausgeber_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ausgeber_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ausgeber_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ausgeber_bez
    ELSE NULL
    END)
  END AS ausgeber_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ausgeber_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ausgeber_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ausgeber_bez
    ELSE NULL
    END)
  END AS ausgeber_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ausgeber_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ausgeber_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ausgeber_bez
    ELSE NULL
    END)
  END AS ausgeber_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ausgeber_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ausgeber_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ausgeber_bez
    ELSE NULL
    END)
  END AS ausgeber_bez_bg
FROM kfl_production_dbp_view.v_ausgeber_spr_zu AS V01
GROUP BY mandant_id,
 ausgeber_typ_id,
 ausgeber_id
UNION ALL
SELECT mandant_id,
 ausgeber_typ_id,
 '0' AS ausgeber_id,
   'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez,
   'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_de,
   'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_cz,
   'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_pl,
   'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_sk,
   'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_hr,
   'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_ro,
   'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_bg
FROM kfl_production_dbp_view.v_ausgeber_typ_spr_zu AS V01
WHERE spr_id = 22;