CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_lieferant_ekorg_zu AS SELECT in_lief_id,
 einkaufsorganisation_id,
 mandant_id,
 loesch_fg,
 ek_sperr_fg,
 einkaeufer_grp_id,
 zahlungsziel_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_lieferant_ekorg_zu;