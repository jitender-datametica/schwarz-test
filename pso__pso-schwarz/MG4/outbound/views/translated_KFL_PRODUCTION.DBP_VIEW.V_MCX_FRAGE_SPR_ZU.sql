CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_frage_spr_zu (frage_id, spr_id, umfrage_id, frage_bez, frage_typ,
frage_alias, frage_s_code) AS SELECT frage_id,
 spr_id,
 umfrage_id,
 frage_bez,
 frage_typ,
 frage_alias,
 frage_s_code
FROM kfl_production_dbp_data.mcx_frage_spr_zu;