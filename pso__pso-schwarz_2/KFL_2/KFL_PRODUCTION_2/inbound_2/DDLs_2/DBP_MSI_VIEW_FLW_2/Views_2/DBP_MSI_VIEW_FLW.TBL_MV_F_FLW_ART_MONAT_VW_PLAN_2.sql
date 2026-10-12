CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_ART_MONAT_VW_PLAN_2
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
, in_art_id
, werk_id
, gjmo
, in_vw_id
, wa_betrag_org
, wa_menge_kg
, wa_menge_bme
, wrg_id_orig
, default_wrg
, wrg_id
, max_dat
)
AS
   SELECT

   v01.mandant_id, 
   v01.flw_art_id AS in_art_id, 
   v01.werk_id, 
   gjmo, 
   v01.flw_vw_id AS in_vw_id, 
   v01.wa_menge_kg, 
   v01.wa_menge_bme, 
   v01.wa_betrag AS wa_betrag_org,  -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
   v01.wrg_id AS wrg_id_orig, -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
   v100.default_wrg,
   v01.wrg_id,
   v450.max_dat

   FROM dbp_view.v_flw_art_monat_vw_plan_2   v01

   JOIN dbp_view.v_mandant_2 v100
   ON v01.mandant_id = v100.mandant_id

   JOIN
   (
   --Die Faktdaten liegen auf der Monatsebene vor,
   SELECT
   MAX(dat) AS max_dat, kjmo AS kjmo, MAX(gjmo) AS gjmo
   FROM dbp_view.v_tag_2
   GROUP BY kjmo
   ) v450
   ON v450.kjmo = v01.kjmo;