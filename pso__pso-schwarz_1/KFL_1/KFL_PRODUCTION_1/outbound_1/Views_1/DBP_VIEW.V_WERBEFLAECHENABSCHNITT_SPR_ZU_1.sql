CREATE OR REPLACE VIEW kfl_production_dbp_view.v_werbeflaechenabschnitt_spr_zu_1 (werbeflaechenabschnitt_id
OPTIONS(description='ID des Werbeflächenabschnitts'), spr_id OPTIONS(description='ID der Sprache'),
werbeflaechenabschnitt_name OPTIONS(description='Bezeichnung des Werbeflächenabschnitts'),
werbeflaechenabschnitt_wfl_bez
OPTIONS(description='Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_1 Bezeichnung für bestimmt Werbeflächenabschnitt definieren kann, welche im Frontend angezeigt wird.'))
OPTIONS(DESCRIPTION = `SPRACHZUORDNUNGSTABELLE FÜR DEN WERBEFLÄCHENABSCHNITT. AUS ZPMR_WBM_ABSBEZ(SAP P11). ENTHÄLT SOWOHL DIE WERBEFLÄCHENABSCHNITTS-BEZEICHNUNGEN AUS SAP, ALS AUCH DIE DURCH DIE WARENFLUSS-NUTZER (WFL) GESETZTEN KURZBEZEICHNUNGEN.DER WERBEFLÄCHENABSCHNITT GIBT AN, IN WELCHEM ABSCHNITT EINES BEREICHS DAS ANGEBOT_1 ABGEBILDET IST (Z.B. TOPLEFT1 = OBEN LINKS AUF DER SEITE IM PROSPEKT).`)
AS SELECT werbeflaechenabschnitt_id,
 spr_id,
 werbeflaechenabschnitt_name,
 werbeflaechenabschnitt_wfl_bez
FROM kfl_production_dbp_data.werbeflaechenabschnitt_spr_zu_1;