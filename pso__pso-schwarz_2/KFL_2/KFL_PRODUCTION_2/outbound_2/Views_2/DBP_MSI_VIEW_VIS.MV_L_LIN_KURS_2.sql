CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_lin_kurs_2 (mandant_id, lin_kurs_id, lin_kursgruppe_id, sortkz
, lin_bericht) AS SELECT mandant_id,
 lin_kurs_id,
 lin_kursgruppe_id,
 sortkz,
 COALESCE(lin_bericht, '') AS lin_bericht
FROM kfl_production_dbp_view.v_l_lin_kurs_2 AS V01
WHERE lin_bericht = 'EWL'
 OR lin_bericht = 'GSL'
 OR lin_bericht = 'UWU'
 OR lin_bericht = 'VIS';