CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_ART_GP_OHNE_WUP_ZU_PER_1
(
mandant_id
,art_id
,gp_id
--,wup_id
--,nb_id
--,einkaufsorganisation_id
--,dat_von
--,dat_bis
--,dat_zeitraum
,dat
,ek_nettonetto
,ek_netto
,ek_brutto
,ek_mep
,einstandspreis
,bonusbasis
,bezugsnebenkosten
,ek_mep_vor_fwu
,ek_netto_bnk
,ek_netto_bnk_sachk
,logistikkostenzuschlag
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC
AS 
-- 18.09.2018, srom0404, Für WE-RE_1 Bonus, Einkaufspreise liegen nicht immmer für jeden MArkt vor (Zentraleinkäufe)
-- Hier den Markt entferne und Verbindung zu Bewegungsdaten nur über Datum, Lieferant, Artikel_1
-- 31.01.2019 AP0038599, SPEC0049577, srom0404, VZ Einkaufspreis verwenden werden. Sollte von einem vZ kein ek dabei sein, so wird der des Marktes verwendet
-- 29.09.2022, SPEC0052815, prescherad: Aufnahme Mandant_1 1
-- 27.10.2022, SPEC0174299. prescherad: Neue Metriken - FWU 
-- 12.01.2024 ,SPEC0231938, prescherad: Optimierung der View. Zeitraum bis wird eingeschränkt auf 2 Jahre in die Zukunft und die Abhängigkeit zur MV_View aufgelöst 
   SELECT 
   v300.mandant_id, 
   v300.art_id, 
   v300.gp_id, dat, 
   MAX(ek_nettonetto) AS ek_nettonetto, 
   MAX(ek_netto) AS ek_netto, 
   MAX(ek_brutto) AS ek_brutto, 
   MAX(ek_mep) AS ek_mep, 
   MAX(einstandspreis) AS einstandspreis,
   MAX(bonusbasis) AS bonusbasis,
   MAX(bezugsnebenkosten) AS bezugsnebenkosten,
   MAX(ek_mep_vor_fwu) AS ek_mep_vor_fwu,
   MAX(ek_netto_bnk) AS ek_netto_bnk,
   MAX(ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
   MAX(logistikkostenzuschlag) AS logistikkostenzuschlag
   FROM ( 
   SELECT 
   v100.mandant_id, 
   v100.art_id, 
   v100.gp_id, 
   v100.wup_id, 
   COALESCE(v100.nb_id,0) AS nb_id, 
   v100.dat, 
   COALESCE(v200.ek_nettonetto, v100.ek_nettonetto) AS ek_nettonetto, 
   COALESCE(v200.ek_netto, v100.ek_netto) AS ek_netto, 
   COALESCE(v200.ek_brutto, v100.ek_brutto) AS ek_brutto, 
   COALESCE(v200.ek_mep, v100.ek_mep) AS ek_mep, 
   COALESCE(v200.einstandspreis, v100.einstandspreis) AS einstandspreis,
   COALESCE(v200.bonusbasis, v100.bonusbasis) AS bonusbasis,
   COALESCE(v200.bezugsnebenkosten, v100.bezugsnebenkosten) AS bezugsnebenkosten,
   COALESCE(v200.ek_mep_vor_fwu, v100.ek_mep_vor_fwu) AS ek_mep_vor_fwu,
   COALESCE(v200.ek_netto_bnk, v100.ek_netto_bnk) AS ek_netto_bnk,
   COALESCE(v200.ek_netto_bnk_sachk, v100.ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
   COALESCE(v200.logistikkostenzuschlag, v100.logistikkostenzuschlag) AS logistikkostenzuschlag
   FROM (
   SELECT 
   v01.mandant_id, 
   v01.art_id, 
   v01.gp_id, 
   v01.wup_id, 
   v01.nb_id, 
   v02.dat, 
   v01.ek_nettonetto, 
   v01.ek_netto, 
   v01.ek_brutto, 
   v01.ek_mep, 
   v01.einstandspreis,
   v01.bonusbasis,
   v01.bezugsnebenkosten,
   v01.ek_mep_vor_fwu,
   v01.ek_netto_bnk,
   v01.ek_netto_bnk_sachk,
   v01.logistikkostenzuschlag
   FROM dbp_view.v_art_gp_wup_zu_per_1 v01
   LEFT JOIN (
   SELECT
   dat,
   kjmo,
   kjwo,
   kj,
   akt_kj
   FROM dbp_view.v_tag_1 v01
   --prescherad: Einschränkung auf 2 Jahre in die Zukunft
   WHERE akt_kj BETWEEN -3 AND 2

   UNION ALL
   
  (SELECT
   CAST( '9999-12-31' AS VARCHAR ) AS dat,
   CAST( 999912 AS INTEGER) AS kjmo,
   CAST( 999952 AS INTEGER) AS kjwo,
   CAST( 9999 AS SMALLINT) AS kj,
   CAST( 9999 AS SMALLINT) AS akt_kj)
   )v02
   
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
   --prescherad: Mandant_1 1 aufnehmen
   --WHERE v01.mandant_id <> 1
   ) v100
   LEFT JOIN (
   SELECT 
   v01.mandant_id, 
   v01.art_id, 
   v01.gp_id, 
   v02.dat, 
   v01.ek_nettonetto, 
   v01.ek_netto, 
   v01.ek_brutto, 
   v01.ek_mep, 
   v01.einstandspreis,
   v01.bonusbasis,
   v01.bezugsnebenkosten,
   v01.ek_mep_vor_fwu,
   v01.ek_netto_bnk,
   v01.ek_netto_bnk_sachk,
   v01.logistikkostenzuschlag
   FROM dbp_view.v_art_gp_wup_zu_per_1 v01
   LEFT JOIN (
   SELECT
   dat,
   kjmo,
   kjwo,
   kj,
   akt_kj
   FROM dbp_view.v_tag_1 v01
   --prescherad: Einschränkung auf 2 Jahre in die Zukunft
   WHERE akt_kj BETWEEN -3 AND 2

   UNION ALL
   
  (SELECT
   CAST( '9999-12-31' AS VARCHAR ) AS dat,
   CAST( 999912 AS INTEGER) AS kjmo,
   CAST( 999952 AS INTEGER) AS kjwo,
   CAST( 9999 AS SMALLINT) AS kj,
   CAST( 9999 AS SMALLINT) AS akt_kj)
   )v02
   
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
   --prescherad: Mandant_1 1 aufnehmen
   --WHERE mandant_id <> 1
   WHERE nb_id = -111
   QUALIFY ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.gp_id, v02.dat ORDER BY v01.wup_id ASC) = 1
   ) v200
   ON v100.mandant_id = v200.mandant_id
   AND v100.art_id = v200.art_id
   AND v100.gp_id = v200.gp_id
   AND v100.dat = v200.dat
   ) v300
   GROUP BY v300.mandant_id
   ,v300.art_id
   ,v300.gp_id
   ,v300.dat;