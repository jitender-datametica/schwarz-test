CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_LISTUNG_MARKT_KW_1
--SPEC0068483 - adding bewart_1 1010 to the AF columns
(
  mandant_id
 ,wg_id
 ,art_id
 ,wup_id
 ,nb_id
 ,kreistyp_gruppe_id
 ,kjwo
 ,absatz
 ,absatz_sa
 ,absatz_af
 ,anz_wo_mit_absatz
 ,anz_wo_mit_absatz_sa
 ,anz_wo_mit_absatz_af
 ) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO

AS
   SELECT
   v01.mandant_id,
   v03.wg_id,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v04.kreistyp_gruppe_id,
   v02.kjwo,
   ZEROIFNULL(SUM(v01.menge)) AS absatz,
   ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge END)) AS absatz_sa,
   ZEROIFNULL(SUM(CASE WHEN v01.bewart_id IN (1001,1010) THEN v01.menge END)) AS absatz_af,
   ZEROIFNULL(CASE WHEN absatz>0 THEN COUNT(DISTINCT v02.kjwo) END) AS anzahl_wochen_mit_absatz,
   ZEROIFNULL(CASE WHEN absatz_sa>0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v02.kjwo END) END) AS anzahl_wochen_mit_absatz_sa,
   ZEROIFNULL(CASE WHEN absatz_af >0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id IN (1001,1010) THEN v02.kjwo END) END) AS anzahl_wochen_mit_absatz_af

   FROM DBP_DATA.ARTBEW_WO_SUM_1 v01

   JOIN DBP_DATA.WOCHE_KJ_KL_1 v02
   ON v01.kjwo_kl = v02.kjwo_kl

   JOIN DBP_DATA.ART_WG_ZU_PER_1 v03
   ON v03.art_id = v01.art_id
   AND v01.mandant_id = v03.mandant_id

   JOIN DBP_DATA.WUP_1 v04
   ON    v01.wup_id = v04.wup_id
   AND v01.nb_id = v04.nb_id
   AND v01.mandant_id = v04.mandant_id

   WHERE v01.mandant_id > 1
   AND v03.arthiertyp_id = 2
   AND v03.dat_bis = '9999-12-31'
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_1 / sschuecke 17.11.2023
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
      --AP0227085/SPEC0284781 Filter E-Loading Artikel_1 / sschuecke 25.02.2025
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640)
   GROUP BY 1,2,3,4,5,6,7;