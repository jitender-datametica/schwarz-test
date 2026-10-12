CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_nachlieferung_1 AS SELECT V1.nachlieferung_request_id,
 V1.mandant_id,
 V1.gp_exp_name,
 V1.dat_start,
 V1.anzahl_dateien,
 V1.ldap_user AS user_id,
 V1.wup_id,
 0 AS nb_id,
 V1.art_id,
 V1.datzeit_insert,
 V1.datzeit_update,
 V1.active_fg,
 V1.gp_id,
 V1.periodizitaet,
 TRIM(CAST(V2.kl_art_id AS STRING FORMAT '00000000')) AS kl_art_id_lang,
 v3.art_bez,
 v3.art_bez_de,
 v3.art_bez_cz,
 v3.art_bez_sk,
 v3.art_bez_hr,
 v3.art_bez_pl,
 v3.art_bez_ro,
 v3.art_bez_bg
FROM kfl_production_dbp_msi_v_view.v_ts_nachlieferung_1 AS V1
 LEFT JOIN kfl_production_dbp_view.v_art_1 AS V2 ON V1.art_id = V2.art_id AND V1.mandant_id = V2.mandant_id
 LEFT JOIN (SELECT V01.mandant_id,
   V01.art_id,
   V02.kl_art_id,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 22
      THEN V01.art_bez
      ELSE NULL
      END), 'N/A') AS art_bez,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 22
      THEN V01.art_bez
      ELSE NULL
      END), 'N/A') AS art_bez_de,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 124
      THEN V01.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V01.spr_id = 22
       THEN V01.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_cz,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 108
      THEN V01.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V01.spr_id = 22
       THEN V01.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_sk,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 65
      THEN V01.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V01.spr_id = 22
       THEN V01.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_hr,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 90
      THEN V01.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V01.spr_id = 22
       THEN V01.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_pl,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 95
      THEN V01.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V01.spr_id = 22
       THEN V01.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_ro,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 18
      THEN V01.art_bez
      ELSE NULL
      END), COALESCE(MAX(CASE
       WHEN V01.spr_id = 22
       THEN V01.art_bez
       ELSE NULL
       END), 'N/A')) AS art_bez_bg
  FROM kfl_production_dbp_view.v_art_spr_zu_1 AS V01
   INNER JOIN kfl_production_dbp_view.v_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
  GROUP BY V01.mandant_id,
   V01.art_id,
   V02.kl_art_id) AS v3 ON V1.art_id = v3.art_id AND V1.mandant_id = v3.mandant_id;