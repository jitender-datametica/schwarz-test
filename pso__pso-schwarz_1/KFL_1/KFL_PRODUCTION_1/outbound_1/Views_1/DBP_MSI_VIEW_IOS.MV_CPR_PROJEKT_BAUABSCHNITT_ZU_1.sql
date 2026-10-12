CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_projekt_bauabschnitt_zu_1 (projekt_id, projekt_nr,
cpr_ext_id, cpr_systemstatus1_prj_id, cpr_systemstatus1_bauab_id, dat_eroeffnung_projekt, bauabschnitt_id, sort_id,
projekt_unter_id, cpr_suchfeld_id, dat_start_ist, dat_ende_ist, dat_start_vorhersage, dat_ende_vorhersage,
dat_start_einschraenkung, dat_ende_einschraenkung, dat_start_ips, dat_ende_ips, projekt_existiert_vor_14tage_fg,
dat_start_ist_minus_14, dat_ende_ist_minus_14, dat_start_vorhersage_minus_14, dat_ende_vorhersage_minus_14,
dat_start_einschraenkung_minus_14, dat_ende_einschraenkung_minus_14, dat_start_ips_minus_14, dat_ende_ips_minus_14,
mandant_kbez, gj, mandant_id) AS SELECT V01.projekt_id,
 V01.cpr_ext_id AS projekt_nr,
 V01.cpr_ext_id,
 V01.cpr_systemstatus1_prj_id,
 V01.cpr_systemstatus1_bauab_id,
 V01.dat_eroeffnung_projekt,
 CAST(V01.bauabschnitt_id AS STRING) AS bauabschnitt_id,
 V01.sort_id,
 V01.projekt_unter_id,
 V01.cpr_suchfeld_id,
  CASE
  WHEN V01.dat_start_ist > DATE '1900-01-01'
  THEN V01.dat_start_ist
  ELSE NULL
  END AS dat_start_ist,
  CASE
  WHEN V01.dat_ende_ist > DATE '1900-01-01'
  THEN V01.dat_ende_ist
  ELSE NULL
  END AS dat_ende_ist,
  CASE
  WHEN V01.dat_start_vorhersage > DATE '1900-01-01'
  THEN V01.dat_start_vorhersage
  ELSE NULL
  END AS dat_start_vorhersage,
  CASE
  WHEN V01.dat_ende_vorhersage > DATE '1900-01-01'
  THEN V01.dat_ende_vorhersage
  ELSE NULL
  END AS dat_ende_vorhersage,
  CASE
  WHEN V01.dat_start_einschraenkung > DATE '1900-01-01'
  THEN V01.dat_start_einschraenkung
  ELSE NULL
  END AS dat_start_einschraenkung,
  CASE
  WHEN V01.dat_ende_einschraenkung > DATE '1900-01-01'
  THEN V01.dat_ende_einschraenkung
  ELSE NULL
  END AS dat_ende_einschraenkung,
  CASE
  WHEN V01.dat_start_ist > DATE '1900-01-01'
  THEN V01.dat_start_ist
  WHEN V01.dat_start_vorhersage > DATE '1900-01-01'
  THEN V01.dat_start_vorhersage
  WHEN V01.dat_start_einschraenkung > DATE '1900-01-01'
  THEN V01.dat_start_einschraenkung
  ELSE NULL
  END AS dat_start_ips,
  CASE
  WHEN V01.dat_ende_ist > DATE '1900-01-01'
  THEN V01.dat_ende_ist
  WHEN V01.dat_ende_vorhersage > DATE '1900-01-01'
  THEN V01.dat_ende_vorhersage
  WHEN V01.dat_ende_einschraenkung > DATE '1900-01-01'
  THEN V01.dat_ende_einschraenkung
  ELSE NULL
  END AS dat_ende_ips,
 V01.projekt_existiert_vor_14tage_fg,
  CASE
  WHEN V01.dat_start_ist_minus_14 > DATE '1900-01-01'
  THEN V01.dat_start_ist_minus_14
  ELSE NULL
  END AS dat_start_ist_minus_14,
  CASE
  WHEN V01.dat_ende_ist_minus_14 > DATE '1900-01-01'
  THEN V01.dat_ende_ist_minus_14
  ELSE NULL
  END AS dat_ende_ist_minus_14,
  CASE
  WHEN V01.dat_start_vorhersage_minus_14 > DATE '1900-01-01'
  THEN V01.dat_start_vorhersage_minus_14
  ELSE NULL
  END AS dat_start_vorhersage_minus_14,
  CASE
  WHEN V01.dat_ende_vorhersage_minus_14 > DATE '1900-01-01'
  THEN V01.dat_ende_vorhersage_minus_14
  ELSE NULL
  END AS dat_ende_vorhersage_minus_14,
  CASE
  WHEN V01.dat_start_einschraenkung_minus_14 > DATE '1900-01-01'
  THEN V01.dat_start_einschraenkung_minus_14
  ELSE NULL
  END AS dat_start_einschraenkung_minus_14,
  CASE
  WHEN V01.dat_ende_einschraenkung_minus_14 > DATE '1900-01-01'
  THEN V01.dat_ende_einschraenkung_minus_14
  ELSE NULL
  END AS dat_ende_einschraenkung_minus_14,
  CASE
  WHEN V01.dat_start_ist_minus_14 > DATE '1900-01-01'
  THEN V01.dat_start_ist_minus_14
  WHEN V01.dat_start_vorhersage_minus_14 > DATE '1900-01-01'
  THEN V01.dat_start_vorhersage_minus_14
  WHEN V01.dat_start_einschraenkung_minus_14 > DATE '1900-01-01'
  THEN V01.dat_start_einschraenkung_minus_14
  ELSE NULL
  END AS dat_start_ips_minus_14,
  CASE
  WHEN V01.dat_ende_ist_minus_14 > DATE '1900-01-01'
  THEN V01.dat_ende_ist_minus_14
  WHEN V01.dat_ende_vorhersage_minus_14 > DATE '1900-01-01'
  THEN V01.dat_ende_vorhersage_minus_14
  WHEN V01.dat_ende_einschraenkung_minus_14 > DATE '1900-01-01'
  THEN V01.dat_ende_einschraenkung_minus_14
  ELSE NULL
  END AS dat_ende_ips_minus_14,
 SUBSTR(V01.cpr_ext_id, 1, 2) AS mandant_kbez,
  CASE
  WHEN V01.dat_eroeffnung_projekt IS NULL OR V01.dat_eroeffnung_projekt = DATE '1900-01-01'
  THEN 9999
  ELSE V05.gj
  END AS gj,
 V99.mandant_id
FROM kfl_production_dbp_view.v_cpr_projekt_bauabschnitt_zu_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_tag_1 AS V05 ON V01.dat_eroeffnung_projekt = V05.dat
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS V99 ON V01.projekt_id = V99.projekt_id AND V99.dat_bis =
   DATE '9999-12-31';