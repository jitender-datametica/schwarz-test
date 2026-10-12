--==============================================================
-- Table: L_IVN_GRUPPE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_GRUPPE
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:24:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_IVN_GRUPPE (
   MANDANT_ID                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   IVN_GRUPPE_ID                       NUMBER(38,0)     NOT NULL COMMENT 'Kauflandweite eindeutige Nummer zur Einordnung von Gruppen von Atrikel-Lieferantenbeziehungen in Ländern zu konzernweiten Gruppen für Verhandlungen
            (IVN = International Vendor Number, international hier als alle Kaufland-Länder übergreifend)',
   IVN_GRUPPE_BEZ                      VARCHAR(100)     COMMENT 'Bezeichnung der IVN-Gruppe, z.B. Nestle, Haribo, Dr. Oetker',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_IVN_GRUPPE PRIMARY KEY (IVN_GRUPPE_ID, MANDANT_ID) NOT ENFORCED
)  COMMENT = 'International Vendor Number (IVN) bündelt nationale Artikel-Lieferanten-Kombination zu einer international gleichen, konzerninternen Nummer (IVN Id / IVN Group in Quelle) zusammen.
             Mandant ist nur aus technischer Notwendigkeit im PK !!!
             (Lieferant als Teilmenge aller Geschäftspartner auf Seite von SAP gepflegt)
             Internationale Verhandler Nummer ist eine Kaufland-spezifische Bezeichnung.
             Z.B. (aus Bezeichnung wegen Lesbarkeit) 
             Zum Beispiel werden einer Artikel/Lieferant-Kombination in Tschechien und einer Artikel/Lieferant-Kombination in Deutschland oder Frankreich mit unterschiedlichen Atrikelnummern und Geschäftspartnern die gleiche IVN zugewiesen.
             Da sich die Artikelnummern von Land zu Land unterscheiden können, werden erst die Kombinationen aus Artikel/Lieferant/Geschäftspartner eindeutig und per IVN gruppiert.';
