CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_ROHERTRAG_PLAN_IST
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
, in_art_id
, gjmo
, plan_fg
, werk_id
, rohertrag_betrag_org
, wrg_id_org
, wrg_id
, MAX_DAT
, default_wrg 

)
AS
   SELECT
   v01.mandant_id, 
   v01.flw_art_id AS in_art_id, 
   gjmo, 
   plan_fg, 
   werk_id, 
   v01.rohertrag_betrag AS rohertrag_betrag_org, -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt  
   v01.wrg_id  AS wrg_id_org,
   v01.wrg_id,
   V450.MAX_DAT,
   v100.default_wrg 
   

   FROM dbp_view.v_flw_rohertrag_plan_ist v01

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id

   JOIN
   (
   SELECT
   MAX(dat) AS max_dat, MAX(kjmo) AS kjmo, gjmo AS gjmo
   FROM dbp_view.v_tag
   GROUP BY gjmo
   ) v450
   ON v450.gjmo = CASE WHEN buchungsperiode_id > 12 THEN gj * 100 + 12 ELSE  gj * 100 + buchungsperiode_id END;
