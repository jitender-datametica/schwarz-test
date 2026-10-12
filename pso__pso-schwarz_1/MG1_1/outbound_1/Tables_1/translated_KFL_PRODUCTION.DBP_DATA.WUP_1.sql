CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WUP_1 (
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
VW_ID INTEGER DEFAULT 0
OPTIONS(description='ID des Vertriebsweges. Einkaufs-Sicht auf die wup_1 Objekte (Restaurants und Backshops z.Bsp. haben keinen Vertriebsweg)'),
VS_ID INTEGER DEFAULT 0 OPTIONS(description='ID der Vertriebsschiene. Vertriebs-Sicht auf die wup_1 Objekte'),
LAND_ID STRING(8) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Land_1, in dem sich der Markt befindet (PL, CZ, DE,..)'),
REGION_ID INTEGER OPTIONS(description='Bundesland, in dem sich der Markt befindet'),
DAT_VON DATE OPTIONS(description='Eröffnungsdatum. Muss nicht der 1. Abverkaufstag sein! Format YYYY-MM_1-DD'),
WUP_TYP_ID INTEGER DEFAULT 0
OPTIONS(description='entspricht der Kennzeichnung der Art_1 des Umschlagplatzes (0: normaler Markt; 1: Lager; 2: Verteilzentrum : -1 System. Neu könnten hier auch noch Mitbewerbermärkte geführt werden.'),
WUP_NAME_V STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='Marktbezeichnung für den Vertrieb (aus Hyperion gepflegt)'),
WUP_NAME_E STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='Marktbezeichnung für den Einkauf (aus SAP gepflegt)'),
WUP_STANDORT STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Ortsbezeichnung'),
WUP_PLZ STRING(40) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Postleitzahl'),
WUP_STR STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Strasse'),
VF_ID INTEGER DEFAULT 0 OPTIONS(description='Vertriebsform (Kaufland, Handelshof,...)'),
VKL_ID INTEGER DEFAULT - 1 OPTIONS(description='Verkaufsleiter - kommt aus der Hyperion - Schnittstelle'),
HL_ID INTEGER OPTIONS(description='Hausleiter'),
DAT_BIS DATE DEFAULT CAST('9999-12-31' AS DATE) OPTIONS(description='Schließungsdatum Format\'YYYY-MM_1-DD\''),
LEAD_MWST NUMERIC(9,3) OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
UEBERNAHME_VON STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='von welchem Mitbewerber wurde der Markt übernommen'),
BREAKEVENUMSATZ NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Kennzahl, kommt aus Hyperion'),
SYSTEMRENTABILITAET NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Kennzahl, kommt aus Hyperion'),
VERKAUFSFLAECHE NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Verkaufsfläche des Marktes'),
BETRIEBSFLAECHE NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Betriebsfläche des Marktes'),
FLEISCHSYSTEM INTEGER DEFAULT 0 OPTIONS(description='Kennzeichnung, ob Fleischtheke vorhanden. Wird z.Zt nicht benutzt'),
PREISKATEGORIE_FOOD INTEGER
OPTIONS(description='Preiskategorie Food für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
PREISKATEGORIE_NONFOOD INTEGER
OPTIONS(description='Preiskategorie Nonfood für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
SORTKATEGORIE_FOOD INTEGER
OPTIONS(description='Sortimentskategorie Food für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
SORTKATEGORIE_NONFOOD INTEGER
OPTIONS(description='Preiskategorie Nonfood für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe. Ist z.Zt. immer mit Null gefüllt'),
SONDERMARKT INTEGER OPTIONS(description='wird z.Zt. nicht benutzt'),
REF_WUP_ID INTEGER DEFAULT 0 OPTIONS(description='wird z.Zt. nicht benutzt'),
WM_ID INTEGER DEFAULT - 1 OPTIONS(description='Warenmanager ID'),
KASSENTYP STRING(40) DEFAULT '          '
OPTIONS(description='im Markt benutztes Kassensystem (aus ods_bon_transaction.kassensystem_name)'),
DAT_QBM_UMSTELLUNG DATE OPTIONS(description='Datum seit wann QBM (oder die aktuelle QBM-Version) im Markt aktiv ist'),
GETRAENKEMARKT_FG INTEGER DEFAULT 0 OPTIONS(description='Getränkemarkt Flag'),
KUNDENFAKTOR BIGNUMERIC(11,10) DEFAULT 1
OPTIONS(description='Korrekturfaktor zur Ermittlung der Anzahl der Kunden, bei Märkten mit Getränkemarkt angewendet'),
VZ_WUP_ID INTEGER OPTIONS(description='Beim wup_1 vom Typ\"Lager\" ist hier das Verteilzentrum eingetragen'),
QBM_ID INTEGER OPTIONS(description='Kennzeichnung, ob der Markt über ein QBM-System verfügt (Reklamationsabwicklung)'),
WUP_ID_ALT INTEGER OPTIONS(description='Bei Wechsel der Marktnummer wird hier die alte Marktnummer hinterlegt'),
VERKAUFSORGANISATION_ID STRING(4) COLLATE 'und:ci'
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
BUCHUNGSKREIS_ID INTEGER
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland WH Oranienburg GmbH'),
DAT_EROEFFNUNG DATE OPTIONS(description='\"Echtes\" Eröffnungsdatum des Marktes. Kann von dat_von abweichen.'),
BEWERTUNGSKREIS_ID STRING(16) COLLATE 'und:ci' DEFAULT '    '
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt'),
WUP_STADT STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Ort aus der Adresse des Marktes'),
HAUPT_WUP_ID INTEGER
OPTIONS(description='Hier ist der uebergeordnete wup_1 gespeichert, falls mehrere wup_ids logisch zusammengehoeren (z.Bsp. Restaurant zu Markt)'),
KREISTYP_GRUPPE_ID STRING(16) COLLATE 'und:ci' OPTIONS(description='Region_1 / Gruppierung Kreistypen'),
DAT_UMSTELLUNG_WAAGE DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Datum, ab dem die Waagendaten sich im DWH befinden. Default ist der 31.12.9999'),
DAT_VON_ALT DATE OPTIONS(description='Nur bei Umzugsfilialen gefüllt: Das dat_von der Vorgänger-Filiale'),
DAT_EROEFFNUNG_ALT DATE OPTIONS(description='Nur bei Umzugsfilialen gefüllt: Das Eröffnungsdatum der Vorgänger-Filiale'),
UMZUGSFILIALE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Ist = 1 bei geschlossenen Filialen, für die eine_1 Nachfolger-Filiale existiert. Sonst = 0'),
WUP_AENDERUNG_GRUND_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Numerischer Code fuer den Grund der WUP_1 ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup_1 ID.\n            Moegliche Auspraegungen:\n            0 = keine Aenderung\n            1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)\n            2 = Umzug (seit Einfuehrung der Filialumgliederungen)\n            3 = Umgliederung\n            4 = Abriss / Neubau'),
GF_ID INTEGER DEFAULT - 1
OPTIONS(description='Geschäftsführer ID, numerisch. Wird hierzur Performancesteigerung denormalisiert abgelegt, um den CROSS JOIN zur VKL_1-Tabelle zu ersparen'),
UMSATZ_EA_EUR NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Euro - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht'),
UMSATZ_EA_LAND NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Landeswährung - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht. Umrechnung über Kurstabelle vom Anwender nicht erwünscht.'),
BREITENGRAD BIGNUMERIC(29,16) OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'),
LAENGENGRAD BIGNUMERIC(29,16) OPTIONS(description='Längengrad aus dem GIS-System (Longitude)'),
GIS_QUALI_ID INTEGER DEFAULT - 1 OPTIONS(description='Numerische ID des GIS Qualitätskennzeichens. '),
GLN_ID STRING(80) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Global Location_1 Number - international  eindeutige Kennzeichnung der Lokation. Quelle ist KNA1_1 (Retail) mit den Feldern bbbnr(Basisnummer), bbsnr(Individueller Nummernteil) und bubkz(Prüfziffer)'),
FIPO_PRUEF_OBJEKT_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='eindeutige ID eines Prüfobjekts aus dem Quellfeld pob_id'),
ADRESSE_ID INTEGER DEFAULT - 1
OPTIONS(description='Adressnummer aus dem Quellfeld adrnr. Referenz zur SAP Tabelle adrc_1 (im DWH nicht vorhanden)'),
DAT_DAYFORCE_AB DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Datum, ab dem die Personaldaten aus'),
MANDANT_ID_URSPRUNG INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='ursprüngliche Mandant_1 ID DWH bezüglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumänien verwaltet, deshalb wird in diesem Feld die Mandant_1 ID von Rumänien gespeichert'),
EIGENTUM_MIETE_KZ STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen, ob es sich bei der Filiale um Eigentum (=E) oder Mietobjekt (=M) handelt (kann auch null sein, wenn nicht definiert)'),
DAT_LETZTE_MODERNISIERUNG_VON DATE OPTIONS(description='Datum Start letzte Modernisierungsmaßnahme (Format JJJJ-MM_1-TT)'),
DAT_LETZTE_MODERNISIERUNG_BIS DATE OPTIONS(description='Datum Ende letzte Modernisierungsmaßnahme (Format JJJJ-MM_1-TT)'),
DAT_LETZTER_FACELIFT DATE OPTIONS(description='Datum Start letzter Facelift (Format JJJJ-MM_1-TT)'),
DAT_WIEDEREROEFFNUNG DATE
OPTIONS(description='Datum der Wiedereröffnung bei Abriss/Neubau, bei denen die Marktnummer gleich bleibt (Datum wird manuell gepflegt, da keine Quelle)'),
EINWOHNER_ANZAHL INTEGER OPTIONS(description='Einwohner je Markt. Manuelle Befüllung'),
UMSATZ_ERWARTUNG_EUR NUMERIC(18,2) OPTIONS(description='Umsatz Erwartung je Markt. Manuelle Befüllung'),
DAT_LETZTER__FACELIFT_VON DATE OPTIONS(description='Datum des letzten Facelifts des Marktes. Manuelle Befüllung'),
FILIALTYP_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Filialtypisierung für Sortimentskonzept. (VT Orga INTEGER). Wird jaehrlich manuell aktualisiert.'),
ETAGEN_ANZ INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Anzahl der Etagen, Aktuell liegt diese Information nur für Filialen vor (nb_id = 0). Der Standardwert gilt nur für Filialen. (manuell gepflegt)'),
ORIG_WUP_ID INTEGER OPTIONS(description='Originale / urspruengliche WUP_1 ID dieser Filiale.'),
AKTUELL_WUP_ID INTEGER OPTIONS(description='Aktuelle WUP_1 ID dieser Filiale.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (WUP_ID, NB_ID, MANDANT_ID) NOT ENFORCED
)
OPTIONS(description='VIS TP2  - Warenumschlagsplatz. Enthält Maerkte, Restaurants, Tankstellen, Laeger und Verteilzentren');