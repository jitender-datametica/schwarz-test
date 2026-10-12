CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_kond_1 (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  mo_intreno STRING(20),
  wrg_id STRING(12),
  wrg_hilf STRING(3),
  wrg_typ_id BIGNUMERIC(38, 0),
  dat_mo_gueltig_von DATE,
  dat_mo_gueltig_bis DATE,
  miete_per_anno3040 BIGNUMERIC(38, 0),
  miete_per_anno6200 BIGNUMERIC(38, 0),
  miete_per_anno3120_3240 BIGNUMERIC(38, 0),
  investmiete BIGNUMERIC(38, 0),
  umsatzmiete BIGNUMERIC(38, 0),
  grund_miete BIGNUMERIC(38, 0)
) AS
SELECT
  a.mandant_id,
  a.mv_intreno,
  a.mo_intreno,
  v3.wrg_id,
  a.wrg_id AS wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno3040,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno6200,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno3120_3240,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '1050'
            OR a.konditionsart_id = '3030'
            OR a.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '1050'
            OR a.konditionsart_id = '3030'
            OR a.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '1050'
            OR a.konditionsart_id = '3030'
            OR a.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '1050'
            OR a.konditionsart_id = '3030'
            OR a.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS investmiete,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '6000' OR a.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '6000' OR a.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '6000' OR a.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '6000' OR a.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS umsatzmiete,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND a.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND a.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v9.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND a.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND a.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS grund_miete
FROM kfl_production_dbp_view.v_immo_mietvertrag_kondition_per_1 AS a
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v3
  ON a.mandant_id = v3.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt_1 AS v4
  ON a.mo_intreno = v4.mo_intreno AND a.mandant_id = v4.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v8
  ON v8.wrg_typ_id = 0 AND a.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v9
  ON v9.wrg_typ_id = 1 AND a.mandant_id = v9.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mo_status_historie_1 AS v5
  ON a.mandant_id = v5.mandant_id
  AND a.mv_intreno = v5.mv_intreno
  AND a.mo_intreno = v5.mo_intreno
WHERE
  CURRENT_DATE <= a.dat_bis
  AND CAST(a.konditionsart_id AS INT64) IN (
    3040,
    6200,
    3030,
    8050,
    1050,
    3120,
    3240,
    6000,
    3000,
    6100,
    8000,
    8003,
    8200,
    8210,
    8220,
    8230
  )
  AND v3.wrg_typ_id = 1
  AND NOT v5.mo_status_id IN (0, 6)
GROUP BY
  a.mandant_id,
  a.mv_intreno,
  a.mo_intreno,
  v3.wrg_id,
  wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis
UNION ALL
SELECT
  a.mandant_id,
  a.mv_intreno,
  a.mo_intreno,
  v3.wrg_id,
  a.wrg_id AS wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno3040,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno6200,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS INT64) IN (3120, 3240)
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno3120_3240,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '1050'
            OR a.konditionsart_id = '3030'
            OR a.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '1050'
            OR a.konditionsart_id = '3030'
            OR a.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '1050'
            OR a.konditionsart_id = '3030'
            OR a.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '1050'
            OR a.konditionsart_id = '3030'
            OR a.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS investmiete,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '6000' OR a.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '6000' OR a.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '6000' OR a.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            a.konditionsart_id = '6000' OR a.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= a.dat_bis
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS umsatzmiete,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND a.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND a.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND a.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE >= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(a.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND a.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE <= a.dat_von
          THEN ROUND(a.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS grund_miete
FROM kfl_production_dbp_view.v_immo_mietvertrag_kondition_per_1 AS a
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v3
  ON a.mandant_id = v3.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt_1 AS v4
  ON a.mo_intreno = v4.mo_intreno AND a.mandant_id = v4.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v8
  ON v8.wrg_typ_id = 1 AND a.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mo_status_historie_1 AS v5
  ON a.mandant_id = v5.mandant_id
  AND a.mv_intreno = v5.mv_intreno
  AND a.mo_intreno = v5.mo_intreno
WHERE
  CURRENT_DATE <= a.dat_bis
  AND CAST(a.konditionsart_id AS INT64) IN (
    3040,
    6200,
    3030,
    8050,
    1050,
    3120,
    3240,
    6000,
    3000,
    6100,
    8000,
    8003,
    8200,
    8210,
    8220,
    8230
  )
  AND v3.wrg_typ_id = 0
  AND NOT v5.mo_status_id IN (0, 6)
GROUP BY
  a.mandant_id,
  a.mv_intreno,
  a.mo_intreno,
  v3.wrg_id,
  wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis
UNION ALL
SELECT
  v6.mandant_id,
  v5.mv_intreno,
  v6.mo_intreno,
  v3.wrg_id,
  v6.wrg_id AS wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno3040,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno6200,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno3120_3240,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '1050'
            OR v6.konditionsart_id = '3030'
            OR v6.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '1050'
            OR v6.konditionsart_id = '3030'
            OR v6.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '1050'
            OR v6.konditionsart_id = '3030'
            OR v6.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '1050'
            OR v6.konditionsart_id = '3030'
            OR v6.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS investmiete,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '6000' OR v6.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '6000' OR v6.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '6000' OR v6.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '6000' OR v6.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS umsatzmiete,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND v6.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND v6.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND v6.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND v6.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS grund_miete
FROM kfl_production_dbp_view.v_immo_mietobjekt_kondition_per_1 AS v6
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt_1 AS v4
  ON v6.mo_intreno = v4.mo_intreno AND v6.mandant_id = v4.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v3
  ON v6.mandant_id = v3.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v8
  ON v8.wrg_typ_id = 1 AND v6.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mo_status_historie_1 AS v5
  ON v4.mandant_id = v5.mandant_id AND v4.mo_intreno = v5.mo_intreno
WHERE
  CAST(v6.konditionsart_id AS INT64) IN (
    3040,
    6200,
    3030,
    8050,
    1050,
    3120,
    3240,
    6000,
    3000,
    6100,
    8000,
    8003,
    8200,
    8210,
    8220,
    8230
  )
  AND v3.wrg_typ_id = 0
  AND v5.mo_status_id IN (0, 6)
  AND CURRENT_DATE <= v6.dat_bis
GROUP BY
  v6.mandant_id,
  v5.mv_intreno,
  v6.mo_intreno,
  v3.wrg_id,
  wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis
UNION ALL
SELECT
  v6.mandant_id AS mandant_id,
  v5.mv_intreno AS mv_intreno,
  v6.mo_intreno AS mo_intreno,
  v3.wrg_id AS wrg_id,
  v6.wrg_id AS wrg_hilf,
  v3.wrg_typ_id AS wrg_typ_id,
  v4.dat_mo_gueltig_von AS dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis AS dat_mo_gueltig_bis,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 3040
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno3040,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) = 6200
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno6200,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3120, 3240)
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS miete_per_anno3120_3240,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '1050'
            OR v6.konditionsart_id = '3030'
            OR v6.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '1050'
            OR v6.konditionsart_id = '3030'
            OR v6.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '1050'
            OR v6.konditionsart_id = '3030'
            OR v6.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '1050'
            OR v6.konditionsart_id = '3030'
            OR v6.konditionsart_id = '8050'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS investmiete,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '6000' OR v6.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '6000' OR v6.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '6000' OR v6.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN (
            v6.konditionsart_id = '6000' OR v6.konditionsart_id = '6200'
          )
          AND CURRENT_DATE <= v6.dat_bis
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS umsatzmiete,
  CASE
    WHEN v6.wrg_id = 'EUR' AND NOT v6.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND v6.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE >= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND v6.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE <= v6.dat_von
          THEN v6.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND v6.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE >= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CAST(v6.konditionsart_id AS FLOAT64) IN (3000, 6100, 8000, 8003, 8200, 8210, 8220, 8230)
          AND v6.dat_bis >= CURRENT_DATE
          AND CURRENT_DATE <= v6.dat_von
          THEN ROUND(v6.miete_per_anno / v3.umrechnungskurs)
          ELSE 0
        END
      )
    )
  END AS grund_miete
FROM kfl_production_dbp_view.v_immo_mietobjekt_kondition_per_1 AS v6
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt_1 AS v4
  ON v6.mo_intreno = v4.mo_intreno AND v6.mandant_id = v4.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v3
  ON v6.mandant_id = v3.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v8
  ON v8.wrg_typ_id = 0 AND v6.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mo_status_historie_1 AS v5
  ON v4.mandant_id = v5.mandant_id AND v4.mo_intreno = v5.mo_intreno
WHERE
  CAST(v6.konditionsart_id AS INT64) IN (
    3040,
    6200,
    3030,
    8050,
    1050,
    3120,
    3240,
    6000,
    3000,
    6100,
    8000,
    8003,
    8200,
    8210,
    8220,
    8230
  )
  AND v3.wrg_typ_id = 1
  AND v5.mo_status_id IN (0, 6)
  AND CURRENT_DATE <= v6.dat_bis
GROUP BY
  v6.mandant_id,
  v5.mv_intreno,
  v6.mo_intreno,
  v3.wrg_id,
  wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis;
