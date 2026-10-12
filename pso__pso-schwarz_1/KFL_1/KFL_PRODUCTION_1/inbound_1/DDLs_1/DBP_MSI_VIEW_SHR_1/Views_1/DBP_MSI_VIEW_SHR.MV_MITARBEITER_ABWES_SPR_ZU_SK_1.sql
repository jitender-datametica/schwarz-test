CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MITARBEITER_ABWES_SPR_ZU_SK_1
(
mandant_id
, abwesenheit_id
, abwesenheit_bez
)
AS
   SELECT
   v01.mandant_id, v01.abwesenheit_id, v01.abwesenheit_bez

   FROM dbp_view.v_mitarbeiter_abwesenh_spr_zu_1 v01
   WHERE v01.spr_id = 108
;