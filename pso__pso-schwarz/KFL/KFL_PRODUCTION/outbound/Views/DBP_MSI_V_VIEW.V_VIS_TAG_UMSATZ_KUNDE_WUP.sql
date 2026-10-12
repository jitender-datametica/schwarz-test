CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup (mandant_id
OPTIONS(description='Mandant im DWH'), dat
OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM-DD'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), wup_id
OPTIONS(description='Nummer des Warenumschlagsplatzes'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), gj OPTIONS(description='Geschäftsjahr'), akt_gj
OPTIONS(description='Zähler auf Basis des aktuellen Geschäftsjahres'), kjmo
OPTIONS(description='Kalenderjahremonat, Format JJJJMM'), akt_mo
OPTIONS(description='Zähler auf Basis des aktuellen Kalendermonats'), kjwo
OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'), akt_wo
OPTIONS(description='Zähler auf Basis der aktuellen Kalenderwoche'), wtag_id OPTIONS(description='Wochentag ID'),
akt_tag OPTIONS(description='Zähler auf Basis des aktuellen Tages'), ums_netto OPTIONS(description='Umsatz netto'),
ums_netto_af OPTIONS(description='Aktionsfreier Netto Umsatz auf Ebene Markt / Tage'), ums_netto_sa
OPTIONS(description='Sonderaktion Netto Umsatz auf Ebene Markt / Tag'), ums_netto_wvj
OPTIONS(description='Umsatz netto Wochentag im Vorjahr'), ums_netto_af_wvj
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
ums_netto_sa_wvj
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
ums_netto_wvvj OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'), ums_netto_af_wvvj
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / Tag'),
ums_netto_sa_wvvj
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / Tag'),
ums_netto_kvj OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'), ums_netto_af_kvj
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
ums_netto_sa_kvj OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
ums_netto_kvvj OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'), ums_netto_af_kvvj
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG'),
ums_netto_sa_kvvj
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG'),
ums_netto_plan OPTIONS(description='Umsatz netto Planwert'), ums_netto_plan_extern
OPTIONS(description='Umsatz netto Planwert extern'), ums_brutto OPTIONS(description='Umsatz brutto'), ums_brutto_wvj
OPTIONS(description='Umsatz Betrag Brutto Wochentag im Vorjahr'), ums_brutto_wvvj
OPTIONS(description='Umsatz brutto Wochentag im Vorvorjahr'), ums_brutto_kvj
OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'), ums_brutto_kvvj
OPTIONS(description='Umsatz brutto Kalendertag im Vor-Vorjahr'), anz_kunde OPTIONS(description='Anzahl Kunden'),
anz_kunde_wvj OPTIONS(description='Anzahl Kunden Wochentag im Vorjahr'), anz_kunde_kvj
OPTIONS(description='Anzahl Kunden Kalendertag im Vorjahr'), anz_offen OPTIONS(description='Anzahl Öffnungstage'),
anz_offen_wvj OPTIONS(description='Anzahl Öffnungstage Wochentag im Vorjahr'), anz_offen_wvvj
OPTIONS(description='Anzahl Öffnungstage Wochentag im Vor-Vorjahr'), anz_offen_kvj
OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vorjahr'), anz_offen_kvvj
OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vor-Vorjahr'), menge_absatz
OPTIONS(description='Menge an verkauften Artikel auf Ebene Markt / Tag'), menge_absatz_af
OPTIONS(description='Menge an verkauften aktionsfreien Artikel auf Ebene Markt / Tag'), menge_absatz_sa
OPTIONS(description='Menge an verkauften Artikel in Sonderaktion auf Ebene Markt / Tag'), menge_absatz_wvj
OPTIONS(description='Menge an verkauften Artikel des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
menge_absatz_af_wvj
OPTIONS(description='Menge an verkauften aktionsfreien Artikel des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
menge_absatz_sa_wvj
OPTIONS(description='Menge an verkauften Artikel in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
menge_absatz_kvj
OPTIONS(description='Menge an verkauften Artikel des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
menge_absatz_af_kvj
OPTIONS(description='Menge an verkauften aktionsfreien Artikel des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
menge_absatz_sa_kvj
OPTIONS(description='Menge an verkauften Artikel in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
menge_absatz_ohne_pfand_plan
OPTIONS(description='Geplante Menge an verkauften Artikel ohne Pfandartikel auf Ebene Markt / Tag'))
OPTIONS(DESCRIPTION = `VIS - AGGREGAT AUF TAGESEBENE - MULTISET - BELADUNG AUS WUP_PLAN_TAG`) AS SELECT mandant_id,
 dat,
 nb_id,
 wup_id,
 wrg_id,
 gj,
 akt_gj,
 kjmo,
 akt_mo,
 kjwo,
 akt_wo,
 wtag_id,
 akt_tag,
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
 ums_netto_plan,
 ums_netto_plan_extern,
 ums_brutto,
 ums_brutto_wvj,
 ums_brutto_wvvj,
 ums_brutto_kvj,
 ums_brutto_kvvj,
 anz_kunde,
 anz_kunde_wvj,
 anz_kunde_kvj,
 anz_offen,
 anz_offen_wvj,
 anz_offen_wvvj,
 anz_offen_kvj,
 anz_offen_kvvj,
 menge_absatz,
 menge_absatz_af,
 menge_absatz_sa,
 menge_absatz_wvj,
 menge_absatz_af_wvj,
 menge_absatz_sa_wvj,
 menge_absatz_kvj,
 menge_absatz_af_kvj,
 menge_absatz_sa_kvj,
 menge_absatz_ohne_pfand_plan
FROM kfl_production_dbp_msi_data.vis_tag_umsatz_kunde_wup;