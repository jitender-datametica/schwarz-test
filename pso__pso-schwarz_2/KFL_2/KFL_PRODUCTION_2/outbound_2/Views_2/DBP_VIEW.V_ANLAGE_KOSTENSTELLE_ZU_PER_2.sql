CREATE OR REPLACE VIEW kfl_production_dbp_view.v_anlage_kostenstelle_zu_per_2 AS SELECT anlage_id,
 anlage_sub_id,
 mandant_id,
 buchungskreis_id,
 dat_von,
 dat_bis,
 kostenstelle_id,
 geschaeftsbereich_id,
 system_id
FROM kfl_production_dbp_data.anlage_kostenstelle_zu_per_2;