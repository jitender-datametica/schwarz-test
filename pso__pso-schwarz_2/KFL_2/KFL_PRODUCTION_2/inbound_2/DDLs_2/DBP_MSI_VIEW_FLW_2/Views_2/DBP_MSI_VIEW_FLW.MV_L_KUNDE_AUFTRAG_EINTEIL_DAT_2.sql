CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_KUNDE_AUFTRAG_EINTEIL_DAT_2
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 17.09.2015 twie: neu zeit_einteilung
(
mandant_id
--,system_id
,verkaufs_beleg_id
,verkaufs_beleg_pos_id
,einteil_id
,dat_einteilung
,zeit_einteilung
)
AS

   SELECT
   v01.mandant_id, v01.verkaufs_beleg_id, v01.verkaufs_beleg_pos_id, v01.einteil_id, v01.dat_einteilung, v01.zeit_einteilung

   FROM dbp_view.v_flw_kunde_auftrag_einteil_2 v01

   -- WHERE v01.verkaufs_beleg_id = 6693734  --zum testen

   -- gibt fuer jede Verkaufsbelegposition nur einen Datensatz aus, den mit der hoechsten einteil_id
   -- damit wird immer ein eindeutiges dat_einteilung pro Position ausgegeben
   QUALIFY ROW_NUMBER() OVER (PARTITION BY
   v01.mandant_id
   ,v01.verkaufs_beleg_id
   ,v01.verkaufs_beleg_pos_id
   ORDER BY v01.einteil_id DESC NULLS LAST) = 1;