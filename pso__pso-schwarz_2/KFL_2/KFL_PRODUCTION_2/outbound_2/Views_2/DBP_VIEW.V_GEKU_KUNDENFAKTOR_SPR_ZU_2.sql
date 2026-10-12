CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_kundenfaktor_spr_zu_2 AS SELECT kundenfaktor_id,
 spr_id,
 kf_kommentar,
 kf_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_kundenfaktor_spr_zu_2;