CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_KOLLI_FAKTOR_BEZUGSWEG
(
	MANDANT_ID,
	ART_ID,
	KOLLI_FAKTOR,
	BEZUGSWEG_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
bw.mandant_id,
bw.art_id,
COALESCE(kolli.umrech_faktor,1),
bw.bezugsweg_id
FROM

   (SELECT art_id, mandant_id, menge_einh_id, bezugsweg_id FROM
   (SELECT art_id, mandant_id, best_menge_einh_id AS menge_einh_id, 1 AS bezugsweg_id FROM dbp_view.v_art WHERE dat_bis = '9999-12-31'
   UNION ALL
   SELECT art_id, mandant_id, ausg_menge_einh_id AS menge_einh_id, 4 AS bezugsweg_id FROM dbp_view.v_art_vorschlagswert_per WHERE dat_bis = '9999-12-31'
   ) subs
   ) bw
   LEFT JOIN

   (SELECT art_id, mandant_id, altnv_menge_einh_id, umrech_faktor FROM dbp_view.v_art_umrechnung_faktor_per WHERE dat_bis = '9999-12-31') kolli
   ON
   bw.art_id = kolli.art_id AND
   bw.mandant_id = kolli.mandant_id AND
   bw.menge_einh_id = kolli.altnv_menge_einh_id
   WHERE bw.mandant_id = 1;