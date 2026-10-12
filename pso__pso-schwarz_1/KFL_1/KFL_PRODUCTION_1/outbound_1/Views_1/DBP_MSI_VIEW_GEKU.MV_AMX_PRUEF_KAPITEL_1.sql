CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_pruef_kapitel_1 (pruef_kapitel_id, amx_system_id,
pruefung_id, pruef_kapitel_bez, kapitel_ergebnis_wert) AS SELECT v01.pruef_kapitel_id,
 v01.amx_system_id,
 v01.pruefung_id,
 v01.pruef_kapitel_bez,
 v01.kapitel_ergebnis_wert
FROM (SELECT pruef_kapitel_id,
    amx_system_id,
    pruefung_id,
    pruef_kapitel_bez,
    kapitel_ergebnis_wert
   FROM kfl_production_dbp_view.v_amx_pruef_kapitel_1
   UNION DISTINCT
   SELECT pruef_kapitel_id,
    1 AS amx_system_id,
    pruefung_id,
    pruef_kapitel_bez,
    kapitel_ergebnis_wert
   FROM kfl_production_dbp_view.v_amx_de_pruef_kapitel_1) AS v01
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
   FROM kfl_production_dbp_view.v_amx_de_pruefung_1) AS v02 ON v01.pruefung_id = v02.pruefung_id AND v01.amx_system_id =
   v02.amx_system_id
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
   WHERE business_process_id IN (544687, 544691, 544689)) AS v03 ON v02.pruefung_id = v03.pruefung_id AND v02.amx_system_id
    = v03.amx_system_id
WHERE (v02.amx_system_id = 2 AND v02.zustand_id IN (100003, 100004, 100005, 1001, 100025) OR v02.amx_system_id = 1 AND
     v02.zustand_id IN (100005, 1001, 100041))
 AND (v02.mandant_id = 1 AND v03.asgs_flag = 1 AND v02.dat_ende >= DATE('2015-03-01') OR v02.mandant_id = 1 AND v03.asgs_flag
            IS NULL AND v02.dat_ende >= DATE('2015-06-01') OR v02.mandant_id = 2 AND v02.dat_ende >= DATE('2015-03-01')
        OR v02.mandant_id = 3 AND v02.dat_ende >= DATE('2015-06-22') OR v02.mandant_id = 4 AND v02.dat_ende >= DATE('2019-10-31'
          ) OR v02.mandant_id = 5 AND v02.dat_ende >= DATE('2015-07-16') OR v02.mandant_id = 6 AND v02.dat_ende >= DATE('2015-10-29'
        ) OR v02.mandant_id = 7 AND v02.dat_ende >= DATE('2015-12-01') OR v02.mandant_id = 8 AND v02.dat_ende >= DATE('2015-12-01'
      ));