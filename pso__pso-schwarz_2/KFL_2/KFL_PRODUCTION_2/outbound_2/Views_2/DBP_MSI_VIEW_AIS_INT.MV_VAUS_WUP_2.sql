CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_vaus_wup_2 (mandant_id, nb_id, land_id, wup_id,
buchungskreis_id, gln_id) AS SELECT V01.mandant_id,
 V01.nb_id,
 V01.land_id,
 V01.wup_id,
 V01.buchungskreis_id,
 V02.gln_id
FROM kfl_production_dbp_view.v_wup_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_vaus_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
WHERE V01.nb_id <> 99
 AND NOT V01.wup_id BETWEEN 1 AND 999;