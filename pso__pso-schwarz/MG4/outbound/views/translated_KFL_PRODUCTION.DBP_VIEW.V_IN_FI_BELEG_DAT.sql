CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_fi_beleg_dat (mandant_id, buchungskreis_id, in_fi_beleg_id,
in_fi_beleg_pos_id, gj, dat_buch, dat_beleg, dat_basis, in_lief_id, sonder_hauptbuch_kz, td_update, td_insert) AS SELECT
 mandant_id,
 buchungskreis_id,
 in_fi_beleg_id,
 in_fi_beleg_pos_id,
 gj,
 dat_buch,
 dat_beleg,
 dat_basis,
 in_lief_id,
 sonder_hauptbuch_kz,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_fi_beleg_dat;