CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rueckfuehrung_lt_grund_2 AS SELECT mandant_id,
 tour_id,
 wup_id,
 nb_id,
 art_id,
 lagerbew_beleg_id,
 kj,
 lfnr,
 rueck_grund_id,
 dat_buch,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rueckfuehrung_lt_grund_2;