CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_beurteil_bereichsnote AS SELECT V01.bereichsnote_id,
 V01.mandant_id,
 V01.beurteilung_bereich_id,
 V01.beurteilung_id,
 V01.note_bereich,
 V01.eindruck_bereich,
 V02.dat_beurteilung,
 V02.sb_checkliste_typ_id
FROM kfl_production_dbp_view.v_sb_beurteil_bereichsnote AS V01
 INNER JOIN kfl_production_dbp_view.v_sb_beurteilung AS V02 ON V01.beurteilung_id = V02.beurteilung_id
WHERE V02.loesch_fg = 0;