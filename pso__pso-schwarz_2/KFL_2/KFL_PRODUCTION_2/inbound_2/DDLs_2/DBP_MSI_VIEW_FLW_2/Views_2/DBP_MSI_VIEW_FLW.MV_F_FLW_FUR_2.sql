CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_FUR_2
-- AL 6.06.2011 erstellt
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(

mandant_id
,in_art_id
,in_kunde_id
,dat
--                    ,system_id
,einh_id
,menge_sicherheit
,menge_plan
,dat_erstellung
)
AS
   SELECT

   mandant_id, flw_art_id AS in_art_id, flw_kunde_id AS in_kunde_id, dat, einh_id, menge_sicherheit, menge_plan, dat_erstellung

   FROM dbp_view.v_flw_fur_2 v01;