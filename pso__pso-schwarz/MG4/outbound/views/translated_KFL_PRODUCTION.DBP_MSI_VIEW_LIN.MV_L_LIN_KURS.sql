CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_l_lin_kurs (mandant_id, lin_kurs_id, lin_kursgruppe_id, sortkz
, lin_bericht) AS SELECT mandant_id,
 lin_kurs_id,
 lin_kursgruppe_id,
 sortkz,
 lin_bericht
FROM kfl_production_dbp_view.v_l_lin_kurs AS v01
WHERE lin_bericht IN ('EWL', 'GSL')
 OR lin_bericht IS NULL;