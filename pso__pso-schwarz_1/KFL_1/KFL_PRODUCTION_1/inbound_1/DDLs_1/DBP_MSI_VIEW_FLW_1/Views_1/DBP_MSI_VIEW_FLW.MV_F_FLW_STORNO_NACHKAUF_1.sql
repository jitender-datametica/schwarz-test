CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_STORNO_NACHKAUF_1
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
,in_art_id
,werk_id
,dat
,storno_fg
--,system_id
,menge_kg_wunsch
,menge_kg_ist
,menge_bstmg_wunsch
,menge_bstmg_ist
)
AS
   SELECT
   v01.mandant_id, v01.flw_art_id AS in_art_id, v01.werk_id, v01.dat, v01.storno_fg, v01.menge_kg_wunsch, v01.menge_kg_ist, v01.menge_bstmg_wunsch, v01.menge_bstmg_ist
   FROM dbp_view.v_flw_storno_nachkauf_1 v01;