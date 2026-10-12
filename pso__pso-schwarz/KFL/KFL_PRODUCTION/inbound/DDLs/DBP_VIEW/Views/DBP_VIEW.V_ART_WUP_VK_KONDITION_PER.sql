CREATE OR REPLACE VIEW DBP_VIEW.V_ART_WUP_VK_KONDITION_PER (
   mandant_id                               COMMENT 'Mandant im DWH, aus MANDT.'
  ,verkaufsorganisation_id                  COMMENT 'Verkaufsorganisation, aus VKORG.'
  ,vw_id                                    COMMENT 'ID des Vertriebswegs, aus VTWEG.'
  ,wup_id                                   COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum, aus WERKS.'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,art_id                                   COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1, transformiert aus MATNR.'
  ,konditionsart_id                         COMMENT 'Konditionsart, aus KSCHL.'
  ,datzeit_gueltig_von_kondition            COMMENT 'Gültigkeitsbeginn des Preises, aus DATAB und TIMAB.'
  ,datzeit_gueltig_bis_kondition            COMMENT 'Gültigkeitsende des Preises, aus DATBI und TIMBI'
  ,datzeit_erstellung_kondition             COMMENT 'Zeitpunkt, an dem diese Preiskondition angelegt wurde, aus ERDAT und ERZET. Ist vor oder gleich dem Gültigkeitsbeginn.'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR, aus KONWA.'
  ,preis_vk_brutto                          COMMENT 'Verkaufspreis in brutto, aus KBETR.'
  ,konditionssatz_id                        COMMENT 'Konditionssatznummer, aus KNUMH.'
  ,aktion_id                                COMMENT 'Eindeutige Kennung einer Aktion, aus WAKTION.'
  ,quelltabelle_name                        COMMENT 'Name der Quelltabelle im SAP System aus dem die Daten in ZEK_SP_STORE_VAL gefüllt wurden, aus SOURCE.
Jede dieser Tabellen entspricht in etwa einem Prozessschritt an dem ein VK-Preis definiert wurde.
A006 - Preislistentyp/Währung/Material
A517 - VKO/VTW/WERK/MAT
ZVKP2 - Markt - Verkaufspreise speziell (z.B. AS-Food)
ZVKP3 - Markt - Verkaufspreise speziell (z.B. AS-Food)'
  ,datzeit_erstellung_quelle                COMMENT 'Zeitpunkt, an dem der Datensatz im Quellsystem eingefügt wurde, aus CRDATE und CRTIME.'
  ,datzeit_extrakt                          COMMENT 'Zeitpunkt der Extraktion aus dem Quellsystem.'
)
COMMENT = 'WWC - This table contains different sales prices for articles and their validity-timeframes. Different sales prices are created and stored because of different processes. More than one sales price can be valid at a time depending on factors such as condition type or sales channel, i.e. KL app users can get an additional discount / lower price at check-out, or package damage resulting in an additional discount.
Source: ZEK_SP_STORE_VAL'
 AS 
    SELECT 
        mandant_id,
        verkaufsorganisation_id,
        vw_id,
        wup_id,
        nb_id,
        art_id,
        konditionsart_id,
        datzeit_gueltig_von_kondition,
        datzeit_gueltig_bis_kondition,
        datzeit_erstellung_kondition,
        wrg_id,
        preis_vk_brutto,
        konditionssatz_id,
        aktion_id,
        quelltabelle_name,
        datzeit_erstellung_quelle,
        datzeit_extrakt

FROM DBP_DATA.ART_WUP_VK_KONDITION_PER ;