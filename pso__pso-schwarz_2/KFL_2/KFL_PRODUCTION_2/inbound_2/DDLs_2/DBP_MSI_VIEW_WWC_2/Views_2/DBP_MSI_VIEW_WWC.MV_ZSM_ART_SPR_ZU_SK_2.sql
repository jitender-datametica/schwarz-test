CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ZSM_ART_SPR_ZU_SK_2(
	SPR_ID,
	INT_ART_ID,
	MANDANT_ID,
	INT_ART_BEZ
) AS
 --08.01.2025, SPEC0285828, prescherad: Neuanlage
  SELECT
  v01.spr_id, 
  v02.int_art_id, 
  v01.mandant_id, 
  v01.art_bez  AS int_art_bez   
  FROM dbp_view.v_art_spr_zu_2 v01

  JOIN dbp_view.v_art_2 v02
  ON (v01.art_id = v02.art_id
  AND v01.mandant_id = v02.mandant_id)
  WHERE spr_id = 108;