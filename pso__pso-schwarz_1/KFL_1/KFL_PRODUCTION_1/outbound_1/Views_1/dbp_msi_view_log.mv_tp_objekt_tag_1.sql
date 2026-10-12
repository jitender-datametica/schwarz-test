CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tp_objekt_tag_1 (mandant_id, tp_objekt_id, techn_platz_id,
tp_objekt_typ, bau_kj, bau_kjmo, bau_mo, bau_date, dat_gewaehrleistung_start, dat_gewaehrleistung_start_bez,
dat_gewaehrleistung_ende, dat_gewaehrleistung_ende_bez, tp_objekt_nr, abzugsdatum, werk_id, messwert, dat_messung,
tp_objekt_status_id_agg, tp_objekt_status_kbez_agg, tp_objekt_status_kbez_de_agg, tp_objekt_status_kbez_cz_agg,
tp_objekt_status_kbez_sk_agg, tp_objekt_status_kbez_hr_agg, tp_objekt_status_kbez_pl_agg, tp_objekt_status_kbez_ro_agg,
tp_objekt_status_kbez_bg_agg, gewahrleistung_fg) AS SELECT TP_O_PER.mandant_id,
 TP_O_PER.tp_objekt_id,
 TP_O_PER.techn_platz_id,
 TP_O_PER.tp_objekt_typ,
 IF(TP_O_PER.bau_kj = 0, NULL, TP_O_PER.bau_kj) AS bau_kj,
 TP_O_PER.bau_kjmo,
  CASE
  WHEN LENGTH(SUBSTR(CAST(TP_O_PER.bau_kjmo AS STRING), 1, 39)) = 6
  THEN RIGHT(SUBSTR(CAST(TP_O_PER.bau_kjmo AS STRING), 1, 39), 2)
  ELSE NULL
  END AS bau_mo,
  CASE
  WHEN LENGTH(SUBSTR(CAST(TP_O_PER.bau_kjmo AS STRING), 1, 39)) = 6
  THEN CASE
   WHEN RIGHT(SUBSTR(CAST(TP_O_PER.bau_kjmo AS STRING), 1, 39), 2) = '00'
   THEN NULL
   ELSE DATE(CONCAT(TP_O_PER.bau_kjmo, '01'))
   END
  ELSE NULL
  END AS bau_date,
 TP_O_PER.dat_gewaehrleistung_start,
  CASE
  WHEN TP_O_PER.dat_gewaehrleistung_start = DATE '1900-01-01'
  THEN NULL
  ELSE TP_O_PER.dat_gewaehrleistung_start
  END AS dat_gewaehrleistung_start_bez,
 TP_O_PER.dat_gewaehrleistung_ende,
  CASE
  WHEN TP_O_PER.dat_gewaehrleistung_ende = DATE '1900-01-01'
  THEN NULL
  ELSE TP_O_PER.dat_gewaehrleistung_ende
  END AS dat_gewaehrleistung_ende_bez,
 TP_O_PER.tp_objekt_nr,
 TAG.dat AS abzugsdatum,
 IN_W.werk_id,
 MAX(in_mess.messwert) AS messwert,
 MAX(in_mess.dat_messung) AS dat_messung,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_id, ' ' ORDER BY tp_obj_s.tp_objekt_status_id--, tp_obj_s.tp_objekt_status_id
   ) AS tp_objekt_status_id_agg,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_kbez, ' ' ORDER BY tp_obj_s.tp_objekt_status_kbez --IS NULL, tp_obj_s.tp_objekt_status_kbez
   ) AS tp_objekt_status_kbez_agg,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_kbez_de, ' ' ORDER BY tp_obj_s.tp_objekt_status_kbez_de --IS NULL, tp_obj_s.tp_objekt_status_kbez_de
   ) AS tp_objekt_status_kbez_de_agg,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_kbez_cz, ' ' ORDER BY tp_obj_s.tp_objekt_status_kbez_cz --IS NULL, tp_obj_s.tp_objekt_status_kbez_cz
 ) AS tp_objekt_status_kbez_cz_agg,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_kbez_sk, ' ' ORDER BY tp_obj_s.tp_objekt_status_kbez_sk --IS NULL, tp_obj_s.tp_objekt_status_kbez_sk
 ) AS tp_objekt_status_kbez_sk_agg,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_kbez_hr, ' ' ORDER BY tp_obj_s.tp_objekt_status_kbez_hr --IS NULL, tp_obj_s.tp_objekt_status_kbez_hr
 ) AS tp_objekt_status_kbez_hr_agg,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_kbez_pl, ' ' ORDER BY tp_obj_s.tp_objekt_status_kbez_pl --IS NULL, tp_obj_s.tp_objekt_status_kbez_pl
 ) AS tp_objekt_status_kbez_pl_agg,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_kbez_ro, ' ' ORDER BY tp_obj_s.tp_objekt_status_kbez_ro --IS NULL, tp_obj_s.tp_objekt_status_kbez_ro
 ) AS tp_objekt_status_kbez_ro_agg,
 STRING_AGG(DISTINCT tp_obj_s.tp_objekt_status_kbez_bg, ' ' ORDER BY tp_obj_s.tp_objekt_status_kbez_bg --IS NULL, tp_obj_s.tp_objekt_status_kbez_bg
 ) AS tp_objekt_status_kbez_bg_agg,
  CASE
  WHEN TAG.dat <= TP_O_PER.dat_gewaehrleistung_ende
  THEN 1
  ELSE 0
  END AS gewahrleistung_fg
FROM kfl_production_dbp_view.v_tp_objekt_per_1 AS TP_O_PER
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS TAG_1 ON TAG.dat BETWEEN TP_O_PER.dat_von AND TP_O_PER.dat_bis AND TAG.dat <=
   CURRENT_DATE
 INNER JOIN (SELECT TP_OBJ_S.mandant_id,
   TP_OBJ_S.tp_objekt_id,
   TP_OBJ_S.dat_von,
   TP_OBJ_S.dat_bis,
   TP_OBJ_S.tp_objekt_status_id,
   MAX(CASE
     WHEN TP_OBJ_S_SPR.spr_id = 22
     THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
     ELSE NULL
     END) AS tp_objekt_status_kbez,
   MAX(CASE
     WHEN TP_OBJ_S_SPR.spr_id = 22
     THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
     ELSE NULL
     END) AS tp_objekt_status_kbez_de,
   COALESCE(MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 124
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 22
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_cz,
   COALESCE(MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 108
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 22
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_sk,
   COALESCE(MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 65
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 22
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_hr,
   COALESCE(MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 90
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 22
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_pl,
   COALESCE(MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 95
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 22
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_ro,
   COALESCE(MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 18
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END), MAX(CASE
      WHEN TP_OBJ_S_SPR.spr_id = 22
      THEN TP_OBJ_S_SPR.tp_objekt_status_kbez
      ELSE NULL
      END)) AS tp_objekt_status_kbez_bg
  FROM kfl_production_dbp_view.v_tp_objekt_status_per_1 AS TP_OBJ_S
   INNER JOIN kfl_production_dbp_view.v_tp_objekt_status_spr_zu_1 AS TP_OBJ_S_SPR ON TP_OBJ_S.mandant_id = TP_OBJ_S_SPR.mandant_id
      AND TP_OBJ_S.tp_objekt_status_id = TP_OBJ_S_SPR.tp_objekt_status_id
  WHERE TP_OBJ_S.tp_objekt_status_fg = 0
  GROUP BY TP_OBJ_S.mandant_id,
   TP_OBJ_S.tp_objekt_id,
   TP_OBJ_S.dat_von,
   TP_OBJ_S.dat_bis,
   TP_OBJ_S.tp_objekt_status_id) AS tp_obj_s ON TAG.dat BETWEEN tp_obj_s.dat_von AND tp_obj_s.dat_bis AND TP_O_PER.tp_objekt_id
     = tp_obj_s.tp_objekt_id AND TP_O_PER.mandant_id = tp_obj_s.mandant_id
 LEFT JOIN (SELECT IN_MESS.mandant_id,
   IN_MESS.messbeleg_id,
   IN_MESS.messwert,
   IN_MESS.menge_einh_id_messung,
   IN_MESS.dat_messung,
   IN_PUNKT.tp_objekt_id
  FROM kfl_production_dbp_view.v_in_messbeleg_1 AS IN_MESS
   INNER JOIN kfl_production_dbp_view.v_in_messpunkt_1 AS IN_PUNKT ON IN_MESS.messpunkt_id = IN_PUNKT.messpunkt_id AND
     IN_MESS.mandant_id = IN_PUNKT.mandant_id) AS in_mess ON TP_O_PER.mandant_id = in_mess.mandant_id AND TP_O_PER.tp_objekt_id
     = in_mess.tp_objekt_id AND TAG.dat >= in_mess.dat_messung
 INNER JOIN kfl_production_dbp_view.v_techn_platz_per_1 AS TECH_PL ON TP_O_PER.mandant_id = TECH_PL.mandant_id AND
    TP_O_PER.techn_platz_id = TECH_PL.techn_platz_id AND TECH_PL.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_in_werk_1 AS IN_W ON TECH_PL.mandant_id = IN_W.mandant_id AND TECH_PL.werk_instandhaltung_plan
    = IN_W.werk_nr
GROUP BY TP_O_PER.mandant_id,
 TP_O_PER.tp_objekt_id,
 TP_O_PER.techn_platz_id,
 TP_O_PER.tp_objekt_typ,
 bau_kj,
 TP_O_PER.bau_kjmo,
 bau_mo,
 bau_date,
 TP_O_PER.dat_gewaehrleistung_start,
 dat_gewaehrleistung_start_bez,
 TP_O_PER.dat_gewaehrleistung_ende,
 dat_gewaehrleistung_ende_bez,
 TP_O_PER.tp_objekt_nr,
 abzugsdatum,
 IN_W.werk_id;