CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGER_BEWGRUND
-- AP0014173, srom0404, hist_fg und retourenart_id aufgenommen
-- lager_bewart_typ_zu und l_lager_bewgrund haben die gleichen Schlüssel
-- lager_bewart_typ_zu wird manuell versorgt
-- Zu einem späteren Release soll die Tabelle lager_bewart_typ_zu entfallen und das Feld lager_bewart_typ_id in l_lager_bewgrund rein
(
grund_id
,lager_bewart_id
,mandant_id
,hist_fg
,retourenart_id
,lager_bewart_typ_id
)
AS
   SELECT
   v01.grund_id, v01.lager_bewart_id, v01.mandant_id, v01.hist_fg, v01.retourenart_id, v02.lager_bewart_typ_id
   FROM dbp_view.v_l_lager_bewgrund v01
   INNER JOIN dbp_view.v_lager_bewart_typ_zu v02
   ON v01.mandant_id      = v02.mandant_id
   AND v01.grund_id        = v02.grund_id
   AND v01.lager_bewart_id = v02.lager_bewart_id
   WHERE v01.hist_fg = 0
   AND v02.hist_fg = 0
   ;