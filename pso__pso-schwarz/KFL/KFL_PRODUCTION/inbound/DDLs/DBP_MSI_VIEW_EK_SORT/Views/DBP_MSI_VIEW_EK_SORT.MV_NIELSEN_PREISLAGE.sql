CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_NIELSEN_PREISLAGE
-- 18.05.2018 Erweiterung um WÃýhrungs-ID wrg_id / mmzy2302
-- 11.06.2018 InnerJoin mit Tabelle mandant_wrg_typ_zu / mmzy2302
-- 24.07.2018 Referenzen auf Feld wrg_typ_id sowie InnerJoin mit Tabelle mandant_wrg_typ_zu wurden wieder auskommentiert/ mmzy2302
-- 09.08.2018 ZusÃýtzlicher Join zwischen art_nielsen_preislage_zu_per und ts_sortiment_preisklasse_uwg Ã¼ber kl_owg_id und mandant_id/ mmzy2302
-- 20.09.2018 Anpassungen der Join-Bedingungen, da sich die Bedeutung der Felder wg_id (reprÃýsentiert nunmehr "OWG"s nach neuer Definition) und wug_id (reprÃýsentiert nunmehr "WG"s nach neuer Definition) geÃýndert hat/ mmzy2302
-- 18.01.2019 Bereinigung Felder alte WG-Struktur / cbru1709
-- 28.02.2019 Join mit Mandant wegen Default WÃýhrung / cbru1709
-- 28.02.2019 Join mit kjwo_update um Werte fÃ¼r die Woche zu haben / cbru1709

(
mandant_id
, matching_id
, wrg_id
, owg_id
, wg_id
, wug_id
, durchschnitt_preis_kasse
, umsatz_brutto
, umsatz_brutto_af
, umsatz_brutto_sa
, menge
, menge_af
, menge_sa
, kjmo
, kjwo_update
, preisstufe
, wert_preisstufe
)
AS

   SELECT
   v01.mandant_id, art_matching_id AS matching_id, v01.wrg_id, v01.owg_id, v01.wg_id, v01.wug_id, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa, v01.kjmo, v04.kjwo_update, CASE WHEN durchschnitt_preis_kasse < V02.preislage_1 OR durchschnitt_preis_kasse IS NULL THEN 1
   WHEN durchschnitt_preis_kasse >= V02.preislage_1 AND durchschnitt_preis_kasse < V02.preislage_2 THEN 2
   WHEN durchschnitt_preis_kasse >= V02.preislage_2 AND durchschnitt_preis_kasse < V02.preislage_3 THEN 3
   WHEN durchschnitt_preis_kasse >= V02.preislage_3 AND durchschnitt_preis_kasse < V02.preislage_4 THEN 4
   WHEN durchschnitt_preis_kasse >= V02.preislage_4 AND durchschnitt_preis_kasse < V02.preislage_5 THEN 5
   WHEN durchschnitt_preis_kasse >= V02.preislage_5 AND durchschnitt_preis_kasse < V02.preislage_6 THEN 6
   WHEN durchschnitt_preis_kasse >= V02.preislage_6 AND durchschnitt_preis_kasse < V02.preislage_7 THEN 7
   WHEN durchschnitt_preis_kasse >= V02.preislage_7 AND durchschnitt_preis_kasse < V02.preislage_8 THEN 8
   WHEN durchschnitt_preis_kasse >= V02.preislage_8 AND durchschnitt_preis_kasse < V02.preislage_9 THEN 9
   WHEN durchschnitt_preis_kasse >= V02.preislage_9 THEN 10
   END AS preisstufe, CASE
   WHEN durchschnitt_preis_kasse <  V02.preislage_1 OR durchschnitt_preis_kasse IS NULL THEN '< ' || TRIM(preislage_1)
   WHEN durchschnitt_preis_kasse >= V02.preislage_1 AND durchschnitt_preis_kasse < V02.preislage_2 THEN TRIM(preislage_1) ||' - < '||TRIM(preislage_2 )
   WHEN durchschnitt_preis_kasse >= V02.preislage_2 AND durchschnitt_preis_kasse < V02.preislage_3 THEN TRIM(preislage_2) ||' - < '||TRIM(preislage_3 )
   WHEN durchschnitt_preis_kasse >= V02.preislage_3 AND durchschnitt_preis_kasse < V02.preislage_4 THEN TRIM(preislage_3) ||' - < '||TRIM(preislage_4 )
   WHEN durchschnitt_preis_kasse >= V02.preislage_4 AND durchschnitt_preis_kasse < V02.preislage_5 THEN TRIM(preislage_4) ||' - < '||TRIM(preislage_5 )
   WHEN durchschnitt_preis_kasse >= V02.preislage_5 AND durchschnitt_preis_kasse < V02.preislage_6 THEN TRIM(preislage_5) ||' - < '||TRIM(preislage_6 )
   WHEN durchschnitt_preis_kasse >= V02.preislage_6 AND durchschnitt_preis_kasse < V02.preislage_7 THEN TRIM(preislage_6) ||' - < '||TRIM(preislage_7 )
   WHEN durchschnitt_preis_kasse >= V02.preislage_7 AND durchschnitt_preis_kasse < V02.preislage_8 THEN TRIM(preislage_7 ) ||' - < '||TRIM(preislage_8 )
   WHEN durchschnitt_preis_kasse >= V02.preislage_8 AND durchschnitt_preis_kasse < V02.preislage_9 THEN TRIM(preislage_8 ) ||' - < '||TRIM(preislage_9 )
   WHEN durchschnitt_preis_kasse >= V02.preislage_9 THEN  '> ' || TRIM(preislage_9 )
   END AS wert_preisstufe

   FROM dbp_view.v_art_nielsen_preislage_zu_per v01
   JOIN dbp_view.v_ts_sortiment_preisklasse_wug v02
   ON v01.wg_id= v02.wg_id
   AND v01.wug_id = v02.wug_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.wrg_id = v02.wrg_id
   JOIN dbp_view.v_mandant v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.wrg_id = v03.default_wrg
   JOIN dbp_view.v_l_kjmo_sort v04
   ON v01.mandant_id = v04.mandant_id
   AND v01.kjmo = v04.kjmo;