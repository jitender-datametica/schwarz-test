CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_lin_kursgruppen_mapping_2 (mandant_id, lin_kursgruppe_id,
lin_kurs_id) AS SELECT mandant_id,
 lin_kursgruppe_id,
 lin_kurs_id
FROM kfl_production_dbp_view.v_l_lin_kurs_2
WHERE lin_bericht <> 'PRG';