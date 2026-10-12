CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_austr_gebiet_1 (wmd_austraeger_gebiet_uid,
gebiets_bereich_uid, auflage, solo_fg, wmd_austr_gebiet_bez, austr_gebiet_lfd_nr) AS SELECT wmd_austraeger_gebiet_uid,
 gebiets_bereich_uid,
 auflage,
 solo_fg,
 wmd_austr_gebiet_bez,
 austr_gebiet_lfd_nr
FROM kfl_production_dbp_view.v_geku_austr_gebiet_1;