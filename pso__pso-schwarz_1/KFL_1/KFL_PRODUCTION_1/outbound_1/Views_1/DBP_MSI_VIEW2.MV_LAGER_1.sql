CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_lager_1 (lager_id, mandant_id, nb_id, wup_typ_id, wup_standort,
vz_wup_id, zu_id) AS SELECT V01.wup_id AS lager_id,
 V01.mandant_id,
 V01.nb_id,
 V01.wup_typ_id,
 V01.wup_standort,
 V01.vz_wup_id,
 ROUND(CAST(V02.zu_id AS BIGNUMERIC), 0) AS zu_id
FROM kfl_production_dbp_view.v_wup_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_view2.mv_vz_zuordnung_1 AS V02 ON V01.wup_id = V02.wup_id
WHERE V01.wup_typ_id = 1
 AND V01.mandant_id = 1;