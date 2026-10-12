CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_mo_status_historie (
  mandant_id BIGNUMERIC(38, 0),
  mo_status_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  mv_intreno STRING(20),
  dat_status_von DATE,
  dat_status_bis DATE,
  mo_status_vormonat_id STRING(1),
  mo_typ_id BIGNUMERIC(38, 0)
) AS
SELECT
  v00.mandant_id AS mandant_id,
  v00.mo_status_id AS mo_status_id,
  v00.mo_intreno AS mo_intreno,
  v00.mv_intreno AS mv_intreno,
  v00.dat_status_von AS dat_status_von,
  v00.dat_status_bis AS dat_status_bis,
  COALESCE(SUBSTR(CAST(v01.mo_status_id AS STRING), 1, 1), '-') AS mo_status_vormonat_id,
  v16.mo_typ_id AS mo_typ_id
FROM kfl_production_dbp_view.v_immo_mo_status_per AS v00
INNER JOIN (
  SELECT
    mo_intreno,
    mv_intreno,
    MAX(dat_status_von) AS max_dat_status_von
  FROM kfl_production_dbp_view.v_immo_mo_status_per
  WHERE
    CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
  GROUP BY
    mo_intreno,
    mv_intreno
) AS v02
  ON v00.mo_intreno = v02.mo_intreno
  AND v00.mv_intreno = v02.mv_intreno
  AND v00.dat_status_von = v02.max_dat_status_von
LEFT JOIN (
  SELECT
    t2.mandant_id,
    t1.mo_intreno,
    t1.mv_intreno,
    t2.mo_status_id
  FROM (
    SELECT
      mo_intreno,
      mv_intreno,
      MAX(dat_status_von) AS max_dat_status_von
    FROM kfl_production_dbp_view.v_immo_mo_status_per
    WHERE
      DATE_SUB(CURRENT_DATE, INTERVAL '30' DAY) BETWEEN dat_status_von AND dat_status_bis
    GROUP BY
      mo_intreno,
      mv_intreno
  ) AS t1
  INNER JOIN kfl_production_dbp_view.v_immo_mo_status_per AS t2
    ON t1.mo_intreno = t2.mo_intreno
    AND t1.mv_intreno = t2.mv_intreno
    AND t1.max_dat_status_von = t2.dat_status_von
  WHERE
    DATE_SUB(CURRENT_DATE, INTERVAL '30' DAY) BETWEEN t2.dat_status_von AND t2.dat_status_bis
) AS v01
  ON v00.mandant_id = v01.mandant_id
  AND v00.mo_intreno = v01.mo_intreno
  AND v00.mv_intreno = v01.mv_intreno
LEFT JOIN kfl_production_dbp_view.v_immo_mietobjekt AS v16
  ON v00.mandant_id = v16.mandant_id AND v00.mo_intreno = v16.mo_intreno
WHERE
  CURRENT_DATE BETWEEN v00.dat_status_von AND v00.dat_status_bis;
