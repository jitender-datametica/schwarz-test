CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_KOLLI_FAKTOR_BEZUGSWEG_1
---- AP0032822, SPEC0041631 - 30.10.2108, mkub1811 neue View
(
mandant_id,
art_id,
kolli_faktor,
bezugsweg_id
)
AS
   SELECT
   bw.mandant_id,
   bw.art_id,
   COALESCE(kolli.umrech_faktor,1),
   bw.bezugsweg_id
   FROM
   (SELECT art_id, mandant_id, menge_einh_id, bezugsweg_id FROM
   (SELECT art_id, mandant_id, best_menge_einh_id AS menge_einh_id, 1 AS bezugsweg_id FROM dbp_view.v_art_1 WHERE dat_bis = '9999-12-31'
   UNION ALL
   SELECT art_id, mandant_id, ausg_menge_einh_id AS menge_einh_id, 4 AS bezugsweg_id FROM dbp_view.v_art_vorschlagswert_per_1 WHERE dat_bis = '9999-12-31'
   ) subs
   ) bw
   LEFT JOIN

   (SELECT art_id, mandant_id, altnv_menge_einh_id, umrech_faktor FROM dbp_view.v_art_umrechnung_faktor_per_1 WHERE dat_bis = '9999-12-31') kolli
   ON
   bw.art_id = kolli.art_id AND
   bw.mandant_id = kolli.mandant_id AND
   bw.menge_einh_id = kolli.altnv_menge_einh_id;