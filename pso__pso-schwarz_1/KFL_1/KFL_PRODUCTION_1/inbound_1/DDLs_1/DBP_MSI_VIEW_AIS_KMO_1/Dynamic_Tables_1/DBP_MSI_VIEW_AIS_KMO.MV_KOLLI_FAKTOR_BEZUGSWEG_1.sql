CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_KOLLI_FAKTOR_BEZUGSWEG_1
(
  mandant_id
, art_id
, kolli_faktor
, bezugsweg_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
  v02.mandant_id,
   v02.art_id,
   COALESCE(v03.umrech_faktor, 1) AS kolli_faktor,
   v02.bezugsweg_id
  FROM
  (
  SELECT
  art_id,
   mandant_id,
   menge_einh_id,
   bezugsweg_id
  FROM
  (
  SELECT
  art_id,
   mandant_id,
   best_menge_einh_id AS menge_einh_id,
   1 AS bezugsweg_id
  FROM dbp_view.v_art_1
  WHERE dat_bis = '9999-12-31'
  AND mandant_id <> 1
  UNION ALL
  SELECT
  art_id,
   mandant_id,
   ausg_menge_einh_id AS menge_einh_id,
   4 AS bezugsweg_id
  FROM dbp_view.v_art_vorschlagswert_per_1
  WHERE dat_bis = '9999-12-31'
  AND mandant_id <> 1
  ) v01
  ) v02
   LEFT OUTER JOIN
   (
   SELECT
   art_id,
   mandant_id,
   altnv_menge_einh_id,
   umrech_faktor
  FROM dbp_view.v_art_umrechnung_faktor_per_1
  WHERE dat_bis = '9999-12-31'
  AND mandant_id <> 1
  ) v03
   ON v02.art_id = v03.art_id
   AND v02.mandant_id = v03.mandant_id
   AND v02.menge_einh_id = v03.altnv_menge_einh_id

   WHERE v02.mandant_id <> 1;