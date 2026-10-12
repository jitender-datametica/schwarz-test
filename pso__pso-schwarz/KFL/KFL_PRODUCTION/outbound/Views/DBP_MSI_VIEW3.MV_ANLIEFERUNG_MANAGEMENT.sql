-- wenn CROSS JOIN, dann wird Entladedauer aus Kopf vervielfacht (in det gibt es mehrere Einträge mit Lagernummer pro anlieferung_id

-- 13.03.2017, INC1028275, Lagernummer aufgenommen, damit in Bericht-SQL kein CROSS JOIN zu anlieferung_management_det erforderlich ist

-- 15.12.2016, AP0013930, SPEC0016091 - Mercareon Detail

-- 21.03.2018, AP0025826, SPEC0035365 - difference between datzeit_entl_gebucht and datzeit_ankunft in minutes

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_anlieferung_management (anlieferung_id, mandant_id,
entladestelle_id, datzeit_entl_gebucht, dat_entl_gebucht, datzeit_ankunft, datzeit_tor, datzeit_entl_beginn,
datzeit_entl_ende, datzeit_ausfahrt, anlieferung_status1_id, anlieferung_status2_id, sako_fg, retoure_kz,
anlieferung_spediteur_id, wup_id, nb_id, lagernummer_id, entladedauer_min, gebucht_ankunft_min) AS SELECT V01.anlieferung_id
 ,
 V01.mandant_id,
 V01.entladestelle_id,
 V01.datzeit_entl_gebucht,
 DATE(V01.datzeit_entl_gebucht) AS dat_entl_gebucht,
 V01.datzeit_ankunft,
 V01.datzeit_tor,
 V01.datzeit_entl_beginn,
 V01.datzeit_entl_ende,
 V01.datzeit_ausfahrt,
 V01.anlieferung_status1_id,
 V01.anlieferung_status2_id,
 V01.sako_fg,
 V01.retoure_kz,
 V01.anlieferung_spediteur_id,
 v02.wup_id,
 v02.nb_id,
 v02.lagernummer_id,
 CAST(CASE
   WHEN V01.datzeit_entl_beginn IS NOT NULL AND V01.datzeit_entl_ende > V01.datzeit_entl_beginn
   THEN 
CAST(
  INT64(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(V01.datzeit_entl_ende, V01.datzeit_entl_beginn, SECOND)).DAY) * 1440 + 
  INT64(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(V01.datzeit_entl_ende, V01.datzeit_entl_beginn, SECOND)).HOUR) * 60 + 
  INT64(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(V01.datzeit_entl_ende, V01.datzeit_entl_beginn, SECOND)).MINUTE)
AS BIGNUMERIC)
   ELSE 0
   END AS BIGNUMERIC) AS entladedauer_min,
 CAST(CASE
   WHEN V01.datzeit_entl_gebucht IS NOT NULL AND V01.datzeit_ankunft IS NOT NULL
   THEN
CAST(
  INT64(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(V01.datzeit_entl_gebucht, V01.datzeit_ankunft, SECOND)).DAY)* 1440 +               INT64(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(V01.datzeit_entl_gebucht, V01.datzeit_ankunft, SECOND)).HOUR) * 60 + 
   INT64(snowconvert_public.time_part_to_variant(TIMESTAMP_DIFF(V01.datzeit_entl_gebucht, V01.datzeit_ankunft, SECOND)).MINUTE)
AS BIGNUMERIC)
   ELSE 0
   END AS BIGNUMERIC) AS gebucht_ankunft_min
FROM kfl_production_dbp_view.v_anlieferung_management AS V01
 INNER JOIN (SELECT mandant_id,
   anlieferung_id,
   wup_id,
   nb_id,
   lagernummer_id
  FROM kfl_production_dbp_view.v_anlieferung_management_det
  GROUP BY mandant_id,
   anlieferung_id,
   lagernummer_id,
   wup_id,
   nb_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.anlieferung_id = v02.anlieferung_id;