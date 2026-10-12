CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MITARBEITER_ABWESENH_SPR_SK
(
mandant_id
,abwesenheit_id
,spr_id
,abwesenheit_bez

)
AS
   SELECT
   v01.mandant_id, v01.abwesenheit_id, v01.spr_id, v01.abwesenheit_bez


   FROM dbp_view.v_mitarbeiter_abwesenh_spr_zu v01
   WHERE spr_id = 108
;