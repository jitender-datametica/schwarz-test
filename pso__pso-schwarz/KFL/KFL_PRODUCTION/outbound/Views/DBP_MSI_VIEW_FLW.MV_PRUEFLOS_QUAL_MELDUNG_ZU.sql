CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_prueflos_qual_meldung_zu (mandant_id, prueflos_id,
qual_meldung_id) AS SELECT V01.mandant_id,
 V01.prueflos_id,
 MIN(V01.qual_meldung_id) AS qual_meldung_id
FROM kfl_production_dbp_view.v_flw_pruefmerkmal_ergebnis AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_pruef_los AS V02 ON V01.prueflos_id = V02.prueflos_id AND V01.mandant_id = V02
   .mandant_id
WHERE V01.qual_meldung_id <> 0
GROUP BY V01.mandant_id,
 V01.prueflos_id;