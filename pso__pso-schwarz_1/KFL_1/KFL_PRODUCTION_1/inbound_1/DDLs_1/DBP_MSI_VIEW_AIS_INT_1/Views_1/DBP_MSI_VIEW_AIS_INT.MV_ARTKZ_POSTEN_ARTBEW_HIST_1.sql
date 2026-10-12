CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_POSTEN_ARTBEW_HIST_1(
	POSTEN_KZ,
	POSTEN_BEZ,
	MANDANT_ID,
	SPR_ID
) AS
   SELECT
   CASE 
   WHEN posten_id <> '1' THEN 'SO'
   ELSE 'PN' END AS posten_kz,
   CASE 
   WHEN posten_id <> '1' THEN 'Sortimentartikel'
   ELSE 'Postenartikel' END AS posten_bez, mandant_id, spr_id
   FROM dbp_view.v_artkz_posten_1
   WHERE posten_id IN ('1','0')
   AND mandant_id <> 1
   AND spr_id <> 22
   
   UNION ALL
   
   SELECT
   CASE 
   WHEN posten_id = 'PN' THEN 'PN'
   WHEN posten_id = '' THEN 'SO' END AS posten_kz,
   CASE 
   WHEN posten_id = 'PN' THEN 'Postenartikel'
   WHEN posten_id = '' THEN 'Sortimentartikel' END AS posten_bez, mandant_id, spr_id
   FROM dbp_view.v_artkz_posten_1
   WHERE posten_id IN ('PN','')
   AND mandant_id = 1;