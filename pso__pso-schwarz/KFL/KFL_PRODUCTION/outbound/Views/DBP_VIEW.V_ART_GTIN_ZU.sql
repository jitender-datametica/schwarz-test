CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_gtin_zu AS SELECT mandant_id,
 art_id,
 altnv_menge_einh_id,
 lfd_nr,
 gtin_id,
 gtin_typ_kz,
 haupt_gtin_fg
FROM kfl_production_dbp_data.art_gtin_zu;