CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ARTKZ_POSTEN_ARTBEW_2(
	POSTEN_ID,
	POSTEN_ID_BEZ,
	MANDANT_ID,
	SPR_ID
) AS
   SELECT
   CASE WHEN posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS posten_id,
   CASE WHEN posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'Sortimentsartikel AF'  ELSE 'Postenart./Sortimentsart. SA' END AS posten_id_bez,  
   mandant_id, 
   spr_id
   FROM dbp_view.v_artkz_posten_2
   WHERE posten_id IN ('PN','','0', '1', 'PF', 'SP')
   AND spr_id = 22;