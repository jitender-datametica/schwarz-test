CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTKZ_POSTEN_ARTBEW_2(
	POSTEN_ID,
	POSTEN_BEZ,
	MANDANT_ID,
	SPR_ID
) AS
   SELECT
   CASE WHEN posten_id = '1' THEN 'PN' ELSE 'SO' END AS posten_id, 
   CASE WHEN posten_id = '1' THEN 'Postenart./Sortimentsart. SA' ELSE 'Sortimentsartikel AF' END AS posten_bez, 
   mandant_id, 
   spr_id
   FROM dbp_view.v_artkz_posten_2
   WHERE posten_id IN ('0', '1')
   AND mandant_id <> 1
   AND spr_id = 22;