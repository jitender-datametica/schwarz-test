-- 2026-03-25, dknop, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_transportation_unit_kosten_1 (mandant_id
, wup_id, nb_id, transportation_unit_id, kj_transportation_unit, wrg_id, betrag_diesel, betrag_strom, betrag_gas,
betrag_maut, betrag_kuehlung, betrag_sonstiges, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_view.v_transportation_unit_kosten_1;
