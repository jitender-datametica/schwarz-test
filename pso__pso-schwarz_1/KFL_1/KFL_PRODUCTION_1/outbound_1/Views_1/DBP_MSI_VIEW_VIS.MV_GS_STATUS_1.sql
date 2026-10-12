CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_status_1 AS SELECT mandant_id,
 transaktion_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN transaktion_bez
   ELSE NULL
   END) AS transaktion_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN transaktion_bez
   ELSE NULL
   END) AS transaktion_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN transaktion_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN transaktion_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN transaktion_bez
    ELSE NULL
    END)
  END AS transaktion_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN transaktion_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN transaktion_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN transaktion_bez
    ELSE NULL
    END)
  END AS transaktion_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN transaktion_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN transaktion_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN transaktion_bez
    ELSE NULL
    END)
  END AS transaktion_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN transaktion_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN transaktion_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN transaktion_bez
    ELSE NULL
    END)
  END AS transaktion_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN transaktion_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN transaktion_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN transaktion_bez
    ELSE NULL
    END)
  END AS transaktion_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN transaktion_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN transaktion_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN transaktion_bez
    ELSE NULL
    END)
  END AS transaktion_bez_bg
FROM kfl_production_dbp_view.v_transaktion_spr_zu_1 AS V01
WHERE mandant_id <> 1
 OR transaktion_id <> 18
GROUP BY mandant_id,
 transaktion_id;