CREATE OR REPLACE VIEW kfl_production_dbp_view.v_dra_wup_tag AS SELECT mandant_id,
 wup_id,
 dat,
 betrag_dra,
 anz_bon,
 wrg_id
FROM kfl_production_dbp_data.dra_wup_tag;