CREATE OR REPLACE VIEW kfl_production_dbp_view.v_beurteilung_detailnote_1 AS SELECT detailnote_id,
 beurteilung_id,
 mandant_id,
 beurteilung_detail_id,
 note_detail,
 eindruck_detail
FROM kfl_production_dbp_data.beurteilung_detailnote_1;