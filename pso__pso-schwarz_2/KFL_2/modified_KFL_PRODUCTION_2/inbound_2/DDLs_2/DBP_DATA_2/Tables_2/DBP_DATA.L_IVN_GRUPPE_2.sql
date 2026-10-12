--==============================================================
-- Table: L_IVN_GRUPPE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_GRUPPE_2
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:24:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_IVN_GRUPPE_2 (
   MANDANT_ID                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   IVN_GRUPPE_ID                       INTEGER     NOT NULL COMMENT 'Kauflandweite eindeutige Nummer zur Einordnung von Gruppen von Atrikel-Lieferantenbeziehungen in Ländern zu konzernweiten Gruppen für Verhandlungen
            (IVN = International Vendor Number, international hier als alle Kaufland-Länder übergreifend)',
   IVN_GRUPPE_BEZ                      VARCHAR(100)     COMMENT 'Bezeichnung der IVN-Gruppe_2, z.B. Nestle, Haribo, Dr. Oetker',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_IVN_GRUPPE PRIMARY KEY (IVN_GRUPPE_ID, MANDANT_ID) NOT ENFORCED
)  COMMENT = 'International Vendor Number (IVN) bündelt nationale Artikel_2-Lieferanten-Kombination zu einer international gleichen, konzerninternen Nummer (IVN Id / IVN Group in Quelle) zusammen.
             Mandant_2 ist nur aus technischer Notwendigkeit im PK !!!
             (Lieferant als Teilmenge aller Geschäftspartner auf Seite von SAP gepflegt)
             Internationale Verhandler Nummer ist eine_2 Kaufland-spezifische Bezeichnung.
             Z.B. (aus Bezeichnung wegen Lesbarkeit) 
             Zum Beispiel werden einer Artikel_2/Lieferant-Kombination in Tschechien und einer Artikel_2/Lieferant-Kombination in Deutschland oder Frankreich mit unterschiedlichen Atrikelnummern und Geschäftspartnern die gleiche IVN zugewiesen.
             Da sich die Artikelnummern von Land_2 zu Land_2 unterscheiden können, werden erst die Kombinationen aus Artikel_2/Lieferant/Geschäftspartner eindeutig und per IVN gruppiert.';
