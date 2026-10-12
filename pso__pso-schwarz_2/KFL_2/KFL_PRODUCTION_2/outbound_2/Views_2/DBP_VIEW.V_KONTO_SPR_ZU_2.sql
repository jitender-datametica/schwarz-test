CREATE OR REPLACE VIEW kfl_production_dbp_view.v_konto_spr_zu_2 AS SELECT konto_id,
 spr_id,
 arthiertyp_id,
 mandant_id,
 konto_bez
FROM kfl_production_dbp_data.konto_spr_zu_2;