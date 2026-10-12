--==============================================================
-- Table: art_wup_vk_kondition_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_vk_kondition_per
   generated from Powerdesigner on Donnerstag, 24. Oktober 2024 18:12:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_VK_KONDITION_PER (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH, aus MANDT.',
   verkaufsorganisation_id             VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsorganisation, aus VKORG.',
   vw_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebswegs, aus VTWEG.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum, aus WERKS.',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1, transformiert aus MATNR.',
   konditionsart_id                    VARCHAR(4)       NOT NULL COMMENT 'Konditionsart, aus KSCHL.',
   datzeit_gueltig_von_kondition       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsbeginn des Preises, aus DATAB und TIMAB.',
   datzeit_gueltig_bis_kondition       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsende des Preises, aus DATBI und TIMBI',
   datzeit_erstellung_kondition        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitpunkt, an dem diese Preiskondition angelegt wurde, aus ERDAT und ERZET. Ist vor oder gleich dem Gültigkeitsbeginn.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR, aus KONWA.',
   preis_vk_brutto                     NUMBER(38,2)     NOT NULL COMMENT 'Verkaufspreis in brutto, aus KBETR.',
   konditionssatz_id                   VARCHAR(10)      COMMENT 'Konditionssatznummer, aus KNUMH.',
   aktion_id                           VARCHAR(10)      COMMENT 'Eindeutige Kennung einer Aktion, aus WAKTION.',
   quelltabelle_name                   VARCHAR(100)     NOT NULL COMMENT 'Name der Quelltabelle im SAP System aus dem die Daten in ZEK_SP_STORE_VAL gefüllt wurden, aus SOURCE.
            Jede dieser Tabellen entspricht in etwa einem Prozessschritt an dem ein VK-Preis definiert wurde.
            A006 - Preislistentyp/Währung/Material
            A517 - VKO/VTW/WERK/MAT
            ZVKP2 - Markt - Verkaufspreise speziell (z.B. AS-Food)
            ZVKP3 - Markt - Verkaufspreise speziell (z.B. AS-Food)',
   datzeit_erstellung_quelle           TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitpunkt, an dem der Datensatz im Quellsystem eingefügt wurde, aus CRDATE und CRTIME.',
   datzeit_extrakt                     TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitpunkt der Extraktion aus dem Quellsystem.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_VK_KONDITION_PER PRIMARY KEY (mandant_id, verkaufsorganisation_id, vw_id, wup_id, nb_id, art_id, konditionsart_id, datzeit_gueltig_von_kondition) NOT ENFORCED
)  COMMENT = 'WWC - This table contains different sales prices for articles and their validity-timeframes. Different sales prices are created and stored because of different processes. More than one sales price can be valid at a time depending on factors such as condition type or sales channel, i.e. KL app users can get an additional discount / lower price at check-out, or package damage resulting in an additional discount.
             Source: ZEK_SP_STORE_VAL';
