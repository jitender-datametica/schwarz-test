CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_kond_nk (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  mo_intreno STRING(20),
  wrg_id STRING(12),
  wrg_hilf STRING(3),
  wrg_typ_id BIGNUMERIC(38, 0),
  dat_mo_gueltig_von DATE,
  dat_mo_gueltig_bis DATE,
  miete_per_anno BIGNUMERIC(38, 0),
  miete_per_anno_future BIGNUMERIC(38, 0)
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
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE >= a.dat_von
          THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
          THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
          ELSE 0
        END
      )
    )
  END AS miete_per_anno,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN SUM(
      CASE
        WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
        THEN a.miete_per_anno * v8.umrechnungskurs
        ELSE 0
      END
    )
    ELSE SUM(
      CASE
        WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
        THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
        ELSE 0
      END
    )
  END AS miete_per_anno_future
FROM kfl_production_dbp_view.v_immo_mietvertrag_kondition_per AS a
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v3
  ON a.mandant_id = v3.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt AS v4
  ON a.mo_intreno = v4.mo_intreno AND a.mandant_id = v4.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8
  ON v8.wrg_typ_id = 0 AND a.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mo_status_historie AS v5
  ON a.mandant_id = v5.mandant_id
  AND a.mv_intreno = v5.mv_intreno
  AND a.mo_intreno = v5.mo_intreno
WHERE
  CURRENT_DATE <= a.dat_bis
  AND CAST(a.konditionsart_id AS INT64) IN (
    3500,
    3530,
    3540,
    3510,
    3790,
    3520,
    3550,
    3800,
    3810,
    3820,
    3830,
    3840,
    3850,
    3860,
    3870
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
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE >= a.dat_von
          THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
          THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
          ELSE 0
        END
      )
    )
  END AS miete_per_anno,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN SUM(
      CASE
        WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
        THEN a.miete_per_anno * v8.umrechnungskurs
        ELSE 0
      END
    )
    ELSE SUM(
      CASE
        WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
        THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
        ELSE 0
      END
    )
  END AS miete_per_anno_future
FROM kfl_production_dbp_view.v_immo_mietvertrag_kondition_per AS a
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v3
  ON a.mandant_id = v3.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt AS v4
  ON a.mo_intreno = v4.mo_intreno AND a.mandant_id = v4.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8
  ON v8.wrg_typ_id = 1 AND a.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mo_status_historie AS v5
  ON a.mandant_id = v5.mandant_id
  AND a.mv_intreno = v5.mv_intreno
  AND a.mo_intreno = v5.mo_intreno
WHERE
  CURRENT_DATE <= a.dat_bis
  AND CAST(a.konditionsart_id AS INT64) IN (
    3500,
    3530,
    3540,
    3510,
    3790,
    3520,
    3550,
    3800,
    3810,
    3820,
    3830,
    3840,
    3850,
    3860,
    3870
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
  a.mandant_id,
  v5.mv_intreno,
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
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE >= a.dat_von
          THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
          THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
          ELSE 0
        END
      )
    )
  END AS miete_per_anno,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN SUM(
      CASE
        WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
        THEN a.miete_per_anno * v8.umrechnungskurs
        ELSE 0
      END
    )
    ELSE SUM(
      CASE
        WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
        THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
        ELSE 0
      END
    )
  END AS miete_per_anno_future
FROM kfl_production_dbp_view.v_immo_mietobjekt_kondition_per AS a
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt AS v4
  ON a.mo_intreno = v4.mo_intreno AND a.mandant_id = v4.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v3
  ON a.mandant_id = v3.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8
  ON v8.wrg_typ_id = 1 AND a.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mo_status_historie AS v5
  ON a.mandant_id = v5.mandant_id AND a.mo_intreno = v5.mo_intreno
WHERE
  CURRENT_DATE <= a.dat_bis
  AND CAST(a.konditionsart_id AS INT64) IN (
    3500,
    3530,
    3540,
    3510,
    3790,
    3520,
    3550,
    3800,
    3810,
    3820,
    3830,
    3840,
    3850,
    3860,
    3870
  )
  AND v3.wrg_typ_id = 0
  AND v5.mo_status_id IN (0, 6)
GROUP BY
  a.mandant_id,
  v5.mv_intreno,
  a.mo_intreno,
  v3.wrg_id,
  wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis
UNION ALL
SELECT
  a.mandant_id AS mandant_id,
  v5.mv_intreno AS mv_intreno,
  a.mo_intreno AS mo_intreno,
  v3.wrg_id AS wrg_id,
  a.wrg_id AS wrg_hilf,
  v3.wrg_typ_id AS wrg_typ_id,
  v4.dat_mo_gueltig_von AS dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis AS dat_mo_gueltig_bis,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN COALESCE(
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE >= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
          THEN a.miete_per_anno * v8.umrechnungskurs
          ELSE 0
        END
      )
    )
    ELSE COALESCE(
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE >= a.dat_von
          THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
          ELSE NULL
        END
      ),
      SUM(
        CASE
          WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
          THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
          ELSE 0
        END
      )
    )
  END AS miete_per_anno,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN SUM(
      CASE
        WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
        THEN a.miete_per_anno * v8.umrechnungskurs
        ELSE 0
      END
    )
    ELSE SUM(
      CASE
        WHEN CURRENT_DATE <= a.dat_bis AND CURRENT_DATE <= a.dat_von
        THEN TRUNC(CAST(a.miete_per_anno / v3.umrechnungskurs AS BIGNUMERIC))
        ELSE 0
      END
    )
  END AS miete_per_anno_future
FROM kfl_production_dbp_view.v_immo_mietobjekt_kondition_per AS a
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mietobjekt AS v4
  ON a.mo_intreno = v4.mo_intreno AND a.mandant_id = v4.mandant_id
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v3
  ON a.mandant_id = v3.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8
  ON v8.wrg_typ_id = 0 AND a.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mo_status_historie AS v5
  ON a.mandant_id = v5.mandant_id AND a.mo_intreno = v5.mo_intreno
WHERE
  CURRENT_DATE <= a.dat_bis
  AND CAST(a.konditionsart_id AS INT64) IN (
    3500,
    3530,
    3540,
    3510,
    3790,
    3520,
    3550,
    3800,
    3810,
    3820,
    3830,
    3840,
    3850,
    3860,
    3870
  )
  AND v3.wrg_typ_id = 1
  AND v5.mo_status_id IN (0, 6)
GROUP BY
  a.mandant_id,
  v5.mv_intreno,
  a.mo_intreno,
  v3.wrg_id,
  wrg_hilf,
  v3.wrg_typ_id,
  v4.dat_mo_gueltig_von,
  v4.dat_mo_gueltig_bis;
