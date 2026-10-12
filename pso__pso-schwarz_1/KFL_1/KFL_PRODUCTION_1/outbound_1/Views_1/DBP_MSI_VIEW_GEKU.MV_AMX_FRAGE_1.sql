CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_frage_1 (amx_frage_id, amx_system_id, pruef_kapitel_id,
antwort_wert, amx_frage_katalog_id, kmr_quelle_id, anmerkung, eingabe, anz_fehler_amx, stichprobe_umfang) AS SELECT v01
 .amx_frage_id,
 v01.amx_system_id,
 v01.pruef_kapitel_id,
 v01.antwort_wert,
 v01.amx_frage_katalog_id,
 1 AS kmr_quelle_id,
 v01.anmerkung,
  CASE
  WHEN v01.antwort_wert IN (0, 1, 4)
  THEN ''
  ELSE v01.eingabe
  END AS eingabe,
 v01.anz_fehler_amx,
 v01.stichprobe_umfang
FROM (SELECT amx_frage_id,
    amx_system_id,
    pruef_kapitel_id,
    antwort_wert,
    amx_frage_katalog_id,
    anmerkung,
    eingabe,
    anz_fehler_amx,
    stichprobe_umfang
   FROM kfl_production_dbp_view.v_amx_frage_1 AS V01
   UNION DISTINCT
   SELECT amx_frage_id,
    1 AS amx_system_id,
    pruef_kapitel_id,
    antwort_wert,
    amx_frage_katalog_id,
    anmerkung,
    eingabe,
    anz_fehler_amx,
    stichprobe_umfang
   FROM kfl_production_dbp_view.v_amx_de_frage_1) AS v01
 INNER JOIN (SELECT pruef_kapitel_id,
    amx_system_id,
    pruefung_id
   FROM kfl_production_dbp_view.v_amx_pruef_kapitel_1
   UNION DISTINCT
   SELECT pruef_kapitel_id,
    1 AS amx_system_id,
    pruefung_id
   FROM kfl_production_dbp_view.v_amx_de_pruef_kapitel_1) AS v02 ON v01.pruef_kapitel_id = v02.pruef_kapitel_id AND v01.amx_system_id
    = v02.amx_system_id
 INNER JOIN (SELECT pruefung_id,
    amx_system_id,
    zustand_id,
    dat_ende,
    mandant_id
   FROM kfl_production_dbp_view.v_amx_pruefung_1
   UNION DISTINCT
   SELECT pruefung_id,
    1 AS amx_system_id,
    zustand_id,
    dat_ende,
    mandant_id
   FROM kfl_production_dbp_view.v_amx_de_pruefung_1) AS v03 ON v02.pruefung_id = v03.pruefung_id AND v02.amx_system_id =
   v03.amx_system_id
 LEFT JOIN (SELECT DISTINCT pruefung_id,
    amx_system_id,
    1 AS asgs_flag
   FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu_1
   WHERE amx_system_id = 2 AND business_process_id IN (102803, 117032, 102805)
    OR amx_system_id = 1 AND business_process_id IN (544687, 544691, 544689)
   UNION DISTINCT
   SELECT DISTINCT pruefung_id,
    1 AS amx_system_id,
    1 AS asgs_flag
   FROM kfl_production_dbp_view.v_amx_de_b_process_pruefung_zu_1
   WHERE business_process_id IN (544687, 544691, 544689)) AS v04 ON v03.pruefung_id = v04.pruefung_id AND v03.amx_system_id
    = v04.amx_system_id
WHERE (v03.amx_system_id = 2 AND v03.zustand_id IN (100003, 100004, 100005, 1001, 100025) OR v03.amx_system_id = 1 AND
     v03.zustand_id IN (100005, 1001, 100041))
 AND (v03.mandant_id = 1 AND v04.asgs_flag = 1 AND v03.dat_ende >= DATE('2015-03-01') OR v03.mandant_id = 1 AND v04.asgs_flag
            IS NULL AND v03.dat_ende >= DATE('2015-06-01') OR v03.mandant_id = 2 AND v03.dat_ende >= DATE('2015-03-01')
        OR v03.mandant_id = 3 AND v03.dat_ende >= DATE('2015-06-22') OR v03.mandant_id = 4 AND v03.dat_ende >= DATE('2019-10-31'
          ) OR v03.mandant_id = 5 AND v03.dat_ende >= DATE('2015-07-16') OR v03.mandant_id = 6 AND v03.dat_ende >= DATE('2015-10-29'
        ) OR v03.mandant_id = 7 AND v03.dat_ende >= DATE('2015-12-01') OR v03.mandant_id = 8 AND v03.dat_ende >= DATE('2015-12-01'
      ));