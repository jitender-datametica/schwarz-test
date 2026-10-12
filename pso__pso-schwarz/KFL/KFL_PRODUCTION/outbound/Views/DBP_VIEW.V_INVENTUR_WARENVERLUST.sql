CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_warenverlust (mandant_id
OPTIONS(description='Mandant im DWH.'), inventur_id
OPTIONS(description='Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.'), wup_id
OPTIONS(description='Der "WUP" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter WUP ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
inventurart_id
OPTIONS(description='Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.'),
dat_inventur_von
OPTIONS(description='Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.'),
dat_inventur_bis
OPTIONS(description='Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.'),
dat_inventur_buchung_von
OPTIONS(description='Start des betrachteten Inventurzeitraums nach Verbuchung der Inventur in SAP.'),
dat_inventur_buchung_bis
OPTIONS(description='Ende des betrachteten Inventurzeitraums nach Verbuchung der Inventur in SAP.'), gj
OPTIONS(description='Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.'),
art_id
OPTIONS(description='Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
wg_id OPTIONS(description='ID der Warengruppe'), owg_id OPTIONS(description='ID der Oberwarengruppe'), hwg_id
OPTIONS(description='ID der Hauptwarengruppe'), abt_id
OPTIONS(description='Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.'),
loesch_fg
OPTIONS(description='Löschkennzeichen, das nachträglich durch VT Orga in den Ländern gesetzt werden kann, falls Zeitraum oder Inventurart aus der Betrachtung herausgenommen werden soll.'))
OPTIONS(DESCRIPTION = `DIE TABELLE BASIERT AUF EXCEL UND DIENT ALS STEUERTABELLE FÜR DIE BERECHNUNG VON WARENVERLUSTEN. SIE ENTHÄLT DIE SPEZIFISCHEN INVENTURARTEN, LÄNDER, FILIALEN UND ZEITRÄUME, FÜR DIE DIE VERLUSTBERECHNUNGEN DURCHGEFÜHRT WERDEN SOLLEN.`)
AS SELECT mandant_id,
 inventur_id,
 wup_id,
 nb_id,
 inventurart_id,
 dat_inventur_von,
 dat_inventur_bis,
 dat_inventur_buchung_von,
 dat_inventur_buchung_bis,
 gj,
 art_id,
 wg_id,
 owg_id,
 hwg_id,
 abt_id,
 loesch_fg
FROM kfl_production_dbp_data.inventur_warenverlust;