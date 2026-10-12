CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_POSTEN_ARTBEW_HIST(
	POSTEN_KZ,
	POSTEN_BEZ,
	MANDANT_ID,
	SPR_ID
) AS
   SELECT
   CASE
   WHEN posten_id = '' THEN 'SO' ELSE posten_id END AS posten_kz,
   CASE 
   WHEN posten_id = 'PN' THEN 'Postenartikel'
   WHEN posten_id = '' THEN 'Sortimentartikel' END AS posten_bez, mandant_id, spr_id
   FROM dbp_view.v_artkz_posten
   WHERE posten_id IN ('PN','')
   AND mandant_id = 1;