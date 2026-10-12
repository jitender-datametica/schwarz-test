CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORTIMENTSLISTENART_SPR_ZU_2(
	MANDANT_ID,
	SPR_ID,
	SORTIMENTSLISTENART_ID,
	SORTIMENTSLISTENART_BEZ
) AS
   --SPEC0298140, prescherad, 03.04.2025, Neuanlage 
   SELECT
   mandant_id, 
   spr_id, 
   sortimentslistenart_id, 
   sortimentslistenart_bez
   FROM dbp_data.sortimentslistenart_spr_zu_2
   WHERE mandant_id = 1
   AND spr_id = 22;