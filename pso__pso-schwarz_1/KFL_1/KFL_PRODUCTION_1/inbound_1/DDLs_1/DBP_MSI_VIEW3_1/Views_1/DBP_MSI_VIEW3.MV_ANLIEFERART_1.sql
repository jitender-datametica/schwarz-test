CREATE OR REPLACE VIEW dbp_msi_view3.mv_anlieferart_1
--  AL 27.01.2010  belos_vorgang_1 rausgenommen
(
mandant_id
,anlieferart_id
,anlieferart_bez
)
AS
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

FROM   dbp_msi_view3.mv_belos_vorgang_1 bv
INNER JOIN dbp_view.v_belos_adresse_1 ba
ON
bv.mandant_id = ba.mandant_id AND
bv.belos_adresse_spedition_id = ba.belos_adresse_id ) a
GROUP BY   mandant_id,anlieferart_id;