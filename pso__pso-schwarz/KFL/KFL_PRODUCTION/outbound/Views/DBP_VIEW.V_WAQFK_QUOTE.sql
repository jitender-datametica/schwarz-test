CREATE OR REPLACE VIEW kfl_production_dbp_view.v_waqfk_quote AS SELECT waqfk_quote.mandant_id,
 waqfk_quote.lagernummer_id,
 waqfk_quote.wup_id,
 waqfk_quote.nb_id,
 waqfk_quote.waqfk_quote,
 waqfk_quote.td_update,
 waqfk_quote.td_insert
FROM kfl_production_dbp_data.waqfk_quote AS waqfk_quote;