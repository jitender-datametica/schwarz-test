CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_ims_psp_ele_anwenderstat_zu AS SELECT V01.mandant_id,
 V01.psp_id,
 COALESCE(V02.anwenderstatus_id, 'E0001') AS anwenderstatus_id
FROM kfl_production_dbp_view.v_in_psp_element AS V01
 LEFT JOIN kfl_production_dbp_view.v_ims_psp_ele_anwenderstat_zu AS V02 ON V01.psp_id = V02.psp_id AND V01.mandant_id =
   V02.mandant_id
WHERE V01.statistisch_fg = 1;