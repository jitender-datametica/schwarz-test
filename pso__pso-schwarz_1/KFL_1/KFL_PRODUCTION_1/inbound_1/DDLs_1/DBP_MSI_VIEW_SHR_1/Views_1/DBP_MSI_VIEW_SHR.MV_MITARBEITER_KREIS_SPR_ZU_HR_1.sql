CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MITARBEITER_KREIS_SPR_ZU_HR_1
(
mandant_id
, mitarbeiter_kreis_id
, mitarbeiterkreis_bez
)
AS
   SELECT
   v01.mandant_id, v01.mitarbeiter_kreis_id, v01.mitarbeiterkreis_bez

   FROM dbp_view.v_mitarbeiter_kreis_spr_zu_1 v01
   WHERE v01.spr_id = 65
;