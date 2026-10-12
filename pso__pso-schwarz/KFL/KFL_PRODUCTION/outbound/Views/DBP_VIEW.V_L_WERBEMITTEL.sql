CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbemittel (mandant_id OPTIONS(description='Mandant im DWH.'),
werbemittelkanal_id
OPTIONS(description='Werbemittel Art ID - medium through which the advertisement is shown (paper, digital)'),
werbemittel_id
OPTIONS(description='Werbemittel - on what item the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)'),
werbemittel_avq_prio_nr
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbemittel bei der Berechnung der Abverkaufsquote (AVQ). Werbemittel mit der gleichen ID werden zusammengefasst.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DIE WERBEMITTEL, IN DENEN DIE WERBUNG GESCHALTET WIRD (Z.B. ONLINE, PROSPEKT,...). AUS SAP P11. DIE TABELLE ENTHÄLT ZUDEM BEZEICHNUNGEN ZUR PRIORISIERUNG DER ABVERKAUFSQUOTE (AVQ).`)
AS SELECT mandant_id,
 werbemittelkanal_id,
 werbemittel_id,
 werbemittel_avq_prio_nr
FROM kfl_production_dbp_data.l_werbemittel;