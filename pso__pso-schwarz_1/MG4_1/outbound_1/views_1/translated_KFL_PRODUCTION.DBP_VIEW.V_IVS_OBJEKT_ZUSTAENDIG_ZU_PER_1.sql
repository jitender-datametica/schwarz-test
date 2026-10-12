CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_1 (mandant_id, immo_objekt_id,
zustaendig_typ_id, dat_von, zustaendig_id, dat_bis, kostenstelle_id, buchungskreis_id) AS SELECT mandant_id,
 immo_objekt_id,
 zustaendig_typ_id,
 dat_von,
 zustaendig_id,
 dat_bis,
 kostenstelle_id,
 buchungskreis_id
FROM kfl_production_dbp_data.ivs_objekt_zustaendig_zu_per_1;