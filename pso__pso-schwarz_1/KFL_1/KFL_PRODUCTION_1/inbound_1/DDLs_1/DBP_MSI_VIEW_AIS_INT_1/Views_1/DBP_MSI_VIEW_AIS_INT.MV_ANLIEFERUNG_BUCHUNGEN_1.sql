CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ANLIEFERUNG_BUCHUNGEN_1
AS
SELECT
v1.mandant_id
,v1.anlieferung_id
,v1.entladestelle_id
,v1.menge_palette_gesamt
,v1.datzeit_entl_gebucht
,v1.datzeit_ankunft
,v1.datzeit_tor
,v1.datzeit_entl_beginn
,v1.datzeit_entl_ende
,v1.datzeit_ausfahrt
,v1.anlieferung_status1_id
,v1.anlieferung_status2_id
,v1.sako_fg
,v1.retoure_kz
,v1.anlieferung_spediteur_id
,v2.best_beleg_id
,v3.dat_best_beleg
,v2.lagernummer_id
,v2.wup_id
,v2.nb_id
,v2.retoure_fg
,v2.palettiert_fg
,v2.werbung_fg
,v2.menge_palette_ist
,v2.menge_palette_soll
,v2.gp_id
FROM dbp_view.v_anlieferung_management_1 v1
JOIN dbp_view.v_anlieferung_management_det_1 v2
ON v1.anlieferung_id = v2.anlieferung_id 
AND v1.mandant_id = v2.mandant_id
LEFT JOIN dbp_view.v_besch_best_1 v3
ON v2.best_beleg_id = v3.best_beleg_id
AND v2.mandant_id = v3.mandant_id;