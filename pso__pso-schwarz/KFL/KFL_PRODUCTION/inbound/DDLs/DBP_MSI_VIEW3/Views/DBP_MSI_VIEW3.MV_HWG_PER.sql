CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_HWG_PER
-- LOOKUP : Hauptwarengruppe
-- Aktuelle/Letzte gueltige Zuordnung (dat_bis 31.12.9999)
-- 20170508
-- AP0017810, SPEC0021927
-- 05.08.2018, AP0021792, mkub1811: OWG Umstellung
(
mandant_id
,hwg_id
,abt_id
,dat_von
,dat_bis
,arthiertyp_id
)
AS
   SELECT v01.mandant_id, v01.hwg_id, v01.abt_id, v01.dat_von, v01.dat_bis, v01.arthiertyp_id
   FROM dbp_view.v_hwg_per v01
   WHERE v01.arthiertyp_id=2
   AND v01.dat_bis = '9999-12-31';