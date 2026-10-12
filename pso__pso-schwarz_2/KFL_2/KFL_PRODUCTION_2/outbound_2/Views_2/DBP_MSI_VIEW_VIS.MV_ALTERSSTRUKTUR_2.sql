CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_altersstruktur_2 AS SELECT altersstruktur_tag_id,
 altersstruktur_woche_id,
 altersstruktur_monat_id,
 mandant_id,
 nb_id,
 wup_id
FROM kfl_production_dbp_msi_v_view.v_altersstruktur_eis_2;