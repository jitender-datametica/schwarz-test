create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ANLIEFERART(
	MANDANT_ID,
	ANLIEFERART_ID,
	ANLIEFERART_BEZ
) as
SELECT
mandant_id
,anlieferart_id
,MAX(anlieferart_bez)
FROM (
SELECT
bv.mandant_id
--sammel_ladung_fg=0 Direktlieferung und sammel_ladung_fg=1 Sammel
--Bei der Direktlieferungen wird direkt angezeigt, bei Sammel der Trasportdienstleister

,CASE WHEN sammel_ladung_fg = 0 THEN -1 ELSE belos_adresse_spedition_id END anlieferart_id
,CASE WHEN sammel_ladung_fg = 0 THEN 'direkt'  ELSE adress_name END  anlieferart_bez

FROM   DBP_MSI_VIEW3_MATERIALIZED.mv_belos_vorgang bv
INNER JOIN dbp_view.v_belos_adresse ba
ON
bv.mandant_id = ba.mandant_id AND
bv.belos_adresse_spedition_id = ba.belos_adresse_id ) a
GROUP BY   mandant_id,anlieferart_id;