CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_messbeleg (mandant_id, messbeleg_id, messbeleg_bez,
messpunkt_id, messpunkt_bez, messwert, menge_einh_id_messung, dat_messung, tp_objekt_id) AS SELECT IN_MESS.mandant_id,
 IN_MESS.messbeleg_id,
 CAST(IN_MESS.messbeleg_id AS STRING) AS messbeleg_bez,
 IN_MESS.messpunkt_id,
 CAST(IN_MESS.messpunkt_id AS STRING) AS messpunkt_bez,
 IN_MESS.messwert,
 IN_MESS.menge_einh_id_messung,
 in_mess_agg.dat_messung,
 IN_PUNKT.tp_objekt_id
FROM kfl_production_dbp_view.v_in_messbeleg AS IN_MESS
 INNER JOIN (SELECT mandant_id,
   messpunkt_id,
   MAX(messbeleg_id) AS messbeleg_id,
   MAX(dat_messung) AS dat_messung
  FROM kfl_production_dbp_view.v_in_messbeleg
  GROUP BY mandant_id,
   messpunkt_id) AS in_mess_agg ON IN_MESS.mandant_id = in_mess_agg.mandant_id AND IN_MESS.messpunkt_id = in_mess_agg.messpunkt_id
     AND IN_MESS.messbeleg_id = in_mess_agg.messbeleg_id
 LEFT JOIN kfl_production_dbp_view.v_in_messpunkt AS IN_PUNKT ON IN_MESS.messpunkt_id = IN_PUNKT.messpunkt_id AND
   IN_MESS.mandant_id = IN_PUNKT.mandant_id
UNION DISTINCT
SELECT mandant_id,
 - 1 AS messbeleg_id,
 'N/A' AS messbeleg_bez,
 - 1 AS messpunkt_id,
 'N/A' AS messpunkt_bez,
 CAST(NULL AS BIGNUMERIC) AS messwert,
 CAST(NULL AS STRING) AS menge_einh_id_messung,
 CAST(NULL AS DATE) AS dat_messung,
 tp_objekt_id
FROM kfl_production_dbp_view.v_tp_objekt_per AS TP_OB
WHERE dat_bis = DATE '9999-12-31'
 AND (tp_objekt_id, mandant_id) NOT IN (SELECT (IN_PUNKT.tp_objekt_id, IN_PUNKT.mandant_id)
   FROM kfl_production_dbp_view.v_in_messbeleg AS IN_MESS
    INNER JOIN kfl_production_dbp_view.v_in_messpunkt AS IN_PUNKT ON IN_MESS.messpunkt_id = IN_PUNKT.messpunkt_id AND
      IN_MESS.mandant_id = IN_PUNKT.mandant_id);