CREATE OR REPLACE VIEW kfl_production_dbp_view.v_disposition_rhythmus_ltf_spr_zu_1 AS SELECT mandant_id,
 spr_id,
 disposition_rhythmus_ltf_id,
 disposition_rhythmus_ltf_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.disposition_rhythmus_ltf_spr_zu_1;