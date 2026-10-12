CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_intreno_zu_hilf_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT DISTINCT
  v1.mandant_id AS mandant_id,
  v1.we_intreno AS we_intreno,
  v1.mo_intreno AS mo_intreno,
  t6.mv_intreno AS mv_intreno,
  v3.mietvertrag_nr AS mietvertrag_nr,
  v3.partner_id AS partner_id,
  v3.partner_id AS konzessionaer_id,
  v2.dat_von AS dat_von,
  v2.dat_bis AS dat_bis,
  v6.we_intreno_akt AS we_intreno_akt,
  v6.mo_intreno_akt AS mo_intreno_akt,
  v6.mv_intreno_akt AS mv_intreno_akt,
  v6.konzessionaer_id AS konzessionaer_id_akt
FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS v1
LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS v2
  ON v1.mandant_id = v2.mandant_id AND v1.mo_intreno = v2.mo_intreno
LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS v3
  ON v2.mandant_id = v3.mandant_id AND v2.mv_intreno = v3.mv_intreno
INNER JOIN (
  SELECT
    v11.mandant_id,
    v13.mietvertrag_nr,
    MAX(v11.we_intreno) AS we_intreno_akt,
    MAX(v11.mo_intreno) AS mo_intreno_akt,
    MAX(v12.mv_intreno) AS mv_intreno_akt,
    MAX(v13.partner_id) AS konzessionaer_id
  FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS v11
  LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS v12
    ON v11.mandant_id = v12.mandant_id AND v11.mo_intreno = v12.mo_intreno
  LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS v13
    ON v12.mandant_id = v13.mandant_id AND v12.mv_intreno = v13.mv_intreno
  GROUP BY
    v11.mandant_id,
    v13.mietvertrag_nr
) AS v6
  ON v3.mandant_id = v6.mandant_id AND v3.mietvertrag_nr = v6.mietvertrag_nr
INNER JOIN (
  SELECT
    mandant_id,
    mv_intreno,
    mietvertrag_nr0 AS mietvertrag_nr
  FROM (
    SELECT DISTINCT
      v10.mandant_id,
      v10.mv_intreno,
      v2.mietvertrag_nr AS mietvertrag_nr0
    FROM kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS v10
    INNER JOIN (
      SELECT DISTINCT
        mandant_id,
        mv_intreno,
        mietvertrag_nr,
        mietvertrag_nr_alt
      FROM kfl_production_dbp_view.v_immo_mietvertrag_per_1
    ) AS v2
      ON v10.mietvertrag_nr = v2.mietvertrag_nr_alt AND v10.mandant_id = v2.mandant_id
  ) AS v15
) AS t6
  ON v3.mietvertrag_nr = t6.mietvertrag_nr AND v3.mandant_id = t6.mandant_id
UNION DISTINCT
SELECT DISTINCT
  v1.mandant_id,
  v1.we_intreno,
  v1.mo_intreno,
  v2.mv_intreno,
  v3.mietvertrag_nr,
  v3.partner_id,
  v3.partner_id AS konzessionaer_id,
  v2.dat_von,
  v2.dat_bis,
  v6.we_intreno_akt,
  v6.mo_intreno_akt,
  v6.mv_intreno_akt,
  v6.konzessionaer_id AS konzessionaer_id_akt
FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS v1
LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS v2
  ON v1.mandant_id = v2.mandant_id AND v1.mo_intreno = v2.mo_intreno
LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS v3
  ON v2.mandant_id = v3.mandant_id AND v2.mv_intreno = v3.mv_intreno
INNER JOIN (
  SELECT
    v11.mandant_id,
    v13.mietvertrag_nr,
    MAX(v11.we_intreno) AS we_intreno_akt,
    MAX(v11.mo_intreno) AS mo_intreno_akt,
    MAX(v12.mv_intreno) AS mv_intreno_akt,
    MAX(v13.partner_id) AS konzessionaer_id
  FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS v11
  LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS v12
    ON v11.mandant_id = v12.mandant_id AND v11.mo_intreno = v12.mo_intreno
  LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS v13
    ON v12.mandant_id = v13.mandant_id AND v12.mv_intreno = v13.mv_intreno
  GROUP BY
    v11.mandant_id,
    v13.mietvertrag_nr
) AS v6
  ON v3.mandant_id = v6.mandant_id AND v3.mietvertrag_nr = v6.mietvertrag_nr;
