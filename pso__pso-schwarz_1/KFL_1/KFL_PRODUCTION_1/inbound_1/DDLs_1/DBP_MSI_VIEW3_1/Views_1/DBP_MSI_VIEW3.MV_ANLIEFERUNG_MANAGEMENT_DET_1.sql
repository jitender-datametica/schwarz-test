CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ANLIEFERUNG_MANAGEMENT_DET_1
-- 15.12.2016, AP0013930, SPEC0016091 - Mercareon Detail
(
mandant_id
,anlieferung_id
,best_beleg_id
,lagernummer_id
,wup_id
,nb_id
,retoure_fg
,palettiert_fg
,werbung_fg
,gp_id
)
AS
   SELECT v01.mandant_id, v01.anlieferung_id, v01.best_beleg_id, v01.lagernummer_id, v01.wup_id, v01.nb_id, v01.retoure_fg, v01.palettiert_fg, v01.werbung_fg, v01.gp_id
   FROM dbp_view.v_anlieferung_management_det_1 v01;