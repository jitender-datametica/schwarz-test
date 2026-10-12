CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aktion_wme_ame AS SELECT mandant_id,
 aktion_id,
 aktionsart_id,
 zusatzinfo,
 dat_von,
 dat_bis,
 td_insert,
 td_update
FROM kfl_production_dbp_data.aktion_wme_ame;