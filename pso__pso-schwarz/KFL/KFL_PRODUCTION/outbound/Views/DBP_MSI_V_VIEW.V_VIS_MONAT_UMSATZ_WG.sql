CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_vis_monat_umsatz_wg (mandant_id
OPTIONS(description='Mandant im DWH'), wup_id OPTIONS(description='Nummer des Warenumschlagsplatzes'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), kjmo
OPTIONS(description='Kalenderjahremonat, Format JJJJMM'), arthiertyp_id
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_id OPTIONS(description='ID der Warengruppe'), abt_id
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
gj OPTIONS(description='Geschäftsjahr'), ums_netto OPTIONS(description='Umsatz netto'), ums_netto_kvj
OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'), ums_netto_kvvj
OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'), ums_netto_plan
OPTIONS(description='Umsatz netto Planwert'), ums_brutto OPTIONS(description='Umsatz brutto'), ums_brutto_kvj
OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'), menge_absatz
OPTIONS(description='Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt'), menge_absatz_kvj
OPTIONS(description='Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_kvvj
OPTIONS(description='Menge Kalendertag im Vor-Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'))
OPTIONS(DESCRIPTION = `VIS - AGGREGAT AUF MONATSEBENE - MULTISET`) AS SELECT mandant_id,
 wup_id,
 nb_id,
 wrg_id,
 kjmo,
 arthiertyp_id,
 wg_id,
 abt_id,
 gj,
 ums_netto,
 ums_netto_kvj,
 ums_netto_kvvj,
 ums_netto_plan,
 ums_brutto,
 ums_brutto_kvj,
 menge_absatz,
 menge_absatz_kvj,
 menge_absatz_kvvj
FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg;