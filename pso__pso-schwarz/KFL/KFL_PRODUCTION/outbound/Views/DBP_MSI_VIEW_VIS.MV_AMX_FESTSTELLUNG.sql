CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_feststellung (feststellung_id, amx_frage_id,
feststellung_bez) AS SELECT V01.feststellung_id,
 V01.amx_frage_id,
 V01.feststellung_bez
FROM kfl_production_dbp_view.v_amx_feststellung AS V01
 INNER JOIN kfl_production_dbp_view.v_amx_frage AS V02 ON V01.amx_frage_id = V02.amx_frage_id AND V02.amx_system_id = 1
 INNER JOIN kfl_production_dbp_view.v_amx_pruef_kapitel AS V03 ON V02.pruef_kapitel_id = V03.pruef_kapitel_id AND V03.amx_system_id
    = 1
 INNER JOIN kfl_production_dbp_view.v_amx_pruefung AS V04 ON V03.pruefung_id = V04.pruefung_id AND V04.amx_system_id = 1
   
 INNER JOIN kfl_production_dbp_view.v_amx_b_process_pruefung_zu AS V05 ON V04.pruefung_id = V05.pruefung_id AND V05.business_process_id
     = 544687 AND V05.amx_system_id = 1
WHERE V04.zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041)
 AND V01.amx_system_id = 1;