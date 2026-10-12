CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_vis_monat_umsatz_abt (mandant_id
OPTIONS(description='Mandant im DWH'), wup_id OPTIONS(description='Nummer des Warenumschlagsplatzes'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), kjmo
OPTIONS(description='Kalenderjahremonat, Format JJJJMM'), abt_id
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
gj OPTIONS(description='Geschäftsjahr'), akt_gj OPTIONS(description='Zähler auf Basis des aktuellen Geschäftsjahres'),
akt_mo
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat darstellt. Der aktuelle Monat hat den Wert 0, der vorige Monat -1 und der nächste Monat den Wert 1'),
mo_kj OPTIONS(description='Laufender Monat im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'),
ums_netto OPTIONS(description='Umsatz netto'), ums_netto_kvj OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
ums_netto_kvvj OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'), ums_netto_plan
OPTIONS(description='Umsatz netto Planwert')) OPTIONS(DESCRIPTION = `VIS - AGGREGAT AUF MONATSEBENE - MULTISET`) AS
SELECT mandant_id,
 wup_id,
 nb_id,
 wrg_id,
 kjmo,
 abt_id,
 arthiertyp_id,
 gj,
 akt_gj,
 akt_mo,
 mo_kj,
 ums_netto,
 ums_netto_kvj,
 ums_netto_kvvj,
 ums_netto_plan
FROM kfl_production_dbp_msi_data.vis_monat_umsatz_abt;