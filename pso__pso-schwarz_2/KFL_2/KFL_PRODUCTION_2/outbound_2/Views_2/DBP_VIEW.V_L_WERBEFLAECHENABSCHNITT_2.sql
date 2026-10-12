CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbeflaechenabschnitt_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), werbeflaechenabschnitt_id OPTIONS(description='ID des Werbeflächenabschnitts'),
werbeflaechenabschnitt_avq_prio_nr
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenabschnitte bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenabschnitte mit der gleichen ID werden zusammengefasst.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DEN WERBEFLÄCHENABSCHNITT. AUS ZPMR_WBM_ABSBEZ(SAP P11). ENTHÄLT SOWOHL DIE WERBEFLÄCHENABSCHNITTS-BEZEICHNUNGEN AUS SAP, ALS AUCH DIE BEZEICHNUNGEN ZUR PRIORISIERUNG DER ABVERKAUFSQUOTE (AVQ).DER WERBEFLÄCHENABSCHNITT GIBT AN, IN WELCHEM ABSCHNITT EINES BEREICHS DAS ANGEBOT_2 ABGEBILDET IST (Z.B. TOPLEFT1 = OBEN LINKS AUF DER SEITE IM PROSPEKT).`)
AS SELECT mandant_id,
 werbeflaechenabschnitt_id,
 werbeflaechenabschnitt_avq_prio_nr
FROM kfl_production_dbp_data.l_werbeflaechenabschnitt_2;