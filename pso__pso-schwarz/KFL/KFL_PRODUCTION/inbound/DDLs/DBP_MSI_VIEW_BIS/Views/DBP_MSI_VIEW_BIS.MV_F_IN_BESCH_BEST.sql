CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_BESCH_BEST
--03.12.2012 SHoger Initial
--18.02.2013 A. Lipkin weitere Spalte aus der Tabelle ergänzt, ekorg_id --> einkaufsorganisation_id umbenannt
-- 16.04.2013 AL memory_fg = 0
-- 21.09.2015 twie: neu dat_aenderung
-- 22.06.2017 ttez: k_Shop_fg aufgenommen
-- 23.06.2017 ttez: bsak_dat_buch, dat_buch aufgenommen
-- 02.08.2017 ttez: lagerbestellung auto und lagerbestellung manuell aufgenommen
-- 28.02.2018 twie: SPEC0032512  '1DB%' bzw.  '1MB%'  geändert zu  '1DBS' bzw. '1MBS'

(
best_beleg_id
,mandant_id
,in_lief_id
,bestellart_id
,bestell_typ_id
,artikelart_id
,abweichung_fg
,einkaufsorganisation_id
,dat_best_beleg
,einkaeufer_grp_id
,buchungskreis_id
,dat_aenderung
,k_shop_fg
,bsak_dat_buch -- Datum Rechnungsbuchung
,dat_buch -- Datum letzte Änderung in SAP-Bestellungen
,best_angepasst_fg
,lagerbest_auto_fg
,lagerbest_man_fg
)
AS
   SELECT
   v01.best_beleg_id,
   v01.mandant_id,
   v01.in_lief_id,
   v01.bestellart_id,
   v01.bestell_typ_id,
   v01.artikelart_id,
   v01.abweichung_fg,
   v01.einkaufsorganisation_id,
   v01.dat_best_beleg,
   v01.einkaeufer_grp_id,
   v01.buchungskreis_id,
   v01.dat_aenderung,
   COALESCE(v02.k_shop_fg,0) AS k_shop_fg,
   v03.bsak_dat_buch,
   v04.dat_buch,
   CASE WHEN v03.bsak_dat_buch - v04.dat_buch <= 5 THEN 1 ELSE 0 END AS best_angepasst_fg   --Flag, ob Bestellung max. 5 Tage vor Rechnungsdatum noch angepasst wurde
   ,
   CASE WHEN v01.bestellart_id like '1DBS' THEN 1 ELSE 0 END AS lagerbest_auto_fg   --Flag je nach Bestellart der Bestellung setzen
   ,
   CASE WHEN v01.bestellart_id like '1MBS' THEN 1 ELSE 0 END AS lagerbest_man_fg

   FROM dbp_view.v_in_besch_best v01
   LEFT JOIN
   -- Ermittle alle BEST_BELEG_IDs wo mindestens auf eine Position k_shop_fg = 1
   (SELECT DISTINCT best_beleg_id,
   mandant_id,
   k_shop_fg FROM dbp_view.v_in_besch_best_det WHERE k_shop_fg = 1) v02
   ON v01.best_beleg_id = v02.best_beleg_id AND v01.mandant_id  = v02.mandant_id
   LEFT JOIN
   --Ermittle Datum Rechnungsbuchung
   (SELECT DISTINCT best_beleg_id,
   mandant_id,
   MAX(bsak_dat_buch) AS bsak_dat_buch FROM dbp_view.v_in_besch_best_det GROUP BY 1,2) v03
   ON v01.best_beleg_id = v03.best_beleg_id AND v01.mandant_id  = v03.mandant_id
   LEFT JOIN
   -- Ermittle Datum letzte Änderung in SAP-Bestellungen
   (SELECT mandant_id,
   best_beleg_id,
   MAX(dat_buch) AS dat_buch FROM dbp_view.v_in_best_belegfluss GROUP BY 1,2) v04
   ON v01.best_beleg_id = v04.best_beleg_id AND v01.mandant_id  = v04.mandant_id

   WHERE memory_fg = 0 AND (v01.einkaufsorganisation_id IN (9200,9300,9500)
   OR  v01.einkaufsorganisation_id=9000 AND v01.mandant_id=1
   OR  v01.einkaufsorganisation_id=8010 AND v01.mandant_id=2
   OR  v01.einkaufsorganisation_id=8020 AND v01.mandant_id=5
   OR  v01.einkaufsorganisation_id=8030 AND v01.mandant_id=6
   OR  v01.einkaufsorganisation_id=8050 AND v01.mandant_id=3
   OR  v01.einkaufsorganisation_id=8070 AND v01.mandant_id=7
   OR  v01.einkaufsorganisation_id=8090 AND v01.mandant_id=8);