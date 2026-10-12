CREATE OR REPLACE view DBP_MSI_VIEW_FLW.MV_L_FLW_PRUEFMERKMAL_ERGEBNIS
-- 26.10.2011 system_id entfernt
(
prueflos_id
, merkmal_lfd_nr
, mandant_id
--, system_id
, knoten_lfd_nr
, erg_detail_id
, satzstatus_id
, fehlerklasse_id
, katalogart_id
, codegruppe_id
, pruefcode_id
, version_id
, qual_meldung_id
, dat_pruef_von
, messwert_ni_fg
, original_input
, messwert
)
AS
   SELECT
   v01.prueflos_id, v01.merkmal_lfd_nr, v01.mandant_id, v01.knoten_lfd_nr, v01.erg_detail_id, v01.satzstatus_id, v01.fehlerklasse_id, v01.katalogart_id, v01.codegruppe_id, v01.pruefcode_id, v01.version_id, v01.qual_meldung_id, v01.dat_pruef_von, v01.messwert_ni_fg, v01.original_input, v01.messwert

   FROM dbp_view.v_flw_pruefmerkmal_ergebnis v01;