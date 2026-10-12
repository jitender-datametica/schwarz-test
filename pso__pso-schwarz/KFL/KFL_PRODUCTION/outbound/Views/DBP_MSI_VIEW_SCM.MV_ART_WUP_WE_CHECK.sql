CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_wup_we_check AS SELECT V00.mandant_id,
 V00.wup_id,
 V00.nb_id,
 V00.art_id,
 MAX(CASE
   WHEN V03.menge_lagerbew_bme > 0
   THEN 1
   ELSE 0
   END) AS we_fg
FROM kfl_production_dbp_view.v_art_wup_status_per AS V00
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   art_id,
   menge_lagerbew_bme
  FROM kfl_production_dbp_view.v_lagerbew_det
  WHERE nb_id = - 111
   AND dat_buch BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) AND (CURRENT_DATE)
   AND (mandant_id = 1 AND lager_bewart_id IN ('101', '102', '901', '902', '905', '906', '913', '915') OR mandant_id <>
       1 AND lager_bewart_id IN ('101', '102', '901', '902'))) AS V03 ON V00.mandant_id = V03.mandant_id AND V00.wup_id
    = V03.wup_id AND V00.art_id = V03.art_id
WHERE V00.dat_bis = DATE('9999-12-31')
 AND V00.nb_id = - 111
GROUP BY V00.mandant_id,
 V00.wup_id,
 V00.nb_id,
 V00.art_id;