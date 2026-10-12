CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_LAGERBEW_1
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, lagerbew_beleg_id
, kj
, vorgangsart_id
, dat_beleg
, dat_buch
, dat_erfasst
, ref_lagerbew_beleg_id
, belegkopftext
)
AS
   SELECT
   v01.mandant_id, v01.lagerbew_beleg_id, v01.kj, v01.vorgangsart_id, v01.dat_beleg, v01.dat_buch, v01.dat_erfasst, v01.ref_lagerbew_beleg_id, v01.belegkopftext

   FROM dbp_view.v_flw_lagerbew_1 v01;