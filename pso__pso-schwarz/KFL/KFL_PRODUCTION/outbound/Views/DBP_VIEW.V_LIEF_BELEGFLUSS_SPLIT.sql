CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lief_belegfluss_split AS SELECT mandant_id,
 lief_beleg_id,
 lief_beleg_gruppe_id,
 lief_beleg_pos_id,
 lief_beleg_split_id,
 lief_beleg_split_pos_id,
 split_fortschreibung_kz,
 menge_lief_ist_lme,
 split_lfd_nr_id,
 split_vorgang_id
FROM kfl_production_dbp_data.lief_belegfluss_split;