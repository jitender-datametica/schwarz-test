CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artikeltyp_spr_zu_1 (mandant_id, artikeltyp_id,
artikeltyp_bez, artikeltyp_bez_de, artikeltyp_bez_cz, artikeltyp_bez_sk, artikeltyp_bez_hr, artikeltyp_bez_pl,
artikeltyp_bez_ro, artikeltyp_bez_bg) AS SELECT mandant_id,
 artikeltyp_id,
 COALESCE(a0, 'N/A') AS artikeltyp_bez,
 COALESCE(a0, 'N/A') AS artikeltyp_bez_de,
 COALESCE(a0_0, COALESCE(a0, 'N/A')) AS artikeltyp_bez_cz,
 COALESCE(a0_1, COALESCE(a0, 'N/A')) AS artikeltyp_bez_sk,
 COALESCE(a0_2, COALESCE(a0, 'N/A')) AS artikeltyp_bez_hr,
 COALESCE(a0_3, COALESCE(a0, 'N/A')) AS artikeltyp_bez_pl,
 COALESCE(a0_4, COALESCE(a0, 'N/A')) AS artikeltyp_bez_ro,
 COALESCE(a0_5, COALESCE(a0, 'N/A')) AS artikeltyp_bez_bg
FROM (SELECT mandant_id,
   artikeltyp_id,
   artikeltyp_bez,
   MAX(CASE
     WHEN spr_id = 22
     THEN artikeltyp_bez
     ELSE NULL
     END) AS a0,
   MAX(CASE
     WHEN spr_id = 124
     THEN artikeltyp_bez
     ELSE NULL
     END) AS a0_0,
   MAX(CASE
     WHEN spr_id = 108
     THEN artikeltyp_bez
     ELSE NULL
     END) AS a0_1,
   MAX(CASE
     WHEN spr_id = 65
     THEN artikeltyp_bez
     ELSE NULL
     END) AS a0_2,
   MAX(CASE
     WHEN spr_id = 90
     THEN artikeltyp_bez
     ELSE NULL
     END) AS a0_3,
   MAX(CASE
     WHEN spr_id = 95
     THEN artikeltyp_bez
     ELSE NULL
     END) AS a0_4,
   MAX(CASE
     WHEN spr_id = 18
     THEN artikeltyp_bez
     ELSE NULL
     END) AS a0_5
  FROM kfl_production_dbp_view.v_artikeltyp_spr_zu_1 AS V01
  WHERE mandant_id <> 1
  GROUP BY mandant_id,
   artikeltyp_id,
   artikeltyp_bez) AS t1_1;