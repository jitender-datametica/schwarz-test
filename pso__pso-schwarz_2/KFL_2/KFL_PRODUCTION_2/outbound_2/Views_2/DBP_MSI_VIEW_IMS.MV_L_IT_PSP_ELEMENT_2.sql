CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_it_psp_element_2 (mandant_id, it_psp_id, it_psp_id_char,
psp_bez, it_projekt_id, it_projekt_def) AS SELECT V02.mandant_id,
 V02.psp_id AS it_psp_id,
 V02.psp_id_char AS it_psp_id_char,
 V02.psp_bez,
 V02.psp_id_char AS it_projekt_id,
 V01.in_projekt_id_char AS it_projekt_def
FROM kfl_production_dbp_view.v_in_projekt_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_psp_element_2 AS V02 ON V01.in_projekt_id = V02.in_projekt_id AND V01.mandant_id
   = V02.mandant_id
WHERE V01.ims_projekt_typ_id = 'P'
 AND V02.statistisch_fg = 1;