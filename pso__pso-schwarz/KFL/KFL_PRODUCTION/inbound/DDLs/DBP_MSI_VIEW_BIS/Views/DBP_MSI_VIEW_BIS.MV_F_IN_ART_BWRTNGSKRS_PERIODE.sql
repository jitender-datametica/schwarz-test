CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_ART_BWRTNGSKRS_PERIODE
-- 09.10.2015 twie: Initial für Bestand im Bericht Lagerstatus
-- 27.11.2015 twie: SPEC0004258 Periodenmapping eingefügt (bspw. entspricht in PL die Buchungsperiode 8 in 2016 dem GJMO 201508 bzw. KJMO 201510

(
gjmo  --nicht verwenden
,mandant_id
,bewertungskreis_id
,in_art_id
,dat_aenderung
,gjmo_bis  --nicht verwenden
,mbew_fg
,menge_bestand_bme
,kjmo  --in Zeithierarchie verwenden
)
AS
   SELECT
   v01.gjmo,
   v01.mandant_id,
   v01.bewertungskreis_id,
   v01.in_art_id,
   v01.dat_aenderung,
   v01.gjmo_bis,
   v01.mbew_fg,
   v01.menge_bestand_bme,
   v02.kjmo

   FROM dbp_view.v_in_art_bwrtngskrs_periode v01
   INNER JOIN dbp_view.v_sap_periode_kalender_zu v02
   ON v01.mandant_id = v02.mandant_id
   AND v02.sap_buchungs_jahr * 100 + v02.buchungsperiode_id BETWEEN v01.gjmo AND v01.gjmo_bis

   WHERE v02.krk_id <> 'DE02'
   AND v02.buchungsperiode_id <=12
;