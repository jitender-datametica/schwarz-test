CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rueckfuehrung_eps_pal_art AS SELECT mandant_id,
 handling_unit_id_ext,
 art_id,
 dat_erfassung,
 menge,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rueckfuehrung_eps_pal_art;