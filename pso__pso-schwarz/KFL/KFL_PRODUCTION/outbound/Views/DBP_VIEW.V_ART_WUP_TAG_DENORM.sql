CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_tag_denorm AS SELECT art_id,
 mandant_id,
 wup_id,
 dat,
 aktion_fg,
 dat_naechst_verkaufstag,
 td_insert,
 td_update
FROM kfl_production_dbp_data.art_wup_tag_denorm;