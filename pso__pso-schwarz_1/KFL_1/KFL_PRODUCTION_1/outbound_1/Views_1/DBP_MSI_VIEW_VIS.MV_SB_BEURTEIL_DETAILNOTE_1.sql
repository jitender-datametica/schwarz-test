CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_beurteil_detailnote_1 AS SELECT V01.detailnote_id,
 V01.mandant_id,
 V01.bereichsnote_id,
 V01.note_detail,
 V01.eindruck_detail,
 V01.beurteilung_detail_id,
 V03.dat_beurteilung,
 V03.sb_checkliste_typ_id
FROM kfl_production_dbp_view.v_sb_beurteil_detailnote_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_sb_beurteil_bereichsnote_1 AS V02 ON V01.bereichsnote_id = V02.bereichsnote_id
 INNER JOIN kfl_production_dbp_view.v_sb_beurteilung_1 AS V03 ON V02.beurteilung_id = V03.beurteilung_id
WHERE V03.loesch_fg = 0;