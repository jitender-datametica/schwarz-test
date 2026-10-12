CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_leistungsart_spr_zu AS SELECT co_leistungsart_id,
 spr_id,
 mandant_id,
 co_leistungsart_bez_kurz,
 co_leistungsart_bez_lang
FROM kfl_production_dbp_data.in_leistungsart_spr_zu;