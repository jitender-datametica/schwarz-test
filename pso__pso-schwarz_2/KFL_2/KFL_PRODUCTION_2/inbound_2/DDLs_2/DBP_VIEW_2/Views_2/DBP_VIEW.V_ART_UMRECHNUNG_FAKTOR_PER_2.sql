create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ART_UMRECHNUNG_FAKTOR_PER_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	ALTNV_MENGE_EINH_ID COMMENT 'Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 alternative Mengeneinheit eindeutig identifiziert.Aus meinh',
	ART_ID COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	DAT_VON COMMENT 'Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen der Schnittstelle herangezogen.',
	BRUTTOGEW COMMENT 'Das Feld  enthält das Bruttogewicht in der in dem Attribut gew_einh_id aufgeführten Einheit. Aus brgew',
	UMRECH_FAKTOR COMMENT 'Umrechnungsfaktor für eine_2 alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.',
	GEW_EINH_ID COMMENT 'Dieses Feld enthält die Einheit für das Bruttogewicht.Aus gewei',
	DAT_BIS COMMENT 'Gültigkeitsende des Datensatzes. Wenn dieser Datensatz die momentan gültige Version darstellt besitzt dieses Attribut den Wert 31.12.9999.',
	LAENGE COMMENT 'Länge (Tiefe) in cm aus laeng',
	BREITE COMMENT 'Breite in cm aus breit',
	HOEHE COMMENT 'Höhe in cm aus hoehe',
	UMRECH_ZAEHLER COMMENT 'Zähler für die Umrechnung in Basismengeneinheiten',
	UMRECH_NENNER COMMENT 'Nenner für die Umrechnung in Basismengeneinheiten'
) as 
    SELECT 
        mandant_id,
        altnv_menge_einh_id,
        art_id,
        dat_von,
        bruttogew,
        umrech_faktor,
        gew_einh_id,
        dat_bis,
        laenge,
        breite,
        hoehe,
        umrech_zaehler,
        umrech_nenner

FROM DBP_DATA.ART_UMRECHNUNG_FAKTOR_PER_2 ;
