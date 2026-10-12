CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_wup_vorstand_zu_per_2 AS SELECT zustaendig_id AS mitarbeiter_id
 ,
 mandant_id,
 immo_objekt_id,
 dat_von,
 dat_bis,
 buchungskreis_id,
 kostenstelle_id
FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_2 AS O
WHERE zustaendig_typ_id = 1
 AND dat_bis = DATE '9999-12-31';