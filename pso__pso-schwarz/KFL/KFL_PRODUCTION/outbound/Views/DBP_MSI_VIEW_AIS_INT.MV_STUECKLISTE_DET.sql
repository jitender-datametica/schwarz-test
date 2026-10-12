CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_stueckliste_det AS SELECT V1.mandant_id,
 V1.stueckliste_id,
 V1.art_id,
 V1.stueckliste_pos_id,
 V1.stueckliste_typ_id,
 V1.komponentenmenge,
 v2.total_amount_display,
 CONCAT(CAST(V1.komponentenmenge / v2.total_amount_display * 100 AS BIGNUMERIC), '%') AS stueckliste_anteil,
 V1.komponentenmenge_einh_id,
 V1.dat_von,
 V1.dat_bis
FROM kfl_production_dbp_view.v_stueckliste_det AS V1
 INNER JOIN (SELECT mandant_id,
   stueckliste_id,
   SUM(komponentenmenge) AS total_amount_display
  FROM kfl_production_dbp_view.v_stueckliste_det
  GROUP BY mandant_id,
   stueckliste_id) AS v2 ON V1.mandant_id = v2.mandant_id AND V1.stueckliste_id = v2.stueckliste_id;