CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_vk_kondition_per_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH, aus MANDT.'), verkaufsorganisation_id
OPTIONS(description='Verkaufsorganisation, aus VKORG.'), vw_id OPTIONS(description='ID des Vertriebswegs, aus VTWEG.'),
wup_id OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum, aus WERKS.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), art_id
OPTIONS(description='Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1, transformiert aus MATNR.'),
konditionsart_id OPTIONS(description='Konditionsart, aus KSCHL.'), datzeit_gueltig_von_kondition
OPTIONS(description='Gültigkeitsbeginn des Preises, aus DATAB und TIMAB.'), datzeit_gueltig_bis_kondition
OPTIONS(description='Gültigkeitsende des Preises, aus DATBI und TIMBI'), datzeit_erstellung_kondition
OPTIONS(description='Zeitpunkt, an dem diese Preiskondition angelegt wurde, aus ERDAT und ERZET. Ist vor oder gleich dem Gültigkeitsbeginn.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR, aus KONWA.'), preis_vk_brutto
OPTIONS(description='Verkaufspreis in brutto, aus KBETR.'), konditionssatz_id
OPTIONS(description='Konditionssatznummer, aus KNUMH.'), aktion_id
OPTIONS(description='Eindeutige Kennung einer Aktion_1, aus WAKTION.'), quelltabelle_name
OPTIONS(description='Name der Quelltabelle im SAP System aus dem die Daten in ZEK_SP_STORE_VAL gefüllt wurden, aus SOURCE.Jede dieser Tabellen entspricht in etwa einem Prozessschritt an dem ein VK_1-Preis definiert wurde.A006 - Preislistentyp/Währung/MaterialA517 - VKO/VTW/WERK/MATZVKP2 - Markt - Verkaufspreise speziell (z.B. AS-Food)ZVKP3 - Markt - Verkaufspreise speziell (z.B. AS-Food)'),
datzeit_erstellung_quelle
OPTIONS(description='Zeitpunkt, an dem der Datensatz im Quellsystem eingefügt wurde, aus CRDATE und CRTIME.'),
datzeit_extrakt OPTIONS(description='Zeitpunkt der Extraktion aus dem Quellsystem.'))
OPTIONS(DESCRIPTION = `WWC - This table contains different sales_1 prices for articles and their validity_1-timeframes. Different sales_1 prices are created and stored because of different processes. More than one sales_1 price can be valid at a time depending on factors such as condition type or sales_1 channel, i.e. KL app users can get an additional discount / lower price at check-out, or package_1 damage resulting in an additional discount.Source: ZEK_SP_STORE_VAL`)
AS SELECT mandant_id,
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
FROM kfl_production_dbp_data.art_wup_vk_kondition_per_1;