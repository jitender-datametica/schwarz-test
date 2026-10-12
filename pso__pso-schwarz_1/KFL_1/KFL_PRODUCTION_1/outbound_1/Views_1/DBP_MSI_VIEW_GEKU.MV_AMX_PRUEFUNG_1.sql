CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_pruefung_1 (pruefung_id, amx_system_id, pruefung_nr,
zustand_id, pruefung_bez, dat_start, dat_ende, revisor_id, pruefung_typ_id, pruefung_klasse_id, pruefung_ergebnis_wert,
pruefung_ergebnis_wert_oneamx, business_unit_id, mandant_id, wup_id, nb_id, zeitspanne, sec_kz) AS SELECT v01.pruefung_id
 ,
 v01.amx_system_id,
 v01.pruefung_nr,
 v01.zustand_id,
 v01.pruefung_bez,
 v01.dat_start,
 v01.dat_ende,
 v01.revisor_id,
 v01.pruefung_typ_id,
 v01.pruefung_klasse_id,
 v01.pruefung_ergebnis_wert,
 v01.pruefung_ergebnis_wert_oneamx,
 v01.business_unit_id,
 v01.mandant_id,
 V03.aktuell_wup_id AS wup_id,
 V03.nb_id,
 v01.zeitspanne,
 v01.sec_kz
FROM (SELECT pruefung_id,
    amx_system_id,
    pruefung_nr,
    zustand_id,
    pruefung_bez,
    dat_start,
    dat_ende,
    revisor_id,
    pruefung_typ_id,
    pruefung_klasse_id,
     CASE
     WHEN amx_system_id = 2
     THEN pruefung_ergebnis_wert
     ELSE 0
     END AS pruefung_ergebnis_wert,
     CASE
     WHEN amx_system_id = 1
     THEN pruefung_ergebnis_wert
     ELSE 0
     END AS pruefung_ergebnis_wert_oneamx,
    business_unit_id,
    mandant_id,
     CASE
     WHEN wup_id = - 1
     THEN 0
     ELSE wup_id
     END AS wup_id,
     CASE
     WHEN zeitspanne = '-1'
     THEN ''
     ELSE zeitspanne
     END AS zeitspanne,
    6 AS sec_kz
   FROM kfl_production_dbp_view.v_amx_pruefung_1
   UNION DISTINCT
   SELECT pruefung_id,
    1 AS amx_system_id,
    pruefung_nr,
    zustand_id,
    pruefung_bez,
    dat_start,
    dat_ende,
    revisor_id,
    pruefung_typ_id,
    pruefung_klasse_id,
    0 AS pruefung_ergebnis_wert,
    pruefung_ergebnis_wert AS pruefung_ergebnis_wert_oneamx,
    business_unit_id,
    mandant_id,
     CASE
     WHEN wup_id = - 1
     THEN 0
     ELSE wup_id
     END AS wup_id,
    '' AS zeitspanne,
    6 AS sec_kz
   FROM kfl_production_dbp_view.v_amx_de_pruefung_1) AS v01
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
   WHERE business_process_id IN (544687, 544691, 544689)) AS v02 ON v01.pruefung_id = v02.pruefung_id AND v01.amx_system_id
    = v02.amx_system_id
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V03 ON v01.wup_id = V03.wup_id AND v01.mandant_id = V03.mandant_id
WHERE (v01.amx_system_id = 2 AND v01.zustand_id IN (100003, 100004, 100005, 1001, 100025) OR v01.amx_system_id = 1 AND
     v01.zustand_id IN (100005, 1001, 100041))
 AND (v01.mandant_id = 1 AND v02.asgs_flag = 1 AND v01.dat_ende >= DATE('2015-03-01') OR v01.mandant_id = 1 AND v02.asgs_flag
            IS NULL AND v01.dat_ende >= DATE('2015-06-01') OR v01.mandant_id = 2 AND v01.dat_ende >= DATE('2015-03-01')
        OR v01.mandant_id = 3 AND v01.dat_ende >= DATE('2015-06-22') OR v01.mandant_id = 4 AND v01.dat_ende >= DATE('2019-10-31'
          ) OR v01.mandant_id = 5 AND v01.dat_ende >= DATE('2015-07-16') OR v01.mandant_id = 6 AND v01.dat_ende >= DATE('2015-10-29'
        ) OR v01.mandant_id = 7 AND v01.dat_ende >= DATE('2015-12-01') OR v01.mandant_id = 8 AND v01.dat_ende >= DATE('2015-12-01'
      ));