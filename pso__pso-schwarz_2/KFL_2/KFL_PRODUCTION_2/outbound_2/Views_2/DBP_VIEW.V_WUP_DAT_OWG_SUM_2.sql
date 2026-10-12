CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_dat_owg_sum_2 (mandant_id OPTIONS(description='PK Mandant_2 im DWH'),
wup_id OPTIONS(description='PK Warenumschlagsplatz'), nb_id
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), dat
OPTIONS(description='PK - Datum im Format JJJJ-MM_2-TT'), owg_id OPTIONS(description='ID der Oberwarengruppe'),
arthiertyp_id
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
bonanzahl OPTIONS(description='Anzahl der Kassenbons'), bonanzahl_pre_pack
OPTIONS(description='Anzahl der Kassenbons mit Pre-Pack Artikeln'), bonanzahl_sug
OPTIONS(description='Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.'))
OPTIONS(DESCRIPTION = `VIS - TAGES-AGGREGAT PRO MARKT UND OBERWARENGRUPPE`) AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 owg_id,
 arthiertyp_id,
 bonanzahl,
 bonanzahl_pre_pack,
 bonanzahl_sug
FROM kfl_production_dbp_data.wup_dat_owg_sum_2;