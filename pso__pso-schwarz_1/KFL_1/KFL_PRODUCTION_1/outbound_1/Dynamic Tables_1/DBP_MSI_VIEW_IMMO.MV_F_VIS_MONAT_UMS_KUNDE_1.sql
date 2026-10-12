CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_f_vis_monat_ums_kunde_1 (
  mandant_id BIGNUMERIC(38, 0),
  wrg_id STRING(3),
  wrg_typ_id BIGNUMERIC(38, 0),
  wup_id BIGNUMERIC(38, 0),
  we_intreno STRING(20),
  kjmo BIGNUMERIC(38, 0),
  gj BIGNUMERIC(38, 0),
  f_anz_kunde BIGNUMERIC(38, 0),
  f_ums_netto BIGNUMERIC(38, 2),
  akt_buchungs_schluss BIGNUMERIC(38, 0),
  kjmo_buchungsschluss BIGNUMERIC(38, 0)
) AS
SELECT
  vis.mandant_id AS mandant_id,
  vis.wrg_id AS wrg_id,
  kurs.wrg_typ_id AS wrg_typ_id,
  vis.wup_id AS wup_id,
  we.we_intreno AS we_intreno,
  vis.kjmo AS kjmo,
  vis.gj AS gj,
  vis.f_anz_kunde AS f_anz_kunde,
  vis.f_ums_netto AS f_ums_netto,
  vis.akt_buchungs_schluss AS akt_buchungs_schluss,
  vis.kjmo_buchungsschluss AS kjmo_buchungsschluss
FROM (
  SELECT
    vis.mandant_id,
    vis.wrg_id,
    wup.aktuell_wup_id AS wup_id,
    vis.kjmo,
    vis.gj,
    ker.akt_buchungs_schluss,
    ker.buchungs_schluss_akt AS kjmo_buchungsschluss,
    SUM(vis.anz_kunde) AS f_anz_kunde,
    SUM(vis.ums_netto) AS f_ums_netto
  FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS vis
  INNER JOIN kfl_production_dbp_view.v_wup_1 AS wup_1
    ON vis.mandant_id = wup.mandant_id AND vis.wup_id = wup.wup_id
  INNER JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker_1 AS ker
    ON vis.kjmo = ker.kj_ker_mo_id
  WHERE
    vis.nb_id = 0 AND vis.akt_gj = 0 AND vis.ums_netto <> 0 AND vis.anz_kunde <> 0
  GROUP BY
    vis.mandant_id,
    vis.wrg_id,
    wup_id,
    vis.kjmo,
    vis.gj,
    ker.akt_buchungs_schluss,
    kjmo_buchungsschluss
  UNION ALL
  SELECT
    vis.mandant_id,
    vis.wrg_id,
    wup.aktuell_wup_id AS wup_id,
    vis.kjmo - 100 AS kjmo,
    vis.gj - 1 AS gj,
    ker.akt_buchungs_schluss - 12 AS akt_buchungs_schluss,
    ker.buchungs_schluss_akt AS kjmo_buchungsschluss,
    SUM(vis.anz_kunde_kvj) AS f_anz_kunde,
    SUM(vis.ums_netto_kvj) AS f_ums_netto
  FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS vis
  INNER JOIN kfl_production_dbp_view.v_wup_1 AS wup_1
    ON vis.mandant_id = wup.mandant_id AND vis.wup_id = wup.wup_id
  INNER JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker_1 AS ker
    ON vis.kjmo = ker.kj_ker_mo_id
  WHERE
    vis.nb_id = 0 AND vis.akt_gj BETWEEN -2 AND 0
  GROUP BY
    vis.mandant_id,
    vis.wrg_id,
    wup_id,
    kjmo,
    gj,
    akt_buchungs_schluss,
    kjmo_buchungsschluss
) AS vis
INNER JOIN kfl_production_dbp_view.v_immo_wirtschaftseinheit_1 AS we
  ON vis.mandant_id = we.mandant_id
  AND vis.wup_id = CAST(we.wirtschaftseinheit_id AS FLOAT64)
  AND we.dat_we_gueltig_bis = CAST('9999-12-31' AS DATE)
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS kurs_1
  ON vis.mandant_id = kurs.mandant_id
  AND vis.wrg_id = kurs.wrg_id
  AND kurs.kurs_dat_bis = CAST('9999-12-31' AS DATE);
