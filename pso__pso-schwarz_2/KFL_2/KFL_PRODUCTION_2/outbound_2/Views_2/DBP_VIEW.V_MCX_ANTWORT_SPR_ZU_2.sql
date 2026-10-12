CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_antwort_spr_zu_2 AS SELECT antwort_id,
 spr_id,
 umfrage_id,
 antwort_bez,
 antwort_datentyp
FROM kfl_production_dbp_data.mcx_antwort_spr_zu_2;