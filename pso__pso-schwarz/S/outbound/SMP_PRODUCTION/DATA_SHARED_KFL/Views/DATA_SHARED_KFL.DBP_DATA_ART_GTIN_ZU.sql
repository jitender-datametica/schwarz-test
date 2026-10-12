CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_art_gtin_zu (mandant_id, art_id, altnv_menge_einh_id,
lfd_nr, gtin_id, gtin_typ_kz, haupt_gtin_fg, td_insert, td_update) AS SELECT mandant_id,
 art_id,
 altnv_menge_einh_id,
 lfd_nr,
 gtin_id,
 gtin_typ_kz,
 haupt_gtin_fg,
 td_insert,
 td_update
FROM kfl_production_dbp_data.art_gtin_zu;