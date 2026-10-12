--==============================================================
-- Table: L_IVN_GRUPPE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_GRUPPE
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:24:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ivn_gruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ivn_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kauflandweite eindeutige Nummer zur Einordnung von Gruppen von Atrikel-Lieferantenbeziehungen in Ländern zu konzernweiten Gruppen für Verhandlungen            (IVN = International Vendor Number, international hier als alle Kaufland-Länder übergreifend)'),
ivn_gruppe_bez STRING(100) OPTIONS(description='Bezeichnung der IVN-Gruppe, z.B. Nestle, Haribo, Dr. Oetker'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ivn_gruppe_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='International Vendor Number (IVN) bündelt nationale Artikel-Lieferanten-Kombination zu einer international gleichen, konzerninternen Nummer (IVN Id / IVN Group in Quelle) zusammen.             Mandant ist nur aus technischer Notwendigkeit im PK !!!             (Lieferant als Teilmenge aller Geschäftspartner auf Seite von SAP gepflegt)             Internationale Verhandler Nummer ist eine Kaufland-spezifische Bezeichnung.             Z.B. (aus Bezeichnung wegen Lesbarkeit)              Zum Beispiel werden einer Artikel/Lieferant-Kombination in Tschechien und einer Artikel/Lieferant-Kombination in Deutschland oder Frankreich mit unterschiedlichen Atrikelnummern und Geschäftspartnern die gleiche IVN zugewiesen.             Da sich die Artikelnummern von Land zu Land unterscheiden können, werden erst die Kombinationen aus Artikel/Lieferant/Geschäftspartner eindeutig und per IVN gruppiert.');