CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_UM_RECHNUNG_FAKTOR_PER
(
--MSCH1907 Daten sollen den aktuell gültigen! Palettenfaktor zurückbringen
--SROM0404 Anforderung 589895 - Artikelbezogener Bestand analog Lagerspiegel
--NWAG2310 Umrechnungsfaktor aus UMREZ/UMREN
mandant_id
,alt_menge_einh_id
,art_id
,dat_von
,bruttogew
,umrech_faktor
,gew_einh_id
,dat_bis
,laenge
,breite
,hoehe
)
AS
   SELECT
   t1.mandant_id, t1.altnv_menge_einh_id, t1.art_id, t1.dat_von, t1.bruttogew, cast(t1.umrech_zaehler as NUMBER(38,5)) /cast(t1.umrech_nenner as NUMBER(38,5) ) as umrech_faktor, t1.gew_einh_id, t1.dat_bis, t1.laenge, t1.breite, t1.hoehe
   FROM dbp_view.v_art_umrechnung_faktor_per t1
   LEFT JOIN dbp_view.v_art_vorschlagswert_per t2 --bewusster Left-Join

   ON t1.art_id = t2.art_id
   AND t1.mandant_id = t2.mandant_id
   AND t1.altnv_menge_einh_id = t2.paletten_faktor_einh_id

   WHERE t1.dat_bis='9999-12-31'
   AND t2.dat_bis='9999-12-31';