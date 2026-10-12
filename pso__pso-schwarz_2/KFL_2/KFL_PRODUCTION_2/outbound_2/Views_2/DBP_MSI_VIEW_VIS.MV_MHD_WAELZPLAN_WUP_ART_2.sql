CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mhd_waelzplan_wup_art_2 (mandant_id, wup_id, kjwo, art_id,
waelzplan_pruef_id, wiederholungsrhythmus_wochen, kjwo_wiederholung, dat_aenderung) AS SELECT WWA.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 WWA.kjwo,
 WWA.art_id,
 WWA.waelzplan_pruef_id,
 WWA.wiederholungsrhythmus_wochen,
 WWA.kjwo_wiederholung,
 WWA.dat_aenderung
FROM kfl_production_dbp_view.v_mhd_waelzplan_wup_art_2 AS WWA
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON WWA.mandant_id = WUP.mandant_id AND WWA.wup_id = WUP.wup_id;