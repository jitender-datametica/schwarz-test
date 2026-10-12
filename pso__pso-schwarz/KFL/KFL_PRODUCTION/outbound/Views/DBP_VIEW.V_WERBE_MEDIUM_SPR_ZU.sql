CREATE OR REPLACE VIEW kfl_production_dbp_view.v_werbe_medium_spr_zu AS SELECT mandant_id,
 medien_kz,
 spr_id,
 werbe_medium_bez
FROM kfl_production_dbp_data.werbe_medium_spr_zu;