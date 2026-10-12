CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_RUECKFUEHRUNG_LT_2
-- AP0002469, 13.01.2016, srom0404, Umstellung auf LEFT JOIN (nicht jede Rückführung hat einen Grund)
-- in der View mv_rueck_grund_spr_zu_2 ist entsprechend UNION auf -1 eingebaut
-- in der View mv_l_rueck_grund_2 ist entsprechend UNION auf -1 eingebaut
-- Qualify zur identifiezierung einer ersten Zeile. menge_bme ist quasi eine_2 'Kopfinformation' die im Bericht aufsummiert wird.
-- Da es zu einer Rückführung mehrere Einträge bei den Gründen gibt, kommt es ohne qualify zu n-fachen Werten von menge_bme.
-- max macht in der Metrik auch keinen Sinn, da die Aggregation in der Summenzeile die Gesamtsumme menge_bme anzeigen soll
--AP0035023, SPEC0044761, 07.11.2018, mkub1811, mandant_id_lager hinzugefügt
(
mandant_id
,tour_id
,wup_id
,nb_id
,art_id
,lagerbew_beleg_id
,kj
,lfnr
,dat_buch
,wup_id_lager
,nb_id_lager
,rueck_grund_id
,menge_bme
,mandant_id_lager
)
AS
   SELECT
   v01.mandant_id, v01.tour_id, v01.wup_id, v01.nb_id, v01.art_id, v01.lagerbew_beleg_id, v01.kj, v01.lfnr, v01.dat_buch, v01.wup_id_lager, v01.nb_id_lager, COALESCE(v02.rueck_grund_id, -1) AS rueck_grund_id, CASE WHEN ROW_NUMBER() OVER(PARTITION BY v01.mandant_id, v01.tour_id, v01.wup_id, v01.nb_id, v01.art_id, v01.lagerbew_beleg_id, v01.kj, v01.lfnr, v01.dat_buch ORDER BY v02.rueck_grund_id) = 1
   THEN v01.menge_bme ELSE 0 END AS menge_bme, v01.mandant_id_lager
   FROM dbp_view.v_rueckfuehrung_lt_2 v01
   LEFT JOIN dbp_view.v_rueckfuehrung_lt_grund_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.tour_id = v02.tour_id
   AND v01.wup_id = v02.wup_id
   AND v01.nb_id = v02.nb_id
   AND v01.art_id = v02.art_id
   AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
   AND v01.kj = v02.kj
   AND v01.lfnr = v02.lfnr
   AND v01.dat_buch = v02.dat_buch;