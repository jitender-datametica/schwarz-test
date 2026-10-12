CREATE OR REPLACE VIEW kfl_production_dbp_view.v_anlage_klasse_zu_per AS SELECT anlage_id,
 anlage_sub_id,
 mandant_id,
 buchungskreis_id,
 anlage_klasse_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.anlage_klasse_zu_per;