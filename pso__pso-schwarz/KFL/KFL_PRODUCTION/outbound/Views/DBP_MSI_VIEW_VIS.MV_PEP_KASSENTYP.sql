CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_pep_kassentyp AS SELECT mandant_id,
 nb_id,
 wup_id,
 pep_typ_id,
 kasse_von,
 kasse_bis
FROM kfl_production_dbp_msi_v_view.v_pep_kassentyp AS V01;