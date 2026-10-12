CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_ART_1
(
 mandant_id
,art_id
,kl_art_id
,zek_id
,zek_vat_id
,eigenmarke_id
)
AS
SELECT
  mandant_id
, art_id
, kl_art_id
, zek_id
, zek_vat_id
, eigenmarke_id

FROM dbp_view.v_art_1 v01;