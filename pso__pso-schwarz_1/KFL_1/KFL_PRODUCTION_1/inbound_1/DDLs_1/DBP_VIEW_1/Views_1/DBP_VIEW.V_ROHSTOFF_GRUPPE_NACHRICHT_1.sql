CREATE OR REPLACE VIEW DBP_VIEW.V_ROHSTOFF_GRUPPE_NACHRICHT_1 (
   rohstoff_gruppe_typ_id                   COMMENT 'ID des Gruppierungstyps eines Rohstoffs.'
  ,rohstoff_gruppe_name                     COMMENT 'Name der Gruppe_1 eines Rohstoffs nach Gruppierungstyp.'
  ,nachricht_typ_id                         COMMENT 'Enthält die ID um welchen Nachrichtentyp es sich handelt.
0 = Trend
1 = Märkte
2 = Preisbeeinflussender Faktoren'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,nachricht_titel_txt                      COMMENT 'Enthält den Titel einesTextblocks im Report.'
  ,nachricht_inhalt_txt                     COMMENT 'Kaufland interne Beschreibung der Rohstoffgruppe des Rohstoffs.'
  ,trend_typ_id                             COMMENT 'Gibt den Trend der Rohstoffsgruppe an für die Einfärbung im Report (0-2).
0 =  Aufwaertstrend
1 =  Abwaertstrend
2 =  Seitwaertstrend'
  ,dat_trend_von                            COMMENT 'Gültigkeitsstart des Trend der Rohstoffsgruppe.'
  ,prognose_halbjahr_typ_id                 COMMENT 'Prognosetyp der Rohstoffsgruppe für das Halbjahr an (0-4).
0  =  >+20%
1  =  +5 -20%
2  =  bis + -5%
3  = -5 -20 %
4  = > -20%'
  ,nachricht_link_txt                       COMMENT 'Hinterlegt einen Link zu Netzlaufwerken/Sharepoint oder ins Internet.'
  ,preis_reduzierende_faktoren_txt          COMMENT 'Beschreibungen von Preisreduzierende Faktoren.'
  ,preis_steigernde_faktoren_txt            COMMENT 'Beschreibungen von Preissteigernde Faktoren.'
  ,forecast_txt                             COMMENT 'Enthält eine_1 Forecast-Beschreibung z.B. Ausblick für das Jahr ist positiv.'
  ,dat_gueltig_von                          COMMENT 'Gültigkeitsstart des Eintrags.'
  ,dat_gueltig_bis                          COMMENT 'Gültigkeitsende des Eintrags'
)
COMMENT = 'Nachrichten (Trend, Markt und Prognose) über Rohstoffskategorie.'
 AS 
    SELECT 
        rohstoff_gruppe_typ_id,
        rohstoff_gruppe_name,
        nachricht_typ_id,
        spr_id,
        nachricht_titel_txt,
        nachricht_inhalt_txt,
        trend_typ_id,
        dat_trend_von,
        prognose_halbjahr_typ_id,
        nachricht_link_txt,
        preis_reduzierende_faktoren_txt,
        preis_steigernde_faktoren_txt,
        forecast_txt,
        dat_gueltig_von,
        dat_gueltig_bis

FROM DBP_DATA.ROHSTOFF_GRUPPE_NACHRICHT_1 ;