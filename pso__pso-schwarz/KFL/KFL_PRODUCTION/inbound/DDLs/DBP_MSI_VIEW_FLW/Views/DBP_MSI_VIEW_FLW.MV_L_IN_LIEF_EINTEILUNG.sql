CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LIEF_EINTEILUNG
-- 26.10.2011 system_id entfernt
-- 06.08.2012 datzeit_lief_wunsch_az hinzugefuegt (Anlieferzeit)
-- 21.08.2014 TWIE Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, best_beleg_id
, best_beleg_pos_id
, charge_id
, einteil_id
, dat_lief_wunsch
, zeit_lief_wunsch
, datzeit_lief_wunsch
, datzeit_lief_wunsch_az
)
AS
   SELECT
   v01.mandant_id, v01.best_beleg_id, v01.best_beleg_pos_id, v01.charge_id, v01.einteil_id, v01.dat_lief_wunsch, v01.zeit_lief_wunsch, v01.datzeit_lief_wunsch, v01.datzeit_lief_wunsch_az

   FROM dbp_view.v_flw_lief_einteilung v01;