CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PM_WUP_ZU_1
AS
    -- ZUORDNUNG Preiskategorie pro Filiale/Bereich
    --basiert auf den von Vertrieb (Hr. Ganz) definierten Leitwarengruppen
    -- 19.12.2011 AL neu erstellt Zuordnung Preismodule zu Filiale
    -- 19.03.2012 MR neue Attribute zugeben
    -- 2014-11-05 Review; WG-Harmonisierung nachgezogen!
    -- 2019-01-18 ssch0611 : Gefrickel! temporaere Loesung Filialsteckbrief
    -- 2024-01-22 muellerpatri : Filterung auf current-date between VON und BIS

   SELECT
     w.mandant_id, w.wup_id, pm_fl_id, pm_og_id, pm_food_id, pm_nonfood_id, pm_wurst_bed_id, pm_sb_wurst_id, pm_kaese_bed_id
   FROM
   ( -- Marktstamm
     SELECT mandant_id, land_id, nb_id, wup_id, vw_id
   FROM dbp_view.v_wup_1
   WHERE nb_id = 0  -- nur Filiale
   AND (dat_von > '1900-01-01' AND dat_eroeffnung > '1900-01-01')  -- Filterung wup_1 Sumpf
   AND umzugsfiliale_fg = 0 -- ohne Umzugsfilialen (alt)
 ) w
   LEFT JOIN
   (
     SELECT
       wup_id, mandant_id                                                    -- 2019-01-18     
   , MAX(CASE WHEN wg_id IN (128)   THEN pm_id END) pm_fl_id       -- Fleisch Theke
   , MAX(CASE WHEN wg_id IN (161)  THEN pm_id END) pm_og_id        -- OG
   , MAX(CASE WHEN wg_id IN (0) THEN pm_id END) pm_food_id         -- AUS
   , MAX(CASE WHEN wg_id IN (0) THEN pm_id END) pm_nonfood_id      -- AUS
   , MAX(CASE WHEN wg_id IN (136)  THEN pm_id END) pm_wurst_bed_id -- Wurst Theke
   , MAX(CASE WHEN wg_id IN (179)  THEN pm_id END) pm_sb_wurst_id  -- TEMPORAER Fisch Theke!
   , MAX(CASE WHEN wg_id IN (129) THEN pm_id END) pm_kaese_bed_id  -- Kaese Theke
   FROM dbp_view.v_pm_wup_wg_zu_per_1

   WHERE CURRENT_DATE() BETWEEN DAT_VON AND DAT_BIS AND arthiertyp_id=2
   GROUP BY 1,2
 )  wpm
   ON w.mandant_id = wpm.mandant_id
   AND w.wup_id = wpm.wup_id;