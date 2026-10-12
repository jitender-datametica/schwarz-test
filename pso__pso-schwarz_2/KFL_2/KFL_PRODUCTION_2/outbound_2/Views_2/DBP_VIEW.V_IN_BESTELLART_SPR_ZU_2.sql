CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_bestellart_spr_zu_2 AS SELECT mandant_id,
 bestellart_id,
 spr_id,
 bestell_typ_id,
 bestellart_bez
FROM kfl_production_dbp_data.in_bestellart_spr_zu_2;