CREATE OR REPLACE VIEW dbp_msi_view_rpw_dt.mv_l_absender_aktuell (aktuell_wup_id, mandant_id, wup_standort) AS SELECT
 V01.aktuell_wup_id,
 V01.mandant_id,
 MAX(V01.wup_standort) AS wup_standort
FROM kfl_production_dbp_view.v_wup AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id_alt AND
   V01.nb_id = V02.nb_id
WHERE V01.mandant_id = 1
 AND V02.wup_id_alt IS NULL
 AND (V01.nb_id <> -111 OR V01.wup_typ_id NOT IN (1, 2))
 AND V01.nb_id <> 99
GROUP BY V01.aktuell_wup_id,
 V01.mandant_id;