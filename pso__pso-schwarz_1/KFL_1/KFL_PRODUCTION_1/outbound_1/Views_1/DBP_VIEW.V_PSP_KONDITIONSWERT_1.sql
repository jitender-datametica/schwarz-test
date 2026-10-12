CREATE OR REPLACE VIEW kfl_production_dbp_view.v_psp_konditionswert_1 AS SELECT mandant_id,
 psp_id,
 wrg_id,
 betrag_konditionswert_gebucht,
 betrag_konditionswert_ungebucht,
 konditionsart_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.psp_konditionswert_1;