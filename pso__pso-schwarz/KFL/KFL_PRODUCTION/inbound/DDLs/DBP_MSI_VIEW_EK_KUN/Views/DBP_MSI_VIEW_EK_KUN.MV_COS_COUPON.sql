CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_COS_COUPON
--AP0144054/SPEC0168968 Neuanlage View wegen Redesign - sschuecke 03.11.2022
 (
  mandant_id
, bonuskauf_id
, kampagnen_id
, coupon_typ
, aktions_typ
, dat_update
, campaign
, bonuskauf_partner_fg
, bonuskauf_anbieter_name
, bonuskauf_code_generierung_typ_id
, bonuskauf_code_typ_id
, bonuskauf_vorteilsregeln_txt
, bonuskauf_konditionen_txt
, datzeit_bis_extern_einloesung
, datzeit_von_extern_einloesung
, ausgespielter_kanal
, anz_punkte_zu_zahlend
, anz_aktivierungen_kaufbar
, anz_aktivierungen_nicht_kaufbar
, anz_aktivierungen
, anz_einloesungen_kaufbar
, anz_einloesungen_nicht_kaufbar
, anz_einloesungen
) AS
SELECT 
  mandant_id
, bonuskauf_id
, MAX(kampagnen_id) OVER (PARTITION BY mandant_id, bonuskauf_id) AS kampagnen_id
, coupon_typ
-- NEU SPEC0206979 Aktionstyp / ssch1303 28.12.2023
, aktions_typ
, dat_update
, campaign
 -- NEU SPEC0155446 Partnercoupon / ssch1303 28.12.2023
, bonuskauf_partner_fg
, bonuskauf_anbieter_name
, bonuskauf_code_generierung_typ_id
, bonuskauf_code_typ_id
, bonuskauf_vorteilsregeln_txt
, bonuskauf_konditionen_txt
, datzeit_bis_extern_einloesung
, datzeit_von_extern_einloesung
, ausgespielter_kanal
	-- ENDE neue Ausprägungen Partnercoupon
, anz_punkte_zu_zahlend
, anz_aktivierungen_kaufbar
, anz_aktivierungen_nicht_kaufbar
, anz_aktivierungen
, anz_einloesungen_kaufbar
, anz_einloesungen_nicht_kaufbar
, anz_einloesungen
FROM
(
SELECT
-- AP0144054/SPEC0168968 Neudefinition Logik anz_aktivierungen + anz_einloesungen, campaign - ssch 30.05.2023
  v01.mandant_id
, v01.bonuskauf_id
, MAX(kampagnen_id) OVER (PARTITION BY v01.mandant_id, v01.bonuskauf_id) AS kampagnen_id
, v01.coupon_typ
-- NEU SPEC0206979 Aktionstyp / ssch1303 28.12.2023
, v01.aktions_typ
, v01.dat_update
, COUNT (DISTINCT campaign)  OVER (PARTITION BY v01.mandant_id, v01.bonuskauf_id) AS campaign
-- NEU SPEC0155446 Partnercoupon / ssch1303 28.12.2023
, v01.bonuskauf_partner_fg
, v01.bonuskauf_anbieter_name
, v01.bonuskauf_code_generierung_typ_id
, v01.bonuskauf_code_typ_id
, v01.bonuskauf_vorteilsregeln_txt
, v01.bonuskauf_konditionen_txt
, v01.datzeit_bis_extern_einloesung
, v01.datzeit_von_extern_einloesung
, RTRIM (CONCAT(
      CASE WHEN v01.sichtbar_in_app_fg        = 1 THEN 'App, '       ELSE '' END
    ||CASE WHEN v01.sichtbar_in_web_fg        = 1 THEN 'Web, '       ELSE '' END
    ||CASE WHEN v01.sichtbar_in_ssc_fg        = 1 THEN 'SSC, '       ELSE '' END
    ||CASE WHEN v01.sichtbar_in_marktplatz_fg = 1 THEN 'Marktplatz, 'ELSE '' END
    ||CASE WHEN v01.sichtbar_in_kampagne_fg   = 1 THEN 'Kampagne'    ELSE '' END),', ' ) AS ausgespielter_kanal
	-- ENDE neue Ausprägungen Partnercoupon
, anz_punkte_zu_zahlend
, v03.anz_aktivierungen_kaufbar
, v101.anz_aktivierungen_nicht_kaufbar
, COALESCE(v03.anz_aktivierungen_kaufbar,0) + COALESCE(v101.anz_aktivierungen_nicht_kaufbar,0) AS anz_aktivierungen
, v05.anz_einloesungen_kaufbar
, v06.anz_einloesungen_nicht_kaufbar
, COALESCE(v05.anz_einloesungen_kaufbar,0) + COALESCE(v06.anz_einloesungen_nicht_kaufbar,0) AS anz_einloesungen
, v01.crm_kunde_id

FROM
(
SELECT
  v01.mandant_id
, v01.bonuskauf_id
, MAX(CASE WHEN v02.kampagnen_id = 'default' THEN NULL ELSE kampagnen_id END) AS kampagnen_id
-- NEUE Definition SPEC0206979 Coupontyp / ssch1303 28.12.2023
, CASE 
    WHEN v01.bonuskauf_partner_fg = 1 THEN 'Partner'
    WHEN v01.nur_marktplatz_fg = 1    THEN 'Marktplatz'
    WHEN v01.bonuskauf_smp_fg = 1     THEN 'SMP'
    ELSE 'Coupon'
  END AS coupon_typ
-- NEU SPEC0206979 Aktionstyp / ssch1303 28.12.2023
, CASE
    WHEN v01.gamification_fg = 1    THEN 'Gamification'
    WHEN v02.checkout_fg = 1        THEN 'Checkout'
    WHEN v01.kauf_mit_punkte_fg = 1 THEN 'Kaufbar'
    WHEN v01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM') THEN 'Reco'
    ELSE 'Normal' END AS aktions_typ
, TO_DATE(v02.dat_update) AS dat_update
/* Neue Logik Campaign */
, CASE 
    WHEN (
        v01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM')
        OR v02.kampagnen_id IS NOT NULL
        OR v01.aktiv_loyalty_gesamt_fg = 0
        OR v01.bonuskauf_partner_fg = 1
        )
        AND v02.kampagnen_id <> 'default'
    THEN v02.crm_kunde_id 
    WHEN v01.gamification_fg = 1 THEN v02.crm_kunde_id
    ELSE NULL END AS campaign
-- NEU SPEC0155446 Partnercoupon / ssch1303 28.12.2023
, v01.bonuskauf_partner_fg
, v01.bonuskauf_anbieter_name
, v01.bonuskauf_code_generierung_typ_id
, v01.bonuskauf_code_typ_id
, v01.bonuskauf_vorteilsregeln_txt
, v01.bonuskauf_konditionen_txt
, TO_DATE (v01.datzeit_bis_extern_einloesung) AS datzeit_bis_extern_einloesung
, TO_DATE (v01.datzeit_von_extern_einloesung) AS datzeit_von_extern_einloesung
, v01.sichtbar_in_app_fg
, v01.sichtbar_in_web_fg
, v01.sichtbar_in_ssc_fg
, v01.sichtbar_in_marktplatz_fg
, v01.sichtbar_in_kampagne_fg 
, v02.crm_kunde_id  -- Mit aufgenommen, da über dieses Feld die unten gemachte neue Berechnung auch auf dieser Ebene dazu gejoined wird
-- NEUE Definition SPEC0206979 anz_punkte_zu_zahlend / ssch1303 21.12.2023
, CASE WHEN v01.kauf_mit_punkte_fg = 1 THEN v01.anz_punkte_zu_zahlend END AS anz_punkte_zu_zahlend
FROM DBP_VIEW.V_COS_BONUSKAUF v01
JOIN DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU v02
ON v01.mandant_id = v02.mandant_id
AND v01.bonuskauf_id = v02.bonuskauf_id
GROUP BY
  v01.mandant_id
, v01.bonuskauf_id
, v02.kampagnen_id
, coupon_typ
, aktions_typ
, v02.dat_update
, v01.gamification_fg
, v01.kauf_mit_punkte_fg
, v01.bonuskauf_promotionstyp
, v01.aktiv_loyalty_gesamt_fg
, v01.bonuskauf_partner_fg
, v01.bonuskauf_anbieter_name
, v01.bonuskauf_code_generierung_typ_id
, v01.bonuskauf_code_typ_id
, v01.bonuskauf_vorteilsregeln_txt
, v01.bonuskauf_konditionen_txt
, v01.datzeit_bis_extern_einloesung
, v01.datzeit_von_extern_einloesung
, v01.sichtbar_in_app_fg
, v01.sichtbar_in_web_fg
, v01.sichtbar_in_ssc_fg
, v01.sichtbar_in_marktplatz_fg
, v01.sichtbar_in_kampagne_fg 
, v02.crm_kunde_id
, v01.anz_punkte_zu_zahlend) v01

/* Neue Logik Anzahl Aktivierungen kaufbare Coupons*/
LEFT JOIN 
( -- v03
SELECT  a.mandant_id
      , a.bonuskauf_id
      , a.crm_kunde_id
      , TO_DATE(a.dat_update) AS dat_update  
      , COUNT(*) AS anz_aktivierungen_kaufbar 
 FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU a
JOIN DBP_VIEW.V_COS_BONUSKAUF b
   ON a.mandant_id = b.mandant_id 
  AND a.bonuskauf_id = b.bonuskauf_id 
 WHERE a.kauf_status_nr IN (1,3) 
   AND b.kauf_mit_punkte_fg = 1
   AND (a.mandant_id,a.crm_kunde_id, a.kauf_id,a.bonuskauf_id, a.dat_update) IN 
        (SELECT a.mandant_id, a.crm_kunde_id, a.kauf_id, a.bonuskauf_id, MIN(a.dat_update) 
         FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU a
         JOIN DBP_VIEW.V_COS_BONUSKAUF  b
           ON a.mandant_id = b.mandant_id 
          AND a.bonuskauf_id = b.bonuskauf_id
         WHERE kauf_status_nr IN (1,3) 
           AND b.kauf_mit_punkte_fg = 1 
         GROUP BY 1,2,3,4)
GROUP BY 1,2,3,4
) v03
ON v01.mandant_id    = v03.mandant_id
AND v01.bonuskauf_id = v03.bonuskauf_id
AND v01.dat_update   = v03.dat_update
AND v01.crm_kunde_id = v03.crm_kunde_id

/* Neue Logik Anzahl Aktivierungen nicht kaufbare Coupons*/
LEFT JOIN 
(--v04, v101
SELECT  v04.mandant_id
      , v04.bonuskauf_id
      , v04.crm_kunde_id
      , v04.dat_update  
      , COUNT(*) AS anz_aktivierungen_nicht_kaufbar 
  FROM (
SELECT  a.mandant_id
      , a.bonuskauf_id
      , a.crm_kunde_id
      , TO_DATE(a.dat_update) AS dat_update
      , COUNT(*) AS anz_aktivierungen_nicht_kaufbar 
 FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU a
JOIN DBP_VIEW.V_COS_BONUSKAUF  b
   ON a.mandant_id = b.mandant_id 
  AND a.bonuskauf_id = b.bonuskauf_id
WHERE a.status_aktiv_nr = 1 
   AND b.kauf_mit_punkte_fg = 0
   AND (a.mandant_id,a.crm_kunde_id, a.bonuskauf_id, a.dat_update, a.datzeit_status_aktivierung) IN 
       (SELECT a.mandant_id, a.crm_kunde_id, a.bonuskauf_id, MAX(a.dat_update), MAX(a.datzeit_status_aktivierung) 
        FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU  a
        JOIN DBP_VIEW.V_COS_BONUSKAUF  b
          ON a.mandant_id = b.mandant_id 
         AND a.bonuskauf_id = b.bonuskauf_id
        WHERE a.status_aktiv_nr = 1
          AND b.kauf_mit_punkte_fg = 0
        GROUP BY 1,2,3) 
 GROUP BY 1,2,3,4
) v04
  GROUP BY 1,2,3,4) v101

ON v01.mandant_id    = v101.mandant_id
AND v01.bonuskauf_id = v101.bonuskauf_id
AND v01.dat_update   = v101.dat_update
AND v01.crm_kunde_id = v101.crm_kunde_id

/* Neue Logik Anzahl Einloesungen kaufbare Coupons*/
LEFT JOIN 
( -- v05
SELECT  a.mandant_id
      , a.bonuskauf_id
      , a.crm_kunde_id
      , TO_DATE(a.dat_update) AS dat_update  
      , COUNT(*) AS anz_einloesungen_kaufbar 
 FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU a
JOIN DBP_VIEW.V_COS_BONUSKAUF b
   ON a.mandant_id = b.mandant_id 
  AND a.bonuskauf_id = b.bonuskauf_id 
 WHERE a.kauf_status_nr = 3 
   AND b.kauf_mit_punkte_fg = 1
   AND (a.mandant_id,a.crm_kunde_id, a.kauf_id,a.bonuskauf_id, a.dat_update) IN 
        (SELECT a.mandant_id, a.crm_kunde_id, a.kauf_id, a.bonuskauf_id, MIN(a.dat_update) 
         FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU a
         JOIN DBP_VIEW.V_COS_BONUSKAUF  b
           ON a.mandant_id = b.mandant_id 
          AND a.bonuskauf_id = b.bonuskauf_id
         WHERE kauf_status_nr = 3 
           AND b.kauf_mit_punkte_fg = 1 
         GROUP BY 1,2,3,4)
GROUP BY 1,2,3,4
) v05
ON v01.mandant_id    = v05.mandant_id
AND v01.bonuskauf_id = v05.bonuskauf_id
AND v01.dat_update   = v05.dat_update
AND v01.crm_kunde_id = v05.crm_kunde_id

/* Neue Logik Anzahl Einloesungen nicht kaufbare Coupons*/
LEFT JOIN 
( -- v06
SELECT  a.mandant_id
      , a.bonuskauf_id
      , a.crm_kunde_id
      , TO_DATE(a.dat_update) AS dat_update
/* Info Bakos 02.08.2023 / Aufgrund neuer Datensaetze mit anz_einloesung = -1 erfolgt CASE Bedingung und CAST zu 0, da sonst falsche
Summierung / sschuecke 02.08.2023 */
      , SUM (CASE WHEN a.anz_einloesung = -1 THEN 0 ELSE a.anz_einloesung END) AS anz_einloesungen_nicht_kaufbar
 FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU a
JOIN DBP_VIEW.V_COS_BONUSKAUF  b
   ON a.mandant_id = b.mandant_id 
  AND a.bonuskauf_id = b.bonuskauf_id
WHERE b.kauf_mit_punkte_fg = 0
   AND (a.mandant_id,a.crm_kunde_id, a.bonuskauf_id, a.dat_update) IN 
       (SELECT a.mandant_id, a.crm_kunde_id, a.bonuskauf_id, MAX(a.dat_update) 
        FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU  a
        JOIN DBP_VIEW.V_COS_BONUSKAUF  b
          ON a.mandant_id = b.mandant_id 
         AND a.bonuskauf_id = b.bonuskauf_id
        WHERE b.kauf_mit_punkte_fg = 0
        GROUP BY 1,2,3) 
 GROUP BY 1,2,3,4
) v06
ON v01.mandant_id    = v06.mandant_id
AND v01.bonuskauf_id = v06.bonuskauf_id
AND v01.dat_update   = v06.dat_update
AND v01.crm_kunde_id = v06.crm_kunde_id
)v99
GROUP BY 
  mandant_id
, crm_kunde_id
, bonuskauf_id
, kampagnen_id
, coupon_typ
, aktions_typ
, dat_update
, campaign
, bonuskauf_partner_fg
, bonuskauf_anbieter_name
, bonuskauf_code_generierung_typ_id
, bonuskauf_code_typ_id
, bonuskauf_vorteilsregeln_txt
, bonuskauf_konditionen_txt
, datzeit_bis_extern_einloesung
, datzeit_von_extern_einloesung
, ausgespielter_kanal
, anz_punkte_zu_zahlend
, anz_aktivierungen
, anz_aktivierungen_kaufbar
, anz_aktivierungen_nicht_kaufbar
, anz_einloesungen_kaufbar
, anz_einloesungen_nicht_kaufbar
, anz_einloesungen
;
