CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_wirtschaftseinheit_2 AS
SELECT
  v0.mandant_id AS mandant_id,
  v0.we_intreno AS we_intreno,
  CASE
    WHEN v0.buchungskreis_id < 10
    THEN '000' || TRIM(SUBSTR(CAST(v0.buchungskreis_id AS STRING), 1, 39))
    WHEN v0.buchungskreis_id < 100
    THEN '00' || TRIM(SUBSTR(CAST(v0.buchungskreis_id AS STRING), 1, 39))
    WHEN v0.buchungskreis_id < 1000
    THEN '0' || TRIM(SUBSTR(CAST(v0.buchungskreis_id AS STRING), 1, 39))
    ELSE '' || TRIM(SUBSTR(CAST(v0.buchungskreis_id AS STRING), 1, 39))
  END AS buchungskreis_id,
  2 AS system_id,
  CASE
    WHEN LENGTH(v0.wirtschaftseinheit_id) = 3
    THEN '0' || v0.wirtschaftseinheit_id
    ELSE v0.wirtschaftseinheit_id
  END AS wirtschaftseinheit_id,
  v0.wirtschaftseinheit_bez AS wirtschaftseinheit_bez,
  v0.we_objekt_nr AS we_objekt_nr,
  v0.dat_eroeffnung AS dat_eroeffnung,
  v14.anmietende AS anmietende,
  v15.geplante_eroeffnung AS geplante_eroeffnung,
  v0.dat_we_gueltig_von AS dat_we_gueltig_von,
  v0.dat_we_gueltig_bis AS dat_we_gueltig_bis,
  COALESCE(v2.gebiet_id, 0) AS gebiet_id,
  COALESCE(v0.region_id, 'n.v.') AS region_id,
  COALESCE(v22.region_bez, 'n.v.') AS region_bez,
  v0.standort AS standort,
  v0.ort AS ort,
  COALESCE(v1.partner_id, 'n.v.') AS objektleiter_id,
  COALESCE(v2.partner_id, 'n.v.') AS regionalleiter_id,
  COALESCE(v3.partner_id, 'n.v.') AS objektbetreuer_id,
  v0.plz AS plz,
  v0.strasse || ' ' || v0.haus_nr AS adresse,
  v12.wup_telefon AS telefon_nr,
  v12.wup_fax AS fax_nr,
  v0.besitzstatus_id AS besitzstatus_id,
  COALESCE(v0.we_region, 'n.v.') AS we_region,
  COALESCE(v0.objektart_id, 'n.v.') AS objektart_id,
  COALESCE(w.breitengrad, 0) AS breitengrad,
  COALESCE(w.laengengrad, 0) AS laengengrad
FROM kfl_production_dbp_view.v_immo_wirtschaftseinheit_2 AS v0
LEFT JOIN (
  SELECT
    v00.partner_id,
    v01.we_intreno
  FROM kfl_production_dbp_view.v_immo_l_partner_2 AS v00
  INNER JOIN kfl_production_dbp_view.v_immo_we_partner_rolle_zu_per_2 AS v01
    ON v00.partner_id = v01.partner_id
  WHERE
    CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis AND v01.rolle_kz = 'ZI0104'
) AS v1
  ON v0.we_intreno = v1.we_intreno
LEFT JOIN (
  SELECT
    v10.partner_id,
    v11.we_intreno,
    v10.gebiet_id
  FROM kfl_production_dbp_view.v_immo_l_partner_2 AS v10
  INNER JOIN kfl_production_dbp_view.v_immo_we_partner_rolle_zu_per_2 AS v11
    ON v10.partner_id = v11.partner_id
  WHERE
    CURRENT_DATE BETWEEN v11.dat_von AND v11.dat_bis AND v11.rolle_kz = 'ZI0105'
) AS v2
  ON v0.we_intreno = v2.we_intreno
LEFT JOIN (
  SELECT
    v000.partner_id,
    v010.we_intreno
  FROM kfl_production_dbp_view.v_immo_l_partner_2 AS v000
  INNER JOIN kfl_production_dbp_view.v_immo_we_partner_rolle_zu_per_2 AS v010
    ON v000.partner_id = v010.partner_id
  WHERE
    CURRENT_DATE BETWEEN v010.dat_von AND v010.dat_bis AND v010.rolle_kz = 'ZI0120'
) AS v3
  ON v0.we_intreno = v3.we_intreno
LEFT JOIN kfl_production_dbp_view.v_wup_2 AS w
  ON v0.mandant_id = w.mandant_id
  AND CAST(v0.wirtschaftseinheit_id AS FLOAT64) = w.wup_id
LEFT JOIN (
  SELECT
    v1.mandant_id,
    v1.region_id,
    v2.spr_id,
    v2.region_bez
  FROM kfl_production_dbp_view.v_immo_l_region_2 AS v1
  INNER JOIN kfl_production_dbp_view.v_immo_region_spr_zu_2 AS v2
    ON v1.mandant_id = v2.mandant_id AND v1.region_id = v2.region_id
  WHERE
    v2.spr_id = 22
  UNION ALL
  SELECT DISTINCT
    0 AS mandant_id,
    'n.v' AS region_id,
    0 AS spr_id,
    'n.v' AS region_bez
  FROM kfl_production_dbp_view.v_immo_l_region_2
) AS v22
  ON v0.mandant_id = v22.mandant_id AND v0.region_id = v22.region_id
LEFT JOIN kfl_production_dbp_view.v_vaus_wup_2 AS v12
  ON v0.mandant_id = v12.mandant_id
  AND CAST(v0.wirtschaftseinheit_id AS FLOAT64) = v12.wup_id
LEFT JOIN (
  SELECT
    t3.mandant_id,
    t3.wirtschaftseinheit_id,
    t3.we_intreno,
    MIN(
      CASE
        WHEN t2.dat_miet_ende < t2.dat_naechstes_vertragsende
        THEN t2.dat_miet_ende
        ELSE t2.dat_naechstes_vertragsende
      END
    ) AS anmietende
  FROM kfl_production_dbp_view.v_immo_mietvertrag_we_zu_per_2 AS t1_2
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_2 AS t2
    ON t1.mandant_id = t2.mandant_id AND t1.mv_intreno = t2.mv_intreno
  INNER JOIN kfl_production_dbp_view.v_immo_wirtschaftseinheit_2 AS t3
    ON t1.we_intreno = t3.we_intreno AND t1.mandant_id = t3.mandant_id
  WHERE
    CURRENT_DATE BETWEEN t1.dat_von AND t1.dat_bis
    AND CURRENT_DATE BETWEEN t2.dat_miet_beginn AND t2.dat_miet_ende
    AND t2.vertragsart_id = 100
    AND t2.vertragsgegenstand_id = 17
    AND CURRENT_DATE BETWEEN t3.dat_we_gueltig_von AND t3.dat_we_gueltig_bis
  GROUP BY
    t3.mandant_id,
    t3.wirtschaftseinheit_id,
    t3.we_intreno
) AS v14
  ON v0.mandant_id = v14.mandant_id
  AND v0.wirtschaftseinheit_id = v14.wirtschaftseinheit_id
  AND v0.we_intreno = v14.we_intreno
LEFT JOIN (
  SELECT
    t20.mandant_id,
    t20.wup_id,
    MAX(t10.dat_ende_vorhersage) AS geplante_eroeffnung
  FROM kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu_2 AS t10
  INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_2 AS t20
    ON t10.projekt_id = t20.projekt_id
  INNER JOIN kfl_production_dbp_view.v_rpm_element_per_2 AS t30
    ON t20.cpr_ext_id = t30.projekt_id
    AND t20.dat_bis = t30.dat_bis
    AND t20.mandant_id = t30.mandant_id
    AND t20.wup_id = t30.wup_id
  WHERE
    t10.cpr_suchfeld_id = 410
    AND t10.sort_id = 1
    AND t20.massnahme_id = 'XP'
    AND t20.cpr_systemstatus1_id IN (1, 2)
    AND t20.dat_bis = CAST('9999-12-31' AS DATE)
    AND NOT t30.rpm_status_id IN (3, 5, 6, 14)
  GROUP BY
    t20.mandant_id,
    t20.wup_id
) AS v15
  ON v0.mandant_id = v15.mandant_id
  AND CAST(v0.wirtschaftseinheit_id AS FLOAT64) = v15.wup_id
WHERE
  CURRENT_DATE BETWEEN v0.dat_we_gueltig_von AND v0.dat_we_gueltig_bis;
