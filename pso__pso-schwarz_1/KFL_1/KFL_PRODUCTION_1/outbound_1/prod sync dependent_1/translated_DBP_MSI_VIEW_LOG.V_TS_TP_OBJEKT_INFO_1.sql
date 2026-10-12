CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.v_ts_tp_objekt_info_1 (mandant_id, tp_objekt_id, tp_objekt_typ,
gebaeude_bez, anlage_bez, anlagengruppe_bez, anlagenteil_bez) AS SELECT mandant_id,
 tp_objekt_id,
 tp_objekt_typ,
 gebaeude_bez,
 anlage_bez,
 anlagengruppe_bez,
 anlagenteil_bez
FROM kfl_production_dbp_msi_view_log.ts_tp_objekt_info_1;