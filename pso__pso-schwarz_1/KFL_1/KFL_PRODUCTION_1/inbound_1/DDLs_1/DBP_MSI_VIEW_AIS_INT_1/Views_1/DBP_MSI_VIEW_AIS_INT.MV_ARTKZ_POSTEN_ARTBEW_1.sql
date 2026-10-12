CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_POSTEN_ARTBEW_1(
	POSTEN_ID,
	POSTEN_BEZ,
	MANDANT_ID,
	SPR_ID
) AS
   SELECT
   CASE 
   WHEN posten_id = '1' THEN 'PN'
   WHEN posten_id IN ('0','') THEN 'SO'
   ELSE posten_id END AS posten_id,
   CASE WHEN posten_id IN ('PN', 'PF', 'SP', '1') THEN 'Postenart./Sortimentsart. SA' ELSE 'Sortimentsartikel AF' END AS posten_bez, 
   mandant_id, 
   spr_id
   FROM dbp_view.v_artkz_posten_1
   WHERE posten_id IN ('PN','','0', '1')
   AND spr_id = 22;