CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kondit_vorgang AS SELECT mandant_id,
 beleg_kondition_id,
 beleg_kondition_pos_id,
 betrag_beleg_kondition,
 wrg_id,
 kondition_preis_einh_id,
 system_id,
 beleg_konditionsart_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kondit_vorgang;