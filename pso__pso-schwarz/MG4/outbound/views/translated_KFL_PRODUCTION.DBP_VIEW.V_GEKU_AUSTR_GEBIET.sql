CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_austr_gebiet (wmd_austraeger_gebiet_uid, gebiets_bereich_uid,
auflage, solo_fg, wmd_austr_gebiet_bez, austr_gebiet_lfd_nr, td_update, td_insert) AS SELECT wmd_austraeger_gebiet_uid,
 gebiets_bereich_uid,
 auflage,
 solo_fg,
 wmd_austr_gebiet_bez,
 austr_gebiet_lfd_nr,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_austr_gebiet;