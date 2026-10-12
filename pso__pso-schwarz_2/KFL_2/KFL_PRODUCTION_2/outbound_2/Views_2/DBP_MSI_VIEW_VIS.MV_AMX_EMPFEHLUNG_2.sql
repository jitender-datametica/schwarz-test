CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_empfehlung_2 (empfehlung_id, empfehlung_nr, feststellung_id
, dat_soll, dat_abschluss, zustand_id) AS SELECT V01.empfehlung_id,
 V01.empfehlung_nr,
 V01.feststellung_id,
 V01.dat_soll,
 V01.dat_abschluss,
 V01.zustand_id
FROM kfl_production_dbp_view.v_amx_empfehlung_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_amx_feststellung_2 AS V02 ON V01.feststellung_id = V02.feststellung_id AND V02.amx_system_id
    = 1
 INNER JOIN kfl_production_dbp_view.v_amx_frage_2 AS V03 ON V02.amx_frage_id = V03.amx_frage_id AND V03.amx_system_id = 1
 INNER JOIN kfl_production_dbp_view.v_amx_pruef_kapitel_2 AS V04 ON V03.pruef_kapitel_id = V04.pruef_kapitel_id AND V04.amx_system_id
    = 1
 INNER JOIN kfl_production_dbp_view.v_amx_pruefung_2 AS V05 ON V04.pruefung_id = V05.pruefung_id AND V05.amx_system_id = 1
   
 INNER JOIN kfl_production_dbp_view.v_amx_b_process_pruefung_zu_2 AS V06 ON V05.pruefung_id = V06.pruefung_id AND V06.business_process_id
     = 544687 AND V06.amx_system_id = 1
WHERE V05.zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041)
 AND V01.amx_system_id = 1;