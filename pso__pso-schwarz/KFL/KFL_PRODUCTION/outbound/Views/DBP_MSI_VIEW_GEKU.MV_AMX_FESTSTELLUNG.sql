CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_feststellung (feststellung_id, amx_system_id,
amx_frage_id, feststellung_bez) AS SELECT V01.feststellung_id,
 V01.amx_system_id,
 V01.amx_frage_id,
 V01.feststellung_bez
FROM kfl_production_dbp_view.v_amx_feststellung AS V01
 INNER JOIN kfl_production_dbp_view.v_amx_frage AS V02 ON V01.amx_frage_id = V02.amx_frage_id AND V01.amx_system_id =
   V02.amx_system_id
 INNER JOIN kfl_production_dbp_view.v_amx_pruef_kapitel AS V03 ON V02.pruef_kapitel_id = V03.pruef_kapitel_id AND V02.amx_system_id
    = V03.amx_system_id
 INNER JOIN kfl_production_dbp_view.v_amx_pruefung AS V04 ON V03.pruefung_id = V04.pruefung_id AND V03.amx_system_id =
   V04.amx_system_id
 LEFT JOIN (SELECT DISTINCT pruefung_id,
   amx_system_id,
   1 AS asgs_flag
  FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu
  WHERE amx_system_id = 2 AND business_process_id IN (102803, 117032, 102805)
   OR amx_system_id = 1 AND business_process_id IN (544687, 544691, 544689)) AS v05 ON V04.pruefung_id = v05.pruefung_id
    AND V04.amx_system_id = v05.amx_system_id
WHERE (V04.amx_system_id = 2 AND V04.zustand_id IN (100003, 100004, 100005, 1001, 100025) OR V04.amx_system_id = 1 AND
     V04.zustand_id IN (100005, 1001, 100041))
 AND (V04.mandant_id = 1 AND v05.asgs_flag = 1 AND V04.dat_ende >= DATE('2015-03-01') OR V04.mandant_id = 1 AND v05.asgs_flag
            IS NULL AND V04.dat_ende >= DATE('2015-06-01') OR V04.mandant_id = 2 AND V04.dat_ende >= DATE('2015-03-01')
        OR V04.mandant_id = 3 AND V04.dat_ende >= DATE('2015-06-22') OR V04.mandant_id = 4 AND V04.dat_ende >= DATE('2019-10-31'
          ) OR V04.mandant_id = 5 AND V04.dat_ende >= DATE('2015-07-16') OR V04.mandant_id = 6 AND V04.dat_ende >= DATE('2015-10-29'
        ) OR V04.mandant_id = 7 AND V04.dat_ende >= DATE('2015-12-01') OR V04.mandant_id = 8 AND V04.dat_ende >= DATE('2015-12-01'
      ));