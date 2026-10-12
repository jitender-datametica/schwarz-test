CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LIEFERANT_GRP_SORT
-- Wird fuer das Sortieren anhand Attributsform in Berichten genutzt
-- Im Spaeteren Schritt als Spalten in die Tabelle in_Lieferant zu intregrieren

-- AL 22.10.2011 rausnehmen Tabelle flw_prod_hierarchie_denorm , ermmiteln hauptgruppe_id
-- durch in-art, l_produktgruppe
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 12.12.2012 twie: Filterung auf ekorg_id 5000 und 5013 da Filterung in EKKO beim Beladen entfaellt
-- 18.02.2013 twie: aenderung in Datenmodell, Spaltnname ekorg_id heisst jetzt einkaufsorganisation_id
-- 22.07.2013 twieder: Bew.art 531 und 532 hinzu
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Y29 + Y30 ergaenzt, Filterung auf CHAR statt INT
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including einkaufsorganisation_id 5014

(
in_lief_grp_id
,in_lief_grp_mandant_id
,in_lief_id
,mandant_id
,hawa_we_mege_kg
,histo_we_mege_kg
,histo_we_wert
,rohst_we_wert
,rohst_we_menge_kg
)
AS

   SELECT

   CASE WHEN l.mandant_id=2 AND l.flw_lief_id_cz > 0 THEN l.flw_lief_id_cz
   ELSE l.flw_lief_id
   END AS in_lief_grp_id
   , CASE WHEN l.mandant_id=2 AND l.flw_lief_id_cz > 0 THEN 1
   ELSE l.mandant_id
   END AS in_lief_grp_mandant_id
   ,l.flw_lief_id AS in_lief_id
   ,l.mandant_id
   , SUM(ZEROIFNULL(hawa_we_mege_kg)) AS hawa_we_mege_kg
   , SUM(ZEROIFNULL(histo_we_mege_kg)) AS histo_we_mege_kg
   , SUM(ZEROIFNULL(histo_we_wert)) AS histo_lwe_wert
   , SUM(ZEROIFNULL(rohst_we_wert)) AS rohst_we_wert
   , SUM(ZEROIFNULL(rohst_we_menge_kg)) AS rohst_we_menge_kg

   FROM dbp_view.v_flw_lieferant l
   LEFT OUTER JOIN

   (
   SELECT  
   mandant_id
   , flw_lief_id
   , SUM(CASE WHEN  hauptgruppe_id ='HAWA' THEN    lbd_we_menge_kg ELSE NULL END) AS hawa_we_mege_kg
   , SUM(CASE WHEN  hauptgruppe_id ='HISTO' THEN    lbd_we_menge_kg ELSE NULL END) AS histo_we_mege_kg
   , SUM(CASE WHEN  hauptgruppe_id ='HISTO' THEN    lbd_we_wert ELSE NULL END) AS histo_we_wert
   , SUM(CASE WHEN  hauptgruppe_id  NOT IN ('HISTO', 'HAWA') THEN   lbd_we_wert ELSE NULL END) AS rohst_we_wert
   , SUM(CASE WHEN  hauptgruppe_id  NOT IN ('HISTO', 'HAWA') THEN   lbd_we_menge_kg ELSE NULL END) AS rohst_we_menge_kg
   FROM

   (-- Logik unveraendert aus mv_f_flw_pruef_los View uebernommen
   -- Feste Einschraenkung auf Waehrung Euro & kurstyp_id =3
   SELECT
   v04.mandant_id
   , v01.flw_art_id
   , v01.flw_lief_id
   , v03.best_menge_einh_id
   , v11.altnv_menge_einh_id
   , v12.hauptgruppe_id
   , CASE
   -- Ausweisung Positiv
   WHEN v04.lager_bewart_id IN ('101','501','521','202','162','262','552','602','644','912','531','Y30') THEN  1
   -- Ausweisung Negativ
   WHEN v04.lager_bewart_id IN ('102','502','522','201','161','261','551','601','643','911','532','Y29') THEN -1
   -- Ausweisung Position 1 Negativ, Position 2 Positiv
   WHEN v04.lager_bewart_id IN ('309','311')AND soll_haben_kz = 'H'THEN -1
   WHEN v04.lager_bewart_id IN ('309','311')AND soll_haben_kz = 'S'THEN  1
   -- Ausweisung Position 1 Positiv, Position 2 Negativ
   WHEN v04.lager_bewart_id IN ('310','312')AND soll_haben_kz = 'H'THEN -1
   WHEN v04.lager_bewart_id IN ('310','312')AND soll_haben_kz = 'S'THEN  1
   END AS vorzeichen, CASE
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v04.wrg_id <> 'EUR' THEN v04.betrag_lagerbew * vorzeichen * v500.umrechnungskurs
   -- Landesbeleg in Euro wird in Euro angezeigt
   ELSE   v04.betrag_lagerbew * vorzeichen
   END AS betrag_lagerbew_, CASE
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v04.wrg_id <> 'EUR' THEN v04.betrag_lagerbew_altnv * vorzeichen * v500.umrechnungskurs
   -- Landesbeleg in Euro wird in Euro angezeigt
   ELSE   v04.betrag_lagerbew_altnv * vorzeichen
   END AS betrag_lagerbew_altnv_, CASE WHEN v10.basismenge_einh_id = 'KG' THEN v04.menge_lagerbew_bme * vorzeichen
   WHEN v10.basismenge_einh_id = 'ST' THEN CAST(v04.menge_lagerbew_bme * vorzeichen * v11.umrech_faktor AS DECIMAL(18,6))
   END AS menge_lagerbew_kg, CASE WHEN v03.best_menge_einh_id = 'KG' THEN v04.menge_lagerbew_bme * vorzeichen
   WHEN v11.altnv_menge_einh_id      =  'KG'    THEN  CAST(v04.menge_lagerbew_bme * vorzeichen * v11.umrech_faktor AS DECIMAL(18,6))
   END AS lbd_we_menge_kg, CASE WHEN v07.preis_steuer_kz = 'V' THEN betrag_lagerbew_
   WHEN v07.preis_steuer_kz = 'S' THEN betrag_lagerbew_altnv_
   END AS lbd_we_wert

   FROM dbp_view.v_flw_pruef_los v01

   JOIN dbp_view.v_flw_besch_best_det v03
   ON v01.mandant_id           = v03.mandant_id
   AND v01.best_beleg_id     = v03.best_beleg_id
   AND v01.best_beleg_pos_id = v03.best_beleg_pos_id

   JOIN dbp_view.v_flw_besch_best v03a
   ON v03.best_beleg_id = v03a.best_beleg_id
   AND v03.mandant_id = v03a.mandant_id

   JOIN dbp_view.v_flw_lagerbew_det v04
   ON v03.mandant_id           = v04.mandant_id
   AND v03.best_beleg_id     = v04.best_beleg_id
   AND v03.best_beleg_pos_id = v04.best_beleg_pos_id

   JOIN dbp_view.v_flw_lagerbew v05
   ON v04.mandant_id           = v05.mandant_id
   AND v04.lagerbew_beleg_id = v05.lagerbew_beleg_id
   AND v04.kj                = v05.kj
   AND v05.vorgangsart_id    = 'WE'

   JOIN dbp_view.v_flw_werk v06
   ON v04.werk_id       = v06.werk_id
   AND v04.mandant_id = v06.mandant_id

   JOIN dbp_view.v_flw_art_bewertungskreis_per v07
   ON v04.mandant_id   = v07.mandant_id
   AND v04.flw_art_id = v07.flw_art_id
   AND v06.werk_nr   = v07.bewertungskreis_id
   AND v05.dat_buch  BETWEEN v07.dat_von AND v07.dat_bis

   JOIN dbp_view.v_flw_art  v10
   ON v03.mandant_id   = v10.mandant_id
   AND v03.flw_art_id = v10.flw_art_id

   -- Umrechnung Standardkurs, Tageskurs
   JOIN dbp_view.v_kurs v500
   ON  v500.kurstyp_id = 3
   AND v04.wrg_id       = v500.von_wrg_id
   AND v500.nach_wrg_id = 'EUR'
   AND v05.dat_buch BETWEEN v500.dat_von AND v500.dat_bis

   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per v11
   ON v10.flw_art_id             = v11.flw_art_id
   AND v10.mandant_id         = v11.mandant_id
   AND 'KG' = v11.altnv_menge_einh_id

   JOIN dbp_view.v_flw_produktgruppe v12
   ON v10.produktgruppe_id = v12.produktgruppe_id
   AND v10.mandant_id = v12.mandant_id

   WHERE dat_buch BETWEEN CURRENT_DATE - 90 AND CURRENT_DATE
   AND v01.mandant_id IN (1,2)
   AND v03a.einkaufsorganisation_id IN (5000,5013,5014)
   )   t
   GROUP BY mandant_id
   ,flw_lief_id

   )  v0
   ON l.mandant_id =v0.mandant_id
   AND l.flw_lief_id  = v0.flw_lief_id

   WHERE l.mandant_id IN (1,2)

   GROUP BY  in_lief_grp_id
   ,in_lief_grp_mandant_id
   ,in_lief_id
   ,l.mandant_id
;