-- ZUORDNUNG Abschriftart - Abschriftart INTEGER
 -- 2017-0221 : Initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 (mandant_id, abschriftart_id,
abschriftart_int_id) AS SELECT mandant_id,
 abschriftart_id,
 abschriftart_int_id
FROM kfl_production_dbp_view.v_abschriftart_int_zu_2 AS AIZ;