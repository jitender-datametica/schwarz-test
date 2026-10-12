CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_sendung_handlingunit_zu_2 (mandant_id, belos_vorgang_id,
handling_unit_id_ext) AS SELECT mandant_id,
 belos_vorgang_id,
 handling_unit_id_ext
FROM kfl_production_dbp_view.v_besch_lief_2
WHERE lief_typ_id = 'YCD2'
 AND wup_id_cd > - 1
 AND handling_unit_id_ext > '-1'
 AND belos_vorgang_id <> 0;