CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_ticket_zusatzinfo_zu_1 AS SELECT geku_ticket_id,
 zusatzinfo_id,
 zusatzinfo_sel_id,
 zusatzinfo_text,
 zusatzinfo_date,
 zusatzinfo_ganzzahl,
 zusatzinfo_float,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_ticket_zusatzinfo_zu_1;