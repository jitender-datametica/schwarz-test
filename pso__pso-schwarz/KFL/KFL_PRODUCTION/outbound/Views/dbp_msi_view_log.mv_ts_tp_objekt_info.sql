CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ts_tp_objekt_info (mandant_id, tp_objekt_id, gebaeude_id,
gebaeude_bez, anlage_id, anlage_bez, anlagengruppe_id, anlagengruppe_bez, anlagenteil_id, anlagenteil_bez) AS SELECT V1
 .mandant_id,
 V1.tp_objekt_id,
 MAX(COALESCE(NULLIF(V2.gebaeude_bez, ''), '-1')) AS gebaeude_id,
 MAX(COALESCE(NULLIF(V2.gebaeude_bez, ''), '')) AS gebaeude_bez,
 MAX(CASE
   WHEN V1.tp_objekt_typ = '3'
   THEN 'FFZ'
   WHEN V1.tp_objekt_typ = '7'
   THEN 'Reinigung'
   ELSE COALESCE(NULLIF(V2.anlage_bez, ''), '-1')
   END) AS anlage_id,
 MAX(CASE
   WHEN V1.tp_objekt_typ = '3'
   THEN 'FFZ'
   WHEN V1.tp_objekt_typ = '7'
   THEN 'Reinigung'
   ELSE COALESCE(NULLIF(V2.anlage_bez, ''), '')
   END) AS anlage_bez,
 MAX(COALESCE(CASE
    WHEN V2.anlagengruppe_bez = '' OR V2.anlagengruppe_bez = '-'
    THEN NULL
    ELSE V2.anlagengruppe_bez
    END, '-1')) AS anlagengruppe_id,
 MAX(COALESCE(CASE
    WHEN V2.anlagengruppe_bez = '' OR V2.anlagengruppe_bez = '-'
    THEN NULL
    ELSE V2.anlagengruppe_bez
    END, '')) AS anlagengruppe_bez,
 MAX(COALESCE(CASE
    WHEN V2.anlagenteil_bez = '' OR V2.anlagenteil_bez = '-'
    THEN NULL
    ELSE V2.anlagenteil_bez
    END, '-1')) AS anlagenteil_id,
 MAX(COALESCE(CASE
    WHEN V2.anlagenteil_bez = '' OR V2.anlagenteil_bez = '-'
    THEN NULL
    ELSE V2.anlagenteil_bez
    END, '')) AS anlagenteil_bez
FROM kfl_production_dbp_view.v_tp_objekt_per AS V1
 LEFT JOIN kfl_production_dbp_msi_view_log.v_ts_tp_objekt_info AS V2 ON V1.mandant_id = V2.mandant_id AND V1.tp_objekt_id
     = V2.tp_objekt_id AND V1.dat_bis = DATE '9999-12-31'
GROUP BY V1.mandant_id,
 V1.tp_objekt_id;