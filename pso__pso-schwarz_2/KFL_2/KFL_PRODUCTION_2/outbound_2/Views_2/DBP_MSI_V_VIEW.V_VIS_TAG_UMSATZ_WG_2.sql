CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), dat
OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_2-DD'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), wup_id
OPTIONS(description='Nummer des Warenumschlagsplatzes'), wg_id OPTIONS(description='ID der Warengruppe'), arthiertyp_id
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), abt_id
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
gj OPTIONS(description='Geschäftsjahr'), kjmo OPTIONS(description='Kalenderjahremonat, Format JJJJMM'), kjwo
OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'), wtag_id OPTIONS(description='Wochentag ID'), ums_netto
OPTIONS(description='Umsatz netto'), ums_netto_af
OPTIONS(description='Aktionsfreier Netto Umsatz auf Ebene Markt / TAG_2 / Warengruppe'), ums_netto_sa
OPTIONS(description='Sonderaktion Netto Umsatz auf Ebene Markt / TAG_2 / Warengruppe'), ums_netto_wvj
OPTIONS(description='Umsatz netto Wochentag im Vorjahr'), ums_netto_af_wvj
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa_wvj
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_wvvj OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'), ums_netto_af_wvvj
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa_wvvj
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_kvj OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'), ums_netto_af_kvj
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa_kvj
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_kvvj OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'), ums_netto_af_kvvj
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_netto_sa_kvvj
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
ums_brutto OPTIONS(description='Umsatz brutto'), ums_brutto_kvj
OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'), ums_brutto_wvj
OPTIONS(description='Umsatz Betrag Brutto Wochentag im Vorjahr'), menge_absatz
OPTIONS(description='Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt'), menge_absatz_af
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 auf Ebene Markt / TAG_2 / Warengruppe'), menge_absatz_sa
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion auf Ebene Markt / TAG_2 / Warengruppe'), menge_absatz_kvj
OPTIONS(description='Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_af_kvj
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
menge_absatz_sa_kvj
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
menge_absatz_wvj
OPTIONS(description='Menge Wochentag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_af_wvj
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
menge_absatz_sa_wvj
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'))
OPTIONS(DESCRIPTION = `VIS - AGGREGAT AUF TAGESEBENE`) AS SELECT mandant_id,
 dat,
 nb_id,
 wup_id,
 wg_id,
 arthiertyp_id,
 wrg_id,
 abt_id,
 gj,
 kjmo,
 kjwo,
 wtag_id,
 ums_netto,
 ums_netto_af,
 ums_netto_sa,
 ums_netto_wvj,
 ums_netto_af_wvj,
 ums_netto_sa_wvj,
 ums_netto_wvvj,
 ums_netto_af_wvvj,
 ums_netto_sa_wvvj,
 ums_netto_kvj,
 ums_netto_af_kvj,
 ums_netto_sa_kvj,
 ums_netto_kvvj,
 ums_netto_af_kvvj,
 ums_netto_sa_kvvj,
 ums_brutto,
 ums_brutto_kvj,
 ums_brutto_wvj,
 menge_absatz,
 menge_absatz_af,
 menge_absatz_sa,
 menge_absatz_kvj,
 menge_absatz_af_kvj,
 menge_absatz_sa_kvj,
 menge_absatz_wvj,
 menge_absatz_af_wvj,
 menge_absatz_sa_wvj
FROM kfl_production_dbp_msi_data.vis_tag_umsatz_wg_2;