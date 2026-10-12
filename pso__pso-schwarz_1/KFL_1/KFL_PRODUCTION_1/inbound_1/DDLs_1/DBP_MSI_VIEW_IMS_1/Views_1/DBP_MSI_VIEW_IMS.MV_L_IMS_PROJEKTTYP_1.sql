CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IMS_PROJEKTTYP_1

(
mandant_id
, projekt_typ_id
)
AS
   SELECT
   v01.mandant_id,
   v01.ims_projekt_typ_id AS projekt_typ_id

  FROM dbp_view.v_l_ims_projekt_typ_1 v01
;