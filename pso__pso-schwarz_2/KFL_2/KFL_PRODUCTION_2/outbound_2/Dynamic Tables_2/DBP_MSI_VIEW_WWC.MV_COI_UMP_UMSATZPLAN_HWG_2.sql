CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_coi_ump_umsatzplan_hwg_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.gj_plan AS gj_plan,
  v01.version_id AS version_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.dat_plan AS dat_plan,
  v01.arthiertyp_id AS arthiertyp_id,
  v01.hwg_id AS hwg_id,
  v01.wrg_id AS wrg_id,
  v01.land_level AS land_level,
  v01.vs_id AS vs_id,
  v01.wup_id_referenz AS wup_id_referenz,
  v01.dat_referenz AS dat_referenz,
  CAST(v01.faktor_kalender AS BIGNUMERIC) AS faktor_kalender,
  CAST(v01.faktor_basis AS BIGNUMERIC) AS faktor_basis,
  CAST(v01.faktor_wup_referenz AS BIGNUMERIC) AS faktor_wup_referenz,
  v01.umsatz_netto_basis_1 AS umsatz_netto_basis_1,
  v01.umsatz_netto_basis_2 AS umsatz_netto_basis_2,
  v01.umsatz_netto_basis_3 AS umsatz_netto_basis_3,
  v01.umsatz_netto_plan AS umsatz_netto_plan,
  v01.wup_geoeffnet_fg AS wup_geoeffnet_fg,
  v03.umsatz_netto AS umsatz_netto_ist,
  v03_vj.umsatz_netto AS umsatz_netto_ist_vj,
  v03_vj_kt.umsatz_netto AS umsatz_netto_ist_vj_kt,
  v03_vvj.umsatz_netto AS umsatz_netto_ist_vvj,
  v03_vvj_kt.umsatz_netto AS umsatz_netto_ist_vvj_kt,
  COALESCE(v04_vj.referenzgrund_id, -1) AS referenzgrund_id_vj,
  COALESCE(v04_vj_kt.referenzgrund_id, -1) AS referenzgrund_id_vj_kt,
  COALESCE(v04_vvj.referenzgrund_id, -1) AS referenzgrund_id_vvj,
  COALESCE(v04_vvj_kt.referenzgrund_id, -1) AS referenzgrund_id_vvj_kt,
  v01.umsatz_netto_plan_vj AS umsatz_netto_plan_vj,
  v01.umsatz_netto_plan_vj_kt AS umsatz_netto_plan_vj_kt,
  v01.umsatz_basis_vj AS umsatz_basis_vj,
  v01.umsatz_basis_vj_kt AS umsatz_basis_vj_kt,
  v01.umsatz_basis_vvj AS umsatz_basis_vvj,
  v01.umsatz_basis_vvj_kt AS umsatz_basis_vvj_kt,
  COALESCE(v01.umsatz_netto_basis_3, 0) - v01.umsatz_basis_vj AS umsatz_kalendereffekt_vj,
  COALESCE(v01.umsatz_netto_basis_3, 0) - v01.umsatz_basis_vj_kt AS umsatz_kalendereffekt_vj_kt,
  COALESCE(v01.umsatz_netto_basis_3, 0) - v01.umsatz_basis_vvj AS umsatz_kalendereffekt_vvj,
  COALESCE(v01.umsatz_netto_basis_3, 0) - v01.umsatz_basis_vvj_kt AS umsatz_kalendereffekt_vvj_kt,
  v01.umsatz_basis_vj - CASE
    WHEN CASE WHEN v02.dat_vj >= v06.dat_planwerte_ist_ab THEN 1 ELSE 0 END = 1
    THEN COALESCE(v01.umsatz_netto_plan_vj, 0)
    ELSE COALESCE(v03_vj.umsatz_netto, 0)
  END AS umsatz_referenzeffekt_vj,
  v01.umsatz_basis_vj_kt - CASE
    WHEN CASE
      WHEN CASE
        WHEN v02.gjtag_id = 366
        THEN DATE('1900-01-01')
        ELSE DATE_ADD(v01.dat_plan, INTERVAL '-1' YEAR)
      END >= v06.dat_planwerte_ist_ab
      THEN 1
      ELSE 0
    END = 1
    THEN COALESCE(v01.umsatz_netto_plan_vj_kt, 0)
    ELSE COALESCE(v03_vj_kt.umsatz_netto, 0)
  END AS umsatz_referenzeffekt_vj_kt,
  v01.umsatz_basis_vvj - COALESCE(v03_vvj.umsatz_netto, 0) AS umsatz_referenzeffekt_vvj,
  v01.umsatz_basis_vvj_kt - COALESCE(v03_vvj_kt.umsatz_netto, 0) AS umsatz_referenzeffekt_vvj_kt,
  CASE WHEN v02.dat_vj >= v06.dat_planwerte_ist_ab THEN 1 ELSE 0 END AS umsatz_plan_vj_fg,
  CASE
    WHEN CASE
      WHEN v02.gjtag_id = 366
      THEN DATE('1900-01-01')
      ELSE DATE_ADD(v01.dat_plan, INTERVAL '-1' YEAR)
    END >= v06.dat_planwerte_ist_ab
    THEN 1
    ELSE 0
  END AS umsatz_plan_vj_kt_fg,
  COALESCE(v07.betriebsunterbrechung_fg, 0) AS betriebsunterbrechung_fg
FROM kfl_production_dbp_view.v_coi_ump_umsatzplan_hwg_2 AS v01
LEFT JOIN kfl_production_dbp_view.v_tag_2 AS v02
  ON v01.dat_plan = v02.dat
LEFT JOIN kfl_production_dbp_view.v_coi_ump_hwg_sum_2 AS v03
  ON v01.mandant_id = v03.mandant_id
  AND v01.wup_id = v03.wup_id
  AND v01.nb_id = v03.nb_id
  AND v01.dat_plan = v03.dat
  AND v01.hwg_id = v03.hwg_id
  AND v01.wrg_id = v03.wrg_id
LEFT JOIN kfl_production_dbp_view.v_coi_ump_hwg_sum_2 AS v03_vj
  ON v01.mandant_id = v03_vj.mandant_id
  AND v01.wup_id = v03_vj.wup_id
  AND v01.nb_id = v03_vj.nb_id
  AND v02.dat_vj = v03_vj.dat
  AND v01.hwg_id = v03_vj.hwg_id
  AND v01.wrg_id = v03_vj.wrg_id
LEFT JOIN (
  SELECT
    mandant_id,
    wup_id,
    nb_id,
    CASE WHEN dat = CAST('2020-02-29' AS DATE) THEN DATE('2020-02-28') ELSE dat END AS dat_,
    hwg_id,
    wrg_id,
    SUM(umsatz_netto) AS umsatz_netto
  FROM kfl_production_dbp_view.v_coi_ump_hwg_sum_2
  GROUP BY
    mandant_id,
    wup_id,
    nb_id,
    dat_,
    hwg_id,
    wrg_id
) AS v03_vj_kt
  ON v01.mandant_id = v03_vj_kt.mandant_id
  AND v01.wup_id = v03_vj_kt.wup_id
  AND v01.nb_id = v03_vj_kt.nb_id
  AND CASE
    WHEN v02.gjtag_id = 366
    THEN DATE('1900-01-01')
    ELSE DATE_ADD(v01.dat_plan, INTERVAL '-1' YEAR)
  END = v03_vj_kt.dat_
  AND v01.hwg_id = v03_vj_kt.hwg_id
  AND v01.wrg_id = v03_vj_kt.wrg_id
LEFT JOIN kfl_production_dbp_view.v_coi_ump_hwg_sum_2 AS v03_vvj
  ON v01.mandant_id = v03_vvj.mandant_id
  AND v01.wup_id = v03_vvj.wup_id
  AND v01.nb_id = v03_vvj.nb_id
  AND DATE_SUB(v02.dat_vj, INTERVAL '364' DAY) = v03_vvj.dat
  AND v01.hwg_id = v03_vvj.hwg_id
  AND v01.wrg_id = v03_vvj.wrg_id
LEFT JOIN (
  SELECT
    mandant_id,
    wup_id,
    nb_id,
    CASE WHEN dat = CAST('2020-02-29' AS DATE) THEN DATE('2020-02-28') ELSE dat END AS dat_,
    hwg_id,
    wrg_id,
    SUM(umsatz_netto) AS umsatz_netto
  FROM kfl_production_dbp_view.v_coi_ump_hwg_sum_2
  GROUP BY
    mandant_id,
    wup_id,
    nb_id,
    dat_,
    hwg_id,
    wrg_id
) AS v03_vvj_kt
  ON v01.mandant_id = v03_vvj_kt.mandant_id
  AND v01.wup_id = v03_vvj_kt.wup_id
  AND v01.nb_id = v03_vvj_kt.nb_id
  AND CASE
    WHEN v02.gjtag_id = 366
    THEN DATE('1900-01-01')
    ELSE DATE_ADD(v01.dat_plan, INTERVAL '-2' YEAR)
  END = v03_vvj_kt.dat_
  AND v01.hwg_id = v03_vvj_kt.hwg_id
  AND v01.wrg_id = v03_vvj_kt.wrg_id
LEFT JOIN kfl_production_dbp_view.v_coi_ump_wup_2 AS v04_vj
  ON v01.mandant_id = v04_vj.mandant_id
  AND v01.gj_plan = v04_vj.gj_plan
  AND v01.version_id = v04_vj.version_id
  AND v01.wup_id = v04_vj.wup_id
  AND v01.nb_id = v04_vj.nb_id
  AND v02.dat_vj BETWEEN v04_vj.dat_wup_ref_von AND v04_vj.dat_wup_ref_bis
LEFT JOIN kfl_production_dbp_view.v_coi_ump_wup_2 AS v04_vj_kt
  ON v01.mandant_id = v04_vj_kt.mandant_id
  AND v01.gj_plan = v04_vj_kt.gj_plan
  AND v01.version_id = v04_vj_kt.version_id
  AND v01.wup_id = v04_vj_kt.wup_id
  AND v01.nb_id = v04_vj_kt.nb_id
  AND v01.dat_referenz BETWEEN v04_vj_kt.dat_wup_ref_von AND v04_vj_kt.dat_wup_ref_bis
LEFT JOIN kfl_production_dbp_view.v_coi_ump_wup_2 AS v04_vvj
  ON v01.mandant_id = v04_vvj.mandant_id
  AND v01.gj_plan = v04_vvj.gj_plan
  AND v01.version_id = v04_vvj.version_id
  AND v01.wup_id = v04_vvj.wup_id
  AND v01.nb_id = v04_vvj.nb_id
  AND DATE_SUB(v02.dat_vj, INTERVAL '364' DAY) BETWEEN v04_vvj.dat_wup_ref_von AND v04_vvj.dat_wup_ref_bis
LEFT JOIN kfl_production_dbp_view.v_coi_ump_wup_2 AS v04_vvj_kt
  ON v01.mandant_id = v04_vvj_kt.mandant_id
  AND v01.gj_plan = v04_vvj_kt.gj_plan
  AND v01.version_id = v04_vvj_kt.version_id
  AND v01.wup_id = v04_vvj_kt.wup_id
  AND v01.nb_id = v04_vvj_kt.nb_id
  AND v01.dat_referenz BETWEEN v04_vvj_kt.dat_wup_ref_von AND v04_vvj_kt.dat_wup_ref_bis
LEFT JOIN kfl_production_dbp_view.v_coi_ump_version_2 AS v06
  ON v01.mandant_id = v06.mandant_id
  AND v01.gj_plan = v06.gj_plan
  AND v01.version_id = v06.version_id
LEFT JOIN kfl_production_dbp_view.v_coi_ump_wup_immo_massnahme_per_2 AS v07
  ON v01.mandant_id = v07.mandant_id
  AND v01.wup_id = v07.wup_id
  AND v01.nb_id = v07.nb_id
  AND v01.version_id = v07.version_id
  AND v01.gj_plan = v07.gj_plan
  AND v01.dat_plan BETWEEN v07.dat_immo_auswirkung_von AND v07.dat_immo_auswirkung_bis
  AND v07.betriebsunterbrechung_fg = 1;