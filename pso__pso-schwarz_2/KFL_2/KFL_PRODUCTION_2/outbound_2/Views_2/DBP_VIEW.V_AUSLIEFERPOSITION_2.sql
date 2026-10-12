CREATE OR REPLACE VIEW kfl_production_dbp_view.v_auslieferposition_2 AS SELECT mandant_id,
 beleg_guid,
 beleg_pos_guid,
 belegtyp_id,
 beleg_id,
 manuell_erzeugt_fg,
 beleg_pos_id,
 tor_id,
 datzeit_erstellung,
 datzeit_aenderung,
 dat_lief_soll,
 zeit_lief_soll
FROM kfl_production_dbp_data.auslieferposition_2;