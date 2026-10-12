CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mietobjekt_kondition_per (
  mandant_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  wrg_id STRING(12),
  miete_per_anno BIGNUMERIC(37, 6)
) AS
SELECT
  t1.mandant_id AS mandant_id,
  t1.mo_intreno AS mo_intreno,
  t1.wrg_id AS wrg_id,
  CASE
    WHEN t1.wrg_id = 'EUR' AND NOT t1.mandant_id IN (1, 5)
    THEN t1.zwischensumme * t1.umrechnungskurs
    ELSE t1.zwischensumme
  END AS miete_per_anno
FROM (
  SELECT
    a.mandant_id,
    a.mo_intreno,
    CASE
      WHEN a.wrg_id = 'EUR' AND NOT a.mandant_id IN (1, 5)
      THEN v8.wrg_id
      ELSE a.wrg_id
    END AS wrg_id,
    v8.umrechnungskurs,
    SUM(a.miete_per_anno) AS zwischensumme
  FROM kfl_production_dbp_view.v_immo_mietobjekt_kondition_per AS a
  LEFT JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8
    ON v8.wrg_typ_id = 0 AND a.mandant_id = v8.mandant_id
  WHERE
    CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
    AND a.konditionsart_id IN ('3000', '6100', '8000', '8003', '8200', '8210', '8220', '8230')
  GROUP BY
    a.mandant_id,
    a.mo_intreno,
    wrg_id,
    v8.umrechnungskurs
) AS t1;
