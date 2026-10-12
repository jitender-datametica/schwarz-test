CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_transportmittel (mandant_id OPTIONS(description='Mandant im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_transportmittel_id
OPTIONS(description='ID des Transportmittels (KEY0 / Werte: 0-50)'), tms_transportmittel_lfd_nr
OPTIONS(description='ID des Transportmittels im Quellsystem.'), art_id
OPTIONS(description='Artikel-ID  des Transportmittels einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
tms_transportmittel_name OPTIONS(description='Name des Transportmittels'), tms_transportmittel_bez
OPTIONS(description='Kurzbezeichnung des Transportmittels'))
OPTIONS(DESCRIPTION = `TMS - LOOKUPTABELLE FÜR DIE TRANSPORTMITTEL`) AS SELECT mandant_id,
 system_id,
 tms_transportmittel_id,
 tms_transportmittel_lfd_nr,
 art_id,
 tms_transportmittel_name,
 tms_transportmittel_bez
FROM kfl_production_dbp_data.l_tms_transportmittel;