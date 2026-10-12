CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ARTKZ_POSTEN_ARTBEW_HIST(
	POSTEN_KZ,
	POSTEN_KZ_BEZ,
	MANDANT_ID,
	SPR_ID
) AS
   SELECT
   CASE 
   WHEN posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END AS posten_kz,
   CASE WHEN posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'Sortimentartikel' ELSE 'Postenartikel' END AS posten_kz_bez, 
   mandant_id, 
   spr_id
   FROM dbp_view.v_artkz_posten
   WHERE posten_id IN ('PN','','0', '1', 'PF', 'SP');