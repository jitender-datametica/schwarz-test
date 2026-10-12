CREATE OR REPLACE VIEW kfl_production_dbp_view.v_abschriftart_int_zu_2 (mandant_id, abschriftart_id, abschriftart_int_id)
AS SELECT mandant_id,
 abschriftart_id,
 abschriftart_int_id
FROM kfl_production_dbp_data.abschriftart_int_zu_2;