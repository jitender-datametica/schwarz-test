CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_markt_vz_zu (mandant_id, vz_wup_id, nb_vz_wup_id, wup_id,
nb_wup_id, entfernung, direkte_zuordnung_fg) AS SELECT V01.mandant_id,
 V01.vz_wup_id,
 - 111 AS nb_vz_wup_id,
 V02.aktuell_wup_id AS wup_id,
 0 AS nb_wup_id,
 V01.entfernung,
 V01.direkte_zuordnung_fg
FROM kfl_production_dbp_view.v_markt_vz_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id AND (V02
      .nb_id IN (2, 0, - 111) AND V02.wup_id > 0 OR V02.nb_id = - 1 AND V02.wup_id = 0)
UNION DISTINCT
SELECT V01.mandant_id,
 V01.vz_wup_id,
 - 111 AS nb_vz_wup_id,
 V02.aktuell_wup_id AS wup_id,
 0 AS nb_wup_id,
 V01.entfernung,
 0 AS direkte_zuordnung_fg
FROM kfl_production_dbp_view.v_markt_vz_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id AND (V02
      .nb_id IN (2, 0, - 111) AND V02.wup_id > 0 OR V02.nb_id = - 1 AND V02.wup_id = 0)
WHERE V01.direkte_zuordnung_fg = 1;