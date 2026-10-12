CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ereignis_spr_zu_2 AS SELECT ereignis_id,
 ereignistyp_id,
 spr_id,
 mandant_id,
 ereignis_bez_lang,
 ereignis_bez_mittel,
 ereignis_bez_kurz
FROM kfl_production_dbp_data.ereignis_spr_zu_2;