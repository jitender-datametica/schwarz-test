CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_wup_2 AS
WITH gj_zeitraum AS (
  SELECT
    gj,
    akt_gj,
    DATE_ADD(MIN(dat), INTERVAL '1' DAY) AS start_tag_gj,
    DATE_SUB(MAX(dat), INTERVAL '1' DAY) AS end_tag_gj
  FROM kfl_production_dbp_view.v_tag_2
  GROUP BY
    gj,
    akt_gj
)
(
  SELECT
    v01.wup_id AS wup_id,
    v01.nb_id AS nb_id,
    v01.mandant_id AS mandant_id,
    v01.wup_aenderung_grund_id AS wup_aenderung_grund_id,
    COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS aktuell_wup_id,
    COALESCE(
      MAX(v01.wup_id_alt) OVER (
        PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ),
      v01.orig_wup_id
    ) AS orig_wup_id,
    v01.land_id AS land_id,
    CASE
      WHEN v01.wup_id = 2660
      THEN PARSE_DATE('%F', '2009-09-17')
      ELSE COALESCE(v01.dat_von_alt, v01.dat_von)
    END AS dat_von,
    v01.wup_typ_id AS wup_typ_id,
    v01.wup_name_v AS wup_name_v,
    v01.wup_name_e AS wup_name_e,
    v01.wup_standort AS wup_standort,
    FIRST_VALUE(v01.wup_standort) OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
      ORDER BY v01.dat_von IS NULL, v01.dat_von
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS akt_wup_standort,
    v01.wup_plz AS wup_plz,
    FIRST_VALUE(v01.wup_plz) OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
      ORDER BY v01.dat_von IS NULL, v01.dat_von
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS akt_wup_plz,
    v01.wup_str AS wup_str,
    v01.vf_id AS vf_id,
    CASE
      WHEN v01.dat_bis <> CAST('9999-12-31' AS DATE)
      AND v01.wup_aenderung_grund_id IN (1, 2, 3, 4)
      AND v01.vkl_id < 0
      THEN COALESCE(v02.vkl_id, 1000 + v01.mandant_id * 100 + v01.vs_id * 10 * -1)
      WHEN v01.dat_bis <> CAST('9999-12-31' AS DATE)
      AND v01.wup_aenderung_grund_id = 0
      AND v01.vkl_id < 0
      THEN (
        1000 + v01.mandant_id * 100 + v01.vs_id * 10
      ) * -1
      ELSE v01.vkl_id
    END AS vkl_id,
    v01.hl_id AS hl_id,
    v01.dat_bis AS dat_bis,
    CASE WHEN v01.uebernahme_von IS NULL THEN '' ELSE v01.uebernahme_von END AS uebernahme_von,
    FIRST_VALUE(v01.uebernahme_von) OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
      ORDER BY v01.dat_von IS NULL, v01.dat_von, v01.dat_bis IS NULL, v01.dat_bis
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS akt_uebernahme_von,
    CASE WHEN v01.uebernahme_von = 'real 2021' THEN 'Real' ELSE 'Bestand' END AS real_flag,
    v01.breakevenumsatz AS breakevenumsatz,
    v01.systemrentabilitaet AS systemrentabilitaet,
    v01.verkaufsflaeche AS verkaufsflaeche,
    v01.betriebsflaeche AS betriebsflaeche,
    v01.fleischsystem AS fleischsystem,
    v01.preiskategorie_food AS preiskategorie_food,
    v01.preiskategorie_nonfood AS preiskategorie_nonfood,
    v01.sortkategorie_food AS sortkategorie_food,
    v01.sortkategorie_nonfood AS sortkategorie_nonfood,
    v01.sondermarkt AS sondermarkt,
    v01.ref_wup_id AS ref_wup_id,
    v01.wm_id AS wm_id,
    v01.kassentyp AS kassentyp,
    v01.dat_qbm_umstellung AS dat_qbm_umstellung,
    v01.kreistyp_gruppe_id AS kreistyp_gruppe_id,
    v01.dat_umstellung_waage AS dat_umstellung_waage,
    v01.lead_mwst AS lead_mwst,
    v01.region_id AS region_id,
    FIRST_VALUE(v01.region_id) OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
      ORDER BY v01.dat_von IS NULL, v01.dat_von
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS akt_region_id,
    v01.kundenfaktor AS kundenfaktor,
    v01.vz_wup_id AS vz_wup_id,
    TRIM(CAST(v01.wup_id AS STRING) || ' ' || v01.wup_standort) AS markt,
    v01.getraenkemarkt_fg AS getraenkemarkt_fg,
    v01.vs_id AS vs_id,
    CASE
      WHEN v01.vs_id IN (2, 7)
      THEN 1
      WHEN v01.vs_id IN (1, 3)
      THEN 2
      WHEN v01.vs_id IN (6, 8)
      THEN 3
      ELSE NULL
    END AS wreg_id,
    v01.verkaufsorganisation_id AS verkaufsorganisation_id,
    v01.adresse_id AS adresse_id,
    v01.breitengrad AS breitengrad,
    v01.laengengrad AS laengengrad,
    FIRST_VALUE(v01.breitengrad) OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
      ORDER BY v01.dat_von IS NULL, v01.dat_von
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS akt_breitengrad,
    FIRST_VALUE(v01.laengengrad) OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
      ORDER BY v01.dat_von IS NULL, v01.dat_von
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS akt_laengengrad,
    COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) AS dat_eroeffnung,
    CASE
      WHEN v01.dat_bis <> CAST('9999-12-31' AS DATE)
      AND v01.wup_aenderung_grund_id IN (1, 2, 3, 4)
      AND v01.gf_id < 0
      THEN COALESCE(v02.gf_id, 1000 + v01.mandant_id * 100 + v01.vs_id * 10 * -1)
      WHEN v01.dat_bis <> CAST('9999-12-31' AS DATE)
      AND v01.wup_aenderung_grund_id = 0
      AND v01.gf_id < 0
      THEN (
        1000 + v01.mandant_id * 100 + v01.vs_id * 10
      ) * -1
      ELSE v01.gf_id
    END AS gf_id,
    v01.umzugsfiliale_fg AS umzugsfiliale_fg,
    CASE
      WHEN v03.akt_gj < 1
      OR v04.akt_gj > -3
      OR EXTRACT(YEAR FROM COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) > EXTRACT(YEAR FROM CURRENT_DATE)
      THEN 'Exp.'
      ELSE 'Exp.ber.'
    END AS expansions_flag_vvj,
    CASE
      WHEN v03.akt_gj < 1
      OR v04.akt_gj > -2
      OR EXTRACT(YEAR FROM COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)) > EXTRACT(YEAR FROM CURRENT_DATE)
      THEN 'Exp.'
      ELSE 'Exp.ber.'
    END AS expansions_flag_vj,
    FIRST_VALUE(v01.gln_id) OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), CAST(COALESCE(v02.aktuell_wup_id, v01.aktuell_wup_id) AS STRING)
      ORDER BY v01.dat_von IS NULL, v01.dat_von
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS akt_gln_id
  FROM kfl_production_dbp_view.v_wup_2 AS v01
  LEFT JOIN kfl_production_dbp_view.v_wup_2 AS v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.wup_id = v02.wup_id_alt
    AND v01.nb_id = v02.nb_id
  LEFT JOIN gj_zeitraum AS v03
    ON v01.dat_bis BETWEEN v03.start_tag_gj AND v03.end_tag_gj
  LEFT JOIN gj_zeitraum AS v04
    ON COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) BETWEEN v04.start_tag_gj AND v04.end_tag_gj
  WHERE
    v01.mandant_id = 1
    AND (
      (
        v01.dat_eroeffnung < CURRENT_DATE
        OR v01.dat_eroeffnung < DATE_ADD(CURRENT_DATE, INTERVAL '45' DAY)
      )
      AND NOT v01.dat_von IS NULL
      OR v01.nb_id <> 0
      OR v01.wup_id = 9203
    )
    AND v01.nb_id <> 99
    AND NOT v01.wup_id BETWEEN 1 AND 999
);
