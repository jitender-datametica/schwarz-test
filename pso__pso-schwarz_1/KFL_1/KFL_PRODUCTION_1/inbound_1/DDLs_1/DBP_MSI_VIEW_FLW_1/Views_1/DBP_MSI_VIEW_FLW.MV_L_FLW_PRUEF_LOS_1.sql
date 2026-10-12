CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_PRUEF_LOS_1
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

(
mandant_id
--        ,system_id
,prueflos_id
,best_beleg_id
,best_beleg_pos_id
,werk_id
,in_art_id
,herkunft
,in_lief_id
,pruefart_id
)
AS
   SELECT
   mandant_id, prueflos_id, best_beleg_id, best_beleg_pos_id, werk_id, flw_art_id AS in_art_id, herkunft, flw_lief_id AS in_lief_id, pruefart_id
   FROM dbp_view.v_flw_pruef_los_1;