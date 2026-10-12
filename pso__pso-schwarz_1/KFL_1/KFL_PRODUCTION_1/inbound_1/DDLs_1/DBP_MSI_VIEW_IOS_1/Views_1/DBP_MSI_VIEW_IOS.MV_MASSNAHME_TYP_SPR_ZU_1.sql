CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_MASSNAHME_TYP_SPR_ZU_1
(
in_massnahme_typ_id
,in_massnahme_typ_bez
)
AS
   SELECT
  v01.massnahmentyp_id, v01.massnahmentyp_bez
   FROM dbp_view.v_massnahmentyp_spr_zu_1 v01
   WHERE  v01.spr_id=22;