CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_ROHSTOFF_MONITORING_NACHRICHT_1 (
   nachricht_typ_id                         COMMENT 'Enthält die ID um welchen Nachrichtentyp es sich handelt.
0 = Trend
1 = Märkte
2 = Preisbeeinflussender Faktoren'
  ,rohstoff_kategorie_kfl_name              COMMENT 'Kaufland interne Kategorische Zuordnung eines Rohstoffs.'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,nachricht_titel_txt                      COMMENT 'Enthält den Titel einesTextblocks im Report.'
  ,nachricht_inhalt_txt                     COMMENT 'Kaufland interne Beschreibung der Kategorie des Rohstoffs.'
  ,trend_typ_id                             COMMENT 'Gibt den Trend der Rohstoffskategorie an für die Einfärbung im Report (0-2).'
  ,dat_trend_von                            COMMENT 'Gültigkeitsstart des Trend der Kategorie.'
  ,prognose_halbjahr_typ_id                 COMMENT 'Prognosetyp der Kategorie für das Halbjahr an (0-4).'
  ,nachricht_link_txt                       COMMENT 'Hinterlegt einen Link zu Netzlaufwerken/Sharepoint oder ins Internet.'
  ,preis_reduzierende_faktoren_txt          COMMENT 'Beschreibungen von Preisreduzierende Faktoren.'
  ,preis_steigernde_faktoren_txt            COMMENT 'Beschreibungen von Preissteigernde Faktoren.'
  ,forecast_txt                             COMMENT 'Enthält eine_1 Forecast-Beschreibung z.B. Ausblick für das Jahr ist positiv.'
  ,dat_gueltig_von                          COMMENT 'Gültigkeitsstart des Eintrags.'
  ,dat_gueltig_bis                          COMMENT 'Gültigkeitsende des Eintrags.'
)
COMMENT = 'Informationen wie Trend, Märkte und preisbeeinflussender Faktoren einer Rohstoffskategorie.'
 AS 
    SELECT 
        nachricht_typ_id,
        rohstoff_kategorie_kfl_name,
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

FROM DBP_MSI_DATA.TS_ROHSTOFF_MONITORING_NACHRICHT_1 ;