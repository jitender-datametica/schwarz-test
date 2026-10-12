CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IMS_PROJEKTTYP_SPR_ZU_BG_2

(
mandant_id
, projekt_typ_id
, projekt_typ_bez
)
AS
   SELECT
   v01.mandant_id,
   v01.ims_projekt_typ_id AS projekt_typ_id,
   v01.ims_projekt_typ_bez AS projekt_typ_bez

  FROM dbp_view.v_ims_projekt_typ_spr_zu_2 v01
   WHERE v01.spr_id = 18
;