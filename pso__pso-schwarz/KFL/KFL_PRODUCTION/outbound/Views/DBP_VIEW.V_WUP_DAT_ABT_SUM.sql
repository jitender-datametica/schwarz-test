CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_dat_abt_sum (mandant_id OPTIONS(description='PK Mandant im DWH'),
wup_id OPTIONS(description='PK Warenumschlagsplatz'), nb_id
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), dat
OPTIONS(description='PK - Datum im Format JJJJ-MM-TT'), abt_id
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
bonanzahl OPTIONS(description='Anzahl der Kassenbons'), bonanzahl_pre_pack
OPTIONS(description='Anzahl der Kassenbons mit Pre-Pack Artikeln'), bonanzahl_sug
OPTIONS(description='Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.'))
OPTIONS(DESCRIPTION = `VIS - TAGES-AGGREGAT PRO MARKT UND ABTEILUNG`) AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 abt_id,
 arthiertyp_id,
 bonanzahl,
 bonanzahl_pre_pack,
 bonanzahl_sug
FROM kfl_production_dbp_data.wup_dat_abt_sum;