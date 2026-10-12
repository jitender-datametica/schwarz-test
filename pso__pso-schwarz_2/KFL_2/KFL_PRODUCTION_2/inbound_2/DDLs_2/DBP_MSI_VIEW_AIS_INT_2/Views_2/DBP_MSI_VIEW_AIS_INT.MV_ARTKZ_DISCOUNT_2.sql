CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_DISCOUNT_2(
	DISCOUNT_ID,
	DISCOUNT_BEZ,
	MANDANT_ID,
	SPR_ID
) AS
   --SPEC0298140, prescherad, 03.04.2025, Neuanlage 
   SELECT
   discount_id,
   discount_bez,
   mandant_id,
   spr_id
   FROM dbp_view.v_artkz_discount_2
   WHERE mandant_id = 1;