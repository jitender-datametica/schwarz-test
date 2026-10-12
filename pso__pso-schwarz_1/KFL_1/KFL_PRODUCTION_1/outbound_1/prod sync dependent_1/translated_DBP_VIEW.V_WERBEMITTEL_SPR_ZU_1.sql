CREATE OR REPLACE VIEW kfl_production_dbp_view.v_werbemittel_spr_zu_1 (werbemittelkanal_id
OPTIONS(description='Werbemittel Art_1 ID - medium through which the advertisement is shown (paper, digital)'),
werbemittel_id
OPTIONS(description='Werbemittel - on what item_1 the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)'),
spr_id OPTIONS(description='Sprachschlüssel'), werbemittel_bez OPTIONS(description='Werbemittelbezeichnung'),
werbemittel_wfl_bez
OPTIONS(description='Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_1 Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird.'))
AS SELECT werbemittelkanal_id,
 werbemittel_id,
 spr_id,
 werbemittel_bez,
 werbemittel_wfl_bez
FROM kfl_production_dbp_data.werbemittel_spr_zu_1;