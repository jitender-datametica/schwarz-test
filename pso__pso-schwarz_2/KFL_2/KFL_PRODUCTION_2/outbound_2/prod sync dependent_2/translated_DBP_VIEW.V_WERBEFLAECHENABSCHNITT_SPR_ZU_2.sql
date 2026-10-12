CREATE OR REPLACE VIEW kfl_production_dbp_view.v_werbeflaechenabschnitt_spr_zu_2 (werbeflaechenabschnitt_id
OPTIONS(description='ID des Werbeflächenabschnitts'), spr_id OPTIONS(description='ID der Sprache'),
werbeflaechenabschnitt_name OPTIONS(description='Bezeichnung des Werbeflächenabschnitts'),
werbeflaechenabschnitt_wfl_bez
OPTIONS(description='Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_2 Bezeichnung für bestimmt Werbeflächenabschnitt definieren kann, welche im Frontend angezeigt wird.'))
AS SELECT werbeflaechenabschnitt_id,
 spr_id,
 werbeflaechenabschnitt_name,
 werbeflaechenabschnitt_wfl_bez
FROM kfl_production_dbp_data.werbeflaechenabschnitt_spr_zu_2;