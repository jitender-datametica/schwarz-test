CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_frage_2 (frage_id, umfrage_id, frage_ex_typ, frage_status
) AS SELECT frage_id,
 umfrage_id,
 frage_ex_typ,
 frage_status
FROM kfl_production_dbp_view.v_mcx_l_frage_2;