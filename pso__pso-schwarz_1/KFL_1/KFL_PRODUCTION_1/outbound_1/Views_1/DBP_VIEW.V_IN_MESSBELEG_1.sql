CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_messbeleg_1 AS SELECT mandant_id,
 messbeleg_id,
 auftrag_id,
 auftrag_nr,
 messpunkt_id,
 dat_messung,
 messwert,
 menge_einh_id_messung
FROM kfl_production_dbp_data.in_messbeleg_1;