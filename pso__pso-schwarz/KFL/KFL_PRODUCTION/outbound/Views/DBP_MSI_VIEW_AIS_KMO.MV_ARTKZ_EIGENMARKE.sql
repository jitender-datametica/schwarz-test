CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artkz_eigenmarke (mandant_id, eigenmarke_id,
eigenmarke_bez, eigenmarke_bez_de, eigenmarke_bez_cz, eigenmarke_bez_sk, eigenmarke_bez_hr, eigenmarke_bez_pl,
eigenmarke_bez_ro, eigenmarke_bez_bg) AS SELECT mandant_id,
 eigenmarke_id,
  CASE
  WHEN eigenmarke_id NOT IN ('S')
  THEN TRIM(COALESCE(a0, 'N/A'))
  ELSE 'SPIRITUOSEN;BIER'
  END AS eigenmarke_bez,
  CASE
  WHEN eigenmarke_id NOT IN ('S')
  THEN TRIM(COALESCE(a0, 'N/A'))
  ELSE 'SPIRITUOSEN;BIER'
  END AS eigenmarke_bez_de,
  CASE
  WHEN eigenmarke_id NOT IN ('S')
  THEN TRIM(COALESCE(a0_0, CASE
     WHEN eigenmarke_id NOT IN ('S')
     THEN TRIM(COALESCE(a0, 'N/A'))
     ELSE 'SPIRITUOSEN;BIER'
     END))
  ELSE 'SPIRITUOSEN;BIER'
  END AS eigenmarke_bez_cz,
  CASE
  WHEN eigenmarke_id NOT IN ('S')
  THEN TRIM(COALESCE(a0_1, CASE
     WHEN eigenmarke_id NOT IN ('S')
     THEN TRIM(COALESCE(a0, 'N/A'))
     ELSE 'SPIRITUOSEN;BIER'
     END))
  ELSE 'SPIRITUOSEN;BIER'
  END AS eigenmarke_bez_sk,
  CASE
  WHEN eigenmarke_id NOT IN ('S')
  THEN TRIM(COALESCE(a0_2, CASE
     WHEN eigenmarke_id NOT IN ('S')
     THEN TRIM(COALESCE(a0, 'N/A'))
     ELSE 'SPIRITUOSEN;BIER'
     END))
  ELSE 'SPIRITUOSEN;BIER'
  END AS eigenmarke_bez_hr,
  CASE
  WHEN eigenmarke_id NOT IN ('S')
  THEN TRIM(COALESCE(a0_3, CASE
     WHEN eigenmarke_id NOT IN ('S')
     THEN TRIM(COALESCE(a0, 'N/A'))
     ELSE 'SPIRITUOSEN;BIER'
     END))
  ELSE 'SPIRITUOSEN;BIER'
  END AS eigenmarke_bez_pl,
  CASE
  WHEN eigenmarke_id NOT IN ('S')
  THEN TRIM(COALESCE(a0_4, CASE
     WHEN eigenmarke_id NOT IN ('S')
     THEN TRIM(COALESCE(a0, 'N/A'))
     ELSE 'SPIRITUOSEN;BIER'
     END))
  ELSE 'SPIRITUOSEN;BIER'
  END AS eigenmarke_bez_ro,
  CASE
  WHEN eigenmarke_id NOT IN ('S')
  THEN TRIM(COALESCE(a0_5, CASE
     WHEN eigenmarke_id NOT IN ('S')
     THEN TRIM(COALESCE(a0, 'N/A'))
     ELSE 'SPIRITUOSEN;BIER'
     END))
  ELSE 'SPIRITUOSEN;BIER'
  END AS eigenmarke_bez_bg
FROM (SELECT mandant_id,
   eigenmarke_id,
   eigenmarke_bez,
   MAX(CASE
     WHEN spr_id = 22
     THEN eigenmarke_bez
     ELSE NULL
     END) AS a0,
   MAX(CASE
     WHEN spr_id = 124
     THEN eigenmarke_bez
     ELSE NULL
     END) AS a0_0,
   MAX(CASE
     WHEN spr_id = 108
     THEN eigenmarke_bez
     ELSE NULL
     END) AS a0_1,
   MAX(CASE
     WHEN spr_id = 65
     THEN eigenmarke_bez
     ELSE NULL
     END) AS a0_2,
   MAX(CASE
     WHEN spr_id = 90
     THEN eigenmarke_bez
     ELSE NULL
     END) AS a0_3,
   MAX(CASE
     WHEN spr_id = 95
     THEN eigenmarke_bez
     ELSE NULL
     END) AS a0_4,
   MAX(CASE
     WHEN spr_id = 18
     THEN eigenmarke_bez
     ELSE NULL
     END) AS a0_5
  FROM kfl_production_dbp_view.v_artkz_eigenmarke AS V01
  WHERE mandant_id <> 1
  GROUP BY mandant_id,
   eigenmarke_id,
   eigenmarke_bez) AS t1;