CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lager_bewgrund_2 -- 19.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
-- lager_bewart_typ_zu_2 und l_lager_bewgrund_2 haben die gleichen Schlüssel
-- lager_bewart_typ_zu_2 wird manuell versorgt
-- Zu einem späteren Release soll die Tabelle lager_bewart_typ_zu_2 entfallen und das Feld lager_bewart_typ_id in l_lager_bewgrund_2 rein
(
 grund_id
,lager_bewart_id
,mandant_id
,hist_fg
,retourenart_id
--,lager_bewart_typ_id
)

AS
SELECT
v01.grund_id,
v01.lager_bewart_id,
v01.mandant_id,
v01.hist_fg,
v01.retourenart_id
--,v02.lager_bewart_typ_id
FROM dbp_view.v_l_lager_bewgrund_2 v01
--INNER JOIN dbp_view.v_lager_bewart_typ_zu_2 v02
--   ON v01.mandant_id      = v02.mandant_id
--  AND v01.grund_id        = v02.grund_id
--  AND v01.lager_bewart_id = v02.lager_bewart_id
WHERE v01.hist_fg = 0;
