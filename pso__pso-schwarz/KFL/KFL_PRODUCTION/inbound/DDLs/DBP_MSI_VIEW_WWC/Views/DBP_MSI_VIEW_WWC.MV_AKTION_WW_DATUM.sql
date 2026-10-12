CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_AKTION_WW_DATUM
-- AP0009976, srom0404, 17.08.2016
-- Verknüpft die (gewählte/Prompt) Werbewoche über ein Hilfsattribut zu den Bewegungsdaten
-- Verknüpfung über Mandant|Aktion|dat zu mv_f_besch_faktura_det_kmo
(
aktion_id
,mandant_id
,dat_von
,dat_bis
,ww_kjwo
,dat
)
AS
   SELECT v01.aktion_id, v01.mandant_id, v01.dat_von, v01.dat_bis, v02.kjwo AS ww_kjwo, v02.dat
   FROM dbp_view.v_aktion v01
   INNER JOIN dbp_view.v_tag v02
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
   AND v02.akt_kj BETWEEN -2 AND 0;