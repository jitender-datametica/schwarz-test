CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_woche_wup_ereignis_zu_1 AS SELECT mandant_id,
 art_id,
 kjwo,
 wup_id,
 nb_id,
 ereignis_id,
 ereignistyp_id
FROM kfl_production_dbp_data.art_woche_wup_ereignis_zu_1;