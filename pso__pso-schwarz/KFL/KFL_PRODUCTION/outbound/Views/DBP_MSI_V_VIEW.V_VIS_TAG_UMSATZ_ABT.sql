CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_abt (mandant_id
OPTIONS(description='Mandant im DWH'), dat
OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM-DD'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), wup_id
OPTIONS(description='Nummer des Warenumschlagsplatzes'), arthiertyp_id
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), abt_id
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
kjmo OPTIONS(description='Kalenderjahremonat, Format JJJJMM'), kjwo
OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'), ums_netto OPTIONS(description='Umsatz netto'), ums_netto_wvj
OPTIONS(description='Umsatz netto Wochentag im Vorjahr'), ums_netto_wvvj
OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'), ums_netto_kvj
OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'), ums_netto_kvvj
OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'))
OPTIONS(DESCRIPTION = `VIS - AGGREGAT AUF TAGESEBENE - MULTISET`) AS SELECT mandant_id,
 dat,
 nb_id,
 wup_id,
 arthiertyp_id,
 wrg_id,
 abt_id,
 kjmo,
 kjwo,
 ums_netto,
 ums_netto_wvj,
 ums_netto_wvvj,
 ums_netto_kvj,
 ums_netto_kvvj
FROM kfl_production_dbp_msi_data.vis_tag_umsatz_abt;