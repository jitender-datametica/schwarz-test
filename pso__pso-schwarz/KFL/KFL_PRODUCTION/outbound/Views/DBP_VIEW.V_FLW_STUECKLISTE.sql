CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_stueckliste AS SELECT stueckliste_id,
 stueckliste_typ_id,
 flw_art_id,
 werk_id,
 flw_stueckliste_verwendung_id,
 stueckliste_altnv_id,
 menge_basis,
 loesch_fg,
 loesch_vormerk_fg,
 system_id,
 mandant_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_stueckliste;