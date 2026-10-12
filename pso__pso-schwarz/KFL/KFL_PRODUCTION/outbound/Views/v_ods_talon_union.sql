CREATE OR REPLACE VIEW kfl_production_dbp_spezial.v_ods_talon_union (mandant_id, talon_id, wup_id, talon_dat,
talon_booking) AS SELECT mandant_id,
 talon_id,
 wup_id,
 talon_dat,
 talon_booking
FROM kfl_production_dbp_ods.ods_talon
UNION ALL
SELECT mandant_id,
 talon_id,
 wup_id,
 talon_dat,
 talon_booking
FROM kfl_production_dbp_ods_archiv.ods_talon;