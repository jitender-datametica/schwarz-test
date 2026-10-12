CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_ART_WERK_PROGNOSE
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 22.07.2016 TWIE SPEC0007420 version_fg, kennzeichnet auf Ebene Mandant, Material, Werk, Kunde, Tag immer den aktuellsten Datensatz (neueste Prognoseversion + lfd. Nr.) mit 1. Alle anderen haben 0

(
mandant_id
--, system_id
, in_art_id
, werk_id
, in_kunde_id
, prognosetyp_id
, dat_lief
, bestellmenge
, dat_bereitstellung
, dat_erstellung_von
, dat_erstellung_bis
, best_menge_einh_id
, frueh_spaet_kz
, bedarfsplan_id
, menge_basis
, flw_fg
,prognose_version
,version_lfd_nr
,nr --nur intern
,version_fg
)
AS
   SELECT
   v01.mandant_id, v01.flw_art_id AS in_art_id, v01.werk_id, v01.flw_kunde_id AS in_kunde_id, v01.prognosetyp_id, v01.dat_lief, v01.bestellmenge, v01.dat_bereitstellung, v01.dat_erstellung_von, 
   CASE when v01.dat_erstellung_bis = '9999-12-31' then '9999-12-31' else v01.dat_erstellung_bis end AS dat_erstellung_bis, v01.best_menge_einh_id, v01.frueh_spaet_kz, v01.bedarfsplan_id, v01.menge_basis, v01.flw_fg, v01.prognose_version, v01.version_lfd_nr, SUM(1) OVER (PARTITION BY v01.mandant_id, v01.flw_art_id, v01.werk_id, v01.flw_kunde_id, v01.dat_lief ORDER BY prognose_version DESC NULLS LAST, version_lfd_nr DESC NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) nr, CASE WHEN nr = 1 THEN 1 ELSE 0 END AS version_flag
   FROM dbp_view.v_flw_art_werk_prognose v01;