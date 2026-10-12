CREATE OR REPLACE VIEW kfl_production_dbp_view.v_beleg_typ_spr_zu_2 AS SELECT system_id,
 mandant_id,
 beleg_typ_id,
 spr_id,
 beleg_typ_bez
FROM kfl_production_dbp_data.beleg_typ_spr_zu_2;