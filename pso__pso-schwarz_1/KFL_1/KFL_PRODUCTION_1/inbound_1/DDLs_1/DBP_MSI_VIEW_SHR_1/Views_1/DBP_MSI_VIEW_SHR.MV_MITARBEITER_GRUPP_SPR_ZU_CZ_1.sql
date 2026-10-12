CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MITARBEITER_GRUPP_SPR_ZU_CZ_1
(
mandant_id
, mitarbeiter_gruppe_id
, mitarbeiter_gruppe_bez
)
AS
   SELECT
   v01.mandant_id, v01.mitarbeiter_gruppe_id, v01.mitarbeiter_gruppe_bez

   FROM dbp_view.v_mitarbeiter_gruppe_spr_zu_1 v01
   WHERE v01.spr_id = 124
;