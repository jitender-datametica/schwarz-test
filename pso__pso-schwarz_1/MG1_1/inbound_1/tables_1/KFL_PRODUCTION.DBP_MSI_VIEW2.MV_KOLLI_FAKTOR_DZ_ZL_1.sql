create or replace dynamic table MV_KOLLI_FAKTOR_DZ_ZL_1(
	MANDANT_ID,
	ART_ID,
	KOLLI_FAKTOR_DZ,
	KOLL_FAKTOR_ZL
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_P_DYNAMIC_TABLE_AIS_DE
 as
SELECT
bw.mandant_id,
bw.art_id,
SUM(CASE WHEN bw.bezugsweg_id = 1 THEN (COALESCE(kolli.umrech_faktor,1)) ELSE 0 END),
SUM(CASE WHEN bw.bezugsweg_id = 4 THEN (COALESCE(kolli.umrech_faktor,1)) ELSE 0 END)

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
   UNION ALL
   SELECT
   art_id,
   mandant_id,
   ausg_menge_einh_id AS menge_einh_id,
   4 AS bezugsweg_id
   FROM dbp_view.v_art_vorschlagswert_per_1
   WHERE
   dat_bis = '9999-12-31'
   )  subs
   ) bw
   LEFT JOIN
   (
   SELECT
   art_id,
   mandant_id,
   altnv_menge_einh_id,
   umrech_faktor
   FROM dbp_view.v_art_umrechnung_faktor_per_1
   WHERE dat_bis = '9999-12-31'
   ) kolli
   ON
   bw.art_id = kolli.art_id AND
   bw.mandant_id = kolli.mandant_id AND
   bw.menge_einh_id = kolli.altnv_menge_einh_id

   WHERE bw.mandant_id = 1
   GROUP BY
   bw.mandant_id,
   bw.art_id;