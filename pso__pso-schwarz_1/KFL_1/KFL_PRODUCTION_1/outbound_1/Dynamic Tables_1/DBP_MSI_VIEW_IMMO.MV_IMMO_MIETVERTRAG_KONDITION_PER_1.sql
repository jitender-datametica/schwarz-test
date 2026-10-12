CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_kondition_per_1 (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  mo_intreno STRING(20),
  wrg_id STRING(12),
  wrg_hilf STRING(3),
  miete_per_anno_future BIGNUMERIC(38, 0),
  miete_per_anno_current BIGNUMERIC(38, 0),
  miete_per_anno_current1 BIGNUMERIC(38, 0),
  miete_per_anno_future1 BIGNUMERIC(38, 0),
  miete_per_anno BIGNUMERIC(38, 0)
) AS
SELECT
  a.mandant_id AS mandant_id,
  a.mv_intreno AS mv_intreno,
  a.mo_intreno AS mo_intreno,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN v8.wrg_id
    ELSE a.wrg_id
  END AS wrg_id,
  a.wrg_id AS wrg_hilf,
  SUM(CASE WHEN CURRENT_DATE < a.dat_von THEN a.miete_per_anno ELSE NULL END) AS miete_per_anno_future,
  SUM(CASE WHEN CURRENT_DATE >= a.dat_von THEN a.miete_per_anno ELSE NULL END) AS miete_per_anno_current,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN SUM(CASE WHEN CURRENT_DATE >= a.dat_von THEN a.miete_per_anno ELSE NULL END) * v9.umrechnungskurs
    ELSE SUM(CASE WHEN CURRENT_DATE >= a.dat_von THEN a.miete_per_anno ELSE NULL END)
  END AS miete_per_anno_current1,
  CASE
    WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
    THEN SUM(CASE WHEN CURRENT_DATE < a.dat_von THEN a.miete_per_anno ELSE NULL END) * v9.umrechnungskurs
    ELSE SUM(CASE WHEN CURRENT_DATE < a.dat_von THEN a.miete_per_anno ELSE NULL END)
  END AS miete_per_anno_future1,
  COALESCE(
    CASE
      WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
      THEN SUM(CASE WHEN CURRENT_DATE >= a.dat_von THEN a.miete_per_anno ELSE NULL END) * v9.umrechnungskurs
      ELSE SUM(CASE WHEN CURRENT_DATE >= a.dat_von THEN a.miete_per_anno ELSE NULL END)
    END,
    CASE
      WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
      THEN SUM(CASE WHEN CURRENT_DATE < a.dat_von THEN a.miete_per_anno ELSE NULL END) * v9.umrechnungskurs
      ELSE SUM(CASE WHEN CURRENT_DATE < a.dat_von THEN a.miete_per_anno ELSE NULL END)
    END
  ) AS miete_per_anno
FROM kfl_production_dbp_view.v_immo_mietvertrag_kondition_per_1 AS a
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v8
  ON v8.wrg_typ_id = 1 AND a.mandant_id = v8.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v9
  ON v9.wrg_typ_id = 0 AND a.mandant_id = v9.mandant_id
WHERE
  CURRENT_DATE <= a.dat_bis
  AND a.konditionsart_id IN ('3000', '6100', '8000', '8003', '8200', '8210', '8220', '8230')
GROUP BY
  a.mandant_id,
  a.mv_intreno,
  a.mo_intreno,
  wrg_id,
  wrg_hilf,
  v9.umrechnungskurs;
