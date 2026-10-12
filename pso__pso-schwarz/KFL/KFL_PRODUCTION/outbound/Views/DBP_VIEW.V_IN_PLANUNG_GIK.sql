CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_planung_gik AS SELECT mandant_id,
 psp_id,
 gesamt_investitions_kosten,
 wrg_id
FROM kfl_production_dbp_data.in_planung_gik;