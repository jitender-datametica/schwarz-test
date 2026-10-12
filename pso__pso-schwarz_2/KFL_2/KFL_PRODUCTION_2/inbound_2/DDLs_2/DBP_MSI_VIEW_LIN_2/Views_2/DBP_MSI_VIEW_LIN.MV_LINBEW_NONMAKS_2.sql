CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_LINBEW_NONMAKS_2
-- 20161121 NWag2310  : Join tag_2 + Gruppierung, da kjmo in Quelle entfernt
-- 20200701 srom0404  : QUALIFY für den letzten gelieferten Datensatz. Es gibt Kurse, die täglich geliefert werden. Nicht summieren.
-- 20200701 srom0404  : Unternehmensbereich wird nicht mehr benötigt
(
 mandant_id
,lin_kurs_id
,hr_objekt_id
,kjmo
--,unternehmens_bereich_id
,ki_fg
,anzahl_kurse_gesamt
,anzahl_kurse_abgeschlossen
)
AS
SELECT
 v01.mandant_id
,v01.lin_kurs_id
,v01.hr_objekt_id
,v02.kjmo
--,unternehmens_bereich_id
,v01.ki_fg
,v01.anzahl_kurse_gesamt
,v01.anzahl_kurse_abgeschlossen

FROM dbp_view.v_linbew_nonmaks_2 v01
INNER JOIN dbp_view.v_tag_2 v02
   ON v02.dat = v01.dat
WHERE v01.hr_objekt_id > 0
QUALIFY Row_Number() Over (PARTITION BY v01.mandant_id, v01.lin_kurs_id, v01.hr_objekt_id, v02.kjmo, v01.ki_fg ORDER BY v02.dat DESC) = 1;