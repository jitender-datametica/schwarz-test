CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_fipo_bewertung_spr_zu AS SELECT flag AS fipo_antwort_bwz,
 MAX(CASE
   WHEN spr_id = 22
   THEN flag_bez
   ELSE NULL
   END) AS fipo_antwort_bwz_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN flag_bez
   ELSE NULL
   END) AS fipo_antwort_bwz_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN flag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN flag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN flag_bez
    ELSE NULL
    END)
  END AS fipo_antwort_bwz_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN flag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN flag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN flag_bez
    ELSE NULL
    END)
  END AS fipo_antwort_bwz_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN flag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN flag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN flag_bez
    ELSE NULL
    END)
  END AS fipo_antwort_bwz_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN flag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN flag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN flag_bez
    ELSE NULL
    END)
  END AS fipo_antwort_bwz_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN flag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN flag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN flag_bez
    ELSE NULL
    END)
  END AS fipo_antwort_bwz_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN flag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN flag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN flag_bez
    ELSE NULL
    END)
  END AS fipo_antwort_bwz_bez_bg
FROM kfl_production_dbp_view.v_flag_spr_zu AS V01
WHERE flag_typ_id = 2
GROUP BY fipo_antwort_bwz
UNION DISTINCT
SELECT - 1 AS dm__operand0,
 '-' AS dm__operand1,
 '-' AS dm__operand2,
 '-' AS dm__operand3,
 '-' AS dm__operand4,
 '-' AS dm__operand5,
 '-' AS dm__operand6,
 '-' AS dm__operand7,
 '-' AS dm__operand8
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;