CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sb_beurteil_detailnote_2 AS SELECT detailnote_id,
 mandant_id,
 bereichsnote_id,
 note_detail,
 eindruck_detail,
 beurteilung_detail_id
FROM kfl_production_dbp_data.sb_beurteil_detailnote_2;