CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_KL_PREISLAGE_2
-- 18.05.2018 Erweiterung um WÃýhrungs-ID wrg_id / mmzy2302
-- 11.06.2018 InnerJoin mit Tabelle mandant_wrg_typ_zu_2 / mmzy2302
-- 24.07.2018 Referenzen auf Feld wrg_typ_id sowie InnerJoin mit Tabelle mandant_wrg_typ_zu_2 wurden wieder auskommentiert/ mmzy2302
-- 09.08.2018 ZusÃýtzlicher Join zwischen art_kl_preislage_zu_per_2 und ts_sortiment_preisklasse_uwg_2 Ã¼ber kl_owg_id und mandant_id/ mmzy2302
-- 20.09.2018 Anpassungen der Join-Bedingungen, da sich die Bedeutung der Felder wg_id (reprÃýsentiert nunmehr "OWG"s nach neuer Definition) und wug_id (reprÃýsentiert nunmehr "WG"s nach neuer Definition) geÃýndert hat/ mmzy2302
-- 25.09.2018 letzter Join erweitert um wrg_id / sschuecke
-- 18.01.2019 Anpassung K-Listung zu SM_ID und Bereinigung Felder alte WG-Struktur, KSM_ID hinzugefÃ¼gt / cbru1709
-- 28.02.2019 Join mit Mandant_2 wegen Default WÃýhrung / cbru1709

(
mandant_id
, matching_id
, sm_id
, ksm_id
, owg_id
, wg_id
, wug_id
, vk_pk_1
, durchschnitt_preis_kasse
, umsatz_brutto
, umsatz_brutto_af
, umsatz_brutto_sa
, menge
, menge_af
, menge_sa
, kjmo
, kjwo_update
, wrg_id
, preisstufe
, wert_preisstufe
, preisstufe_vk_pk
, wert_preisstufe_vk_pk
, cntProd
)
AS

   SELECT
   v01.mandant_id, art_matching_id AS matching_id, sm_id, ksm_id, v01.owg_id, v01.wg_id, v01.wug_id, vk_brutto_pk_1 AS  vk_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa, kjmo, kjwo_update, v01.wrg_id, CASE
   WHEN durchschnitt_preis_kasse < v02.preislage_1 OR durchschnitt_preis_kasse IS NULL THEN 1
   WHEN durchschnitt_preis_kasse >= v02.preislage_1 AND durchschnitt_preis_kasse < v02.preislage_2 THEN 2
   WHEN durchschnitt_preis_kasse >= v02.preislage_2 AND durchschnitt_preis_kasse < v02.preislage_3 THEN 3
   WHEN durchschnitt_preis_kasse >= v02.preislage_3 AND durchschnitt_preis_kasse < v02.preislage_4 THEN 4
   WHEN durchschnitt_preis_kasse >= v02.preislage_4 AND durchschnitt_preis_kasse < v02.preislage_5 THEN 5
   WHEN durchschnitt_preis_kasse >= v02.preislage_5 AND durchschnitt_preis_kasse < v02.preislage_6 THEN 6
   WHEN durchschnitt_preis_kasse >= v02.preislage_6 AND durchschnitt_preis_kasse < v02.preislage_7 THEN 7
   WHEN durchschnitt_preis_kasse >= v02.preislage_7 AND durchschnitt_preis_kasse < v02.preislage_8 THEN 8
   WHEN durchschnitt_preis_kasse >= v02.preislage_8 AND durchschnitt_preis_kasse < v02.preislage_9 THEN 9
   WHEN durchschnitt_preis_kasse >= v02.preislage_9 THEN 10
   END AS preisstufe, CASE
   WHEN durchschnitt_preis_kasse <  v02.preislage_1 OR durchschnitt_preis_kasse IS NULL THEN '< ' || TRIM(preislage_1 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_1 AND durchschnitt_preis_kasse < v02.preislage_2 THEN TRIM(preislage_1 ) ||' - < '||TRIM(preislage_2 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_2 AND durchschnitt_preis_kasse < v02.preislage_3 THEN TRIM(preislage_2 ) ||' - < '||TRIM(preislage_3 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_3 AND durchschnitt_preis_kasse < v02.preislage_4 THEN TRIM(preislage_3 ) ||' - < '||TRIM(preislage_4 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_4 AND durchschnitt_preis_kasse < v02.preislage_5 THEN TRIM(preislage_4 ) ||' - < '||TRIM(preislage_5 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_5 AND durchschnitt_preis_kasse < v02.preislage_6 THEN TRIM(preislage_5 ) ||' - < '||TRIM(preislage_6 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_6 AND durchschnitt_preis_kasse < v02.preislage_7 THEN TRIM(preislage_6 ) ||' - < '||TRIM(preislage_7 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_7 AND durchschnitt_preis_kasse < v02.preislage_8 THEN TRIM(preislage_7 ) ||' - < '||TRIM(preislage_8 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_8 AND durchschnitt_preis_kasse < v02.preislage_9 THEN TRIM(preislage_8 ) ||' - < '||TRIM(preislage_9 )
   WHEN durchschnitt_preis_kasse >= v02.preislage_9 THEN  '> ' || TRIM(preislage_9 )
   END AS wert_preisstufe, CASE WHEN vk_pk_1 <  v02.preislage_1 OR vk_pk_1 IS NULL THEN 1
   WHEN vk_pk_1 >= v02.preislage_1 AND vk_pk_1 < v02.preislage_2 THEN 2
   WHEN vk_pk_1 >= v02.preislage_2 AND vk_pk_1 < v02.preislage_3 THEN 3
   WHEN vk_pk_1 >= v02.preislage_3 AND vk_pk_1 < v02.preislage_4 THEN 4
   WHEN vk_pk_1 >= v02.preislage_4 AND vk_pk_1 < v02.preislage_5 THEN 5
   WHEN vk_pk_1 >= v02.preislage_5 AND vk_pk_1 < v02.preislage_6 THEN 6
   WHEN vk_pk_1 >= v02.preislage_6 AND vk_pk_1 < v02.preislage_7 THEN 7
   WHEN vk_pk_1 >= v02.preislage_7 AND vk_pk_1 < v02.preislage_8 THEN 8
   WHEN vk_pk_1 >= v02.preislage_8 AND vk_pk_1 < v02.preislage_9 THEN 9
   WHEN vk_pk_1 >= v02.preislage_9 THEN 10
   END AS preisstufe_vk_pk, CASE WHEN vk_pk_1 <  v02.preislage_1 OR vk_pk_1 IS NULL THEN '< ' || TRIM(preislage_1 )
   WHEN vk_pk_1 >= v02.preislage_1 AND vk_pk_1 < v02.preislage_2 THEN TRIM(preislage_1 ) ||' - < '||TRIM(preislage_2 )
   WHEN vk_pk_1 >= v02.preislage_2 AND vk_pk_1 < v02.preislage_3 THEN TRIM(preislage_2 ) ||' - < '||TRIM(preislage_3 )
   WHEN vk_pk_1 >= v02.preislage_3 AND vk_pk_1 < v02.preislage_4 THEN TRIM(preislage_3 ) ||' - < '||TRIM(preislage_4 )
   WHEN vk_pk_1 >= v02.preislage_4 AND vk_pk_1 < v02.preislage_5 THEN TRIM(preislage_4 ) ||' - < '||TRIM(preislage_5 )
   WHEN vk_pk_1 >= v02.preislage_5 AND vk_pk_1 < v02.preislage_6 THEN TRIM(preislage_5 ) ||' - < '||TRIM(preislage_6 )
   WHEN vk_pk_1 >= v02.preislage_6 AND vk_pk_1 < v02.preislage_7 THEN TRIM(preislage_6 ) ||' - < '||TRIM(preislage_7 )
   WHEN vk_pk_1 >= v02.preislage_7 AND vk_pk_1 < v02.preislage_8 THEN TRIM(preislage_7 ) ||' - < '||TRIM(preislage_8 )
   WHEN vk_pk_1 >= v02.preislage_8 AND vk_pk_1 < v02.preislage_9 THEN TRIM(preislage_8 ) ||' - < '||TRIM(preislage_9 )
   WHEN vk_pk_1 >= v02.preislage_9 THEN  '> ' || TRIM(preislage_9 )
   END AS wert_preisstufe_vk_pk, 1 AS cntProd

   FROM dbp_view.v_art_kl_preislage_zu_per_2 v01
   JOIN dbp_view.v_ts_sortiment_preisklasse_wug_2 v02
   ON v01.wg_id= v02.wg_id
   AND v01.wug_id = v02.wug_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.wrg_id = v02.wrg_id
   JOIN dbp_view.v_mandant_2 v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.wrg_id = v03.default_wrg;