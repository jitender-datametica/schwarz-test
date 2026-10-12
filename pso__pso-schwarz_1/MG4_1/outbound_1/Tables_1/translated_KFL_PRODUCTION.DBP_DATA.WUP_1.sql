CREATE OR REPLACE TABLE kfl_production_dbp_data.wup_1 (
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
vw_id INTEGER DEFAULT 0
OPTIONS(description='ID des Vertriebsweges. Einkaufs-Sicht auf die wup_1 Objekte (Restaurants und Backshops z.Bsp. haben keinen Vertriebsweg)'),
vs_id INTEGER DEFAULT 0 OPTIONS(description='ID der Vertriebsschiene. Vertriebs-Sicht auf die wup_1 Objekte'),
land_id STRING(8) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Land_1, in dem sich der Markt befindet (PL, CZ, DE,..)'),
region_id INTEGER OPTIONS(description='Bundesland, in dem sich der Markt befindet'),
dat_von DATE OPTIONS(description='Eröffnungsdatum. Muss nicht der 1. Abverkaufstag sein! Format YYYY-MM_1-DD'),
wup_typ_id INTEGER DEFAULT 0
OPTIONS(description='entspricht der Kennzeichnung der Art_1 des Umschlagplatzes (0: normaler Markt; 1: Lager; 2: Verteilzentrum : -1 System. Neu könnten hier auch noch Mitbewerbermärkte geführt werden.'),
wup_name_v STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='Marktbezeichnung für den Vertrieb (aus Hyperion gepflegt)'),
wup_name_e STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='Marktbezeichnung für den Einkauf (aus SAP gepflegt)'),
wup_standort STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Ortsbezeichnung'),
wup_plz STRING(40) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Postleitzahl'),
wup_str STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Strasse'),
vf_id INTEGER DEFAULT 0 OPTIONS(description='Vertriebsform (Kaufland, Handelshof,...)'),
vkl_id INTEGER DEFAULT - 1 OPTIONS(description='Verkaufsleiter - kommt aus der Hyperion - Schnittstelle'),
hl_id INTEGER OPTIONS(description='Hausleiter'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) OPTIONS(description='Schließungsdatum Format\'YYYY-MM_1-DD\''),
lead_mwst NUMERIC(9,3) OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
uebernahme_von STRING(160) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='von welchem Mitbewerber wurde der Markt übernommen'),
breakevenumsatz NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Kennzahl, kommt aus Hyperion'),
systemrentabilitaet NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Kennzahl, kommt aus Hyperion'),
verkaufsflaeche NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Verkaufsfläche des Marktes'),
betriebsflaeche NUMERIC(18,2) DEFAULT 0 OPTIONS(description='Betriebsfläche des Marktes'),
fleischsystem INTEGER DEFAULT 0 OPTIONS(description='Kennzeichnung, ob Fleischtheke vorhanden. Wird z.Zt nicht benutzt'),
preiskategorie_food INTEGER
OPTIONS(description='Preiskategorie Food für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
preiskategorie_nonfood INTEGER
OPTIONS(description='Preiskategorie Nonfood für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
sortkategorie_food INTEGER
OPTIONS(description='Sortimentskategorie Food für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
sortkategorie_nonfood INTEGER
OPTIONS(description='Preiskategorie Nonfood für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe. Ist z.Zt. immer mit Null gefüllt'),
sondermarkt INTEGER OPTIONS(description='wird z.Zt. nicht benutzt'),
ref_wup_id INTEGER DEFAULT 0 OPTIONS(description='wird z.Zt. nicht benutzt'),
wm_id INTEGER DEFAULT - 1 OPTIONS(description='Warenmanager ID'),
kassentyp STRING(40) DEFAULT '          '
OPTIONS(description='im Markt benutztes Kassensystem (aus ods_bon_transaction.kassensystem_name)'),
dat_qbm_umstellung DATE OPTIONS(description='Datum seit wann QBM (oder die aktuelle QBM-Version) im Markt aktiv ist'),
getraenkemarkt_fg INTEGER DEFAULT 0 OPTIONS(description='Getränkemarkt Flag'),
kundenfaktor BIGNUMERIC(11,10) DEFAULT 1
OPTIONS(description='Korrekturfaktor zur Ermittlung der Anzahl der Kunden, bei Märkten mit Getränkemarkt angewendet'),
vz_wup_id INTEGER OPTIONS(description='Beim wup_1 vom Typ\"Lager\" ist hier das Verteilzentrum eingetragen'),
qbm_id INTEGER OPTIONS(description='Kennzeichnung, ob der Markt über ein QBM-System verfügt (Reklamationsabwicklung)'),
wup_id_alt INTEGER OPTIONS(description='Bei Wechsel der Marktnummer wird hier die alte Marktnummer hinterlegt'),
verkaufsorganisation_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
buchungskreis_id INTEGER
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland WH Oranienburg GmbH'),
dat_eroeffnung DATE OPTIONS(description='\"Echtes\" Eröffnungsdatum des Marktes. Kann von dat_von abweichen.'),
bewertungskreis_id STRING(16) COLLATE 'und:ci' DEFAULT '    '
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt'),
wup_stadt STRING(160) COLLATE 'und:ci' DEFAULT ' ' OPTIONS(description='Ort aus der Adresse des Marktes'),
haupt_wup_id INTEGER
OPTIONS(description='Hier ist der uebergeordnete wup_1 gespeichert, falls mehrere wup_ids logisch zusammengehoeren (z.Bsp. Restaurant zu Markt)'),
kreistyp_gruppe_id STRING(16) COLLATE 'und:ci' OPTIONS(description='Region_1 / Gruppierung Kreistypen'),
dat_umstellung_waage DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Datum, ab dem die Waagendaten sich im DWH befinden. Default ist der 31.12.9999'),
dat_von_alt DATE OPTIONS(description='Nur bei Umzugsfilialen gefüllt: Das dat_von der Vorgänger-Filiale'),
dat_eroeffnung_alt DATE OPTIONS(description='Nur bei Umzugsfilialen gefüllt: Das Eröffnungsdatum der Vorgänger-Filiale'),
umzugsfiliale_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Ist = 1 bei geschlossenen Filialen, für die eine_1 Nachfolger-Filiale existiert. Sonst = 0'),
wup_aenderung_grund_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Numerischer Code fuer den Grund der WUP_1 ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup_1 ID.\n            Moegliche Auspraegungen:\n            0 = keine Aenderung\n            1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)\n            2 = Umzug (seit Einfuehrung der Filialumgliederungen)\n            3 = Umgliederung\n            4 = Abriss / Neubau'),
gf_id INTEGER DEFAULT - 1
OPTIONS(description='Geschäftsführer ID, numerisch. Wird hierzur Performancesteigerung denormalisiert abgelegt, um den CROSS JOIN zur VKL_1-Tabelle zu ersparen'),
umsatz_ea_eur NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Euro - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht'),
umsatz_ea_land NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Landeswährung - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht. Umrechnung über Kurstabelle vom Anwender nicht erwünscht.'),
breitengrad BIGNUMERIC(29,16) OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'),
laengengrad BIGNUMERIC(29,16) OPTIONS(description='Längengrad aus dem GIS-System (Longitude)'),
gis_quali_id INTEGER DEFAULT - 1 OPTIONS(description='Numerische ID des GIS Qualitätskennzeichens. '),
gln_id STRING(80) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Global Location_1 Number - international  eindeutige Kennzeichnung der Lokation. Quelle ist KNA1_1 (Retail) mit den Feldern bbbnr(Basisnummer), bbsnr(Individueller Nummernteil) und bubkz(Prüfziffer)'),
fipo_pruef_objekt_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='eindeutige ID eines Prüfobjekts aus dem Quellfeld pob_id'),
adresse_id INTEGER DEFAULT - 1
OPTIONS(description='Adressnummer aus dem Quellfeld adrnr. Referenz zur SAP Tabelle adrc_1 (im DWH nicht vorhanden)'),
dat_dayforce_ab DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Datum, ab dem die Personaldaten aus'),
mandant_id_ursprung INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='ursprüngliche Mandant_1 ID DWH bezüglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumänien verwaltet, deshalb wird in diesem Feld die Mandant_1 ID von Rumänien gespeichert'),
eigentum_miete_kz STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen, ob es sich bei der Filiale um Eigentum (=E) oder Mietobjekt (=M) handelt (kann auch null sein, wenn nicht definiert)'),
dat_letzte_modernisierung_von DATE OPTIONS(description='Datum Start letzte Modernisierungsmaßnahme (Format JJJJ-MM_1-TT)'),
dat_letzte_modernisierung_bis DATE OPTIONS(description='Datum Ende letzte Modernisierungsmaßnahme (Format JJJJ-MM_1-TT)'),
dat_letzter_facelift DATE OPTIONS(description='Datum Start letzter Facelift (Format JJJJ-MM_1-TT)'),
dat_wiedereroeffnung DATE
OPTIONS(description='Datum der Wiedereröffnung bei Abriss/Neubau, bei denen die Marktnummer gleich bleibt (Datum wird manuell gepflegt, da keine Quelle)'),
einwohner_anzahl INTEGER OPTIONS(description='Einwohner je Markt. Manuelle Befüllung'),
umsatz_erwartung_eur NUMERIC(18,2) OPTIONS(description='Umsatz Erwartung je Markt. Manuelle Befüllung'),
dat_letzter__facelift_von DATE OPTIONS(description='Datum des letzten Facelifts des Marktes. Manuelle Befüllung'),
filialtyp_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Filialtypisierung für Sortimentskonzept. (VT Orga INTEGER ). Wird jaehrlich manuell aktualisiert.'),
etagen_anz INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Anzahl der Etagen, Aktuell liegt diese Information nur für Filialen vor (nb_id = 0). Der Standardwert gilt nur für Filialen. (manuell gepflegt)'),
orig_wup_id INTEGER OPTIONS(description='Originale / urspruengliche WUP_1 ID dieser Filiale.'),
aktuell_wup_id INTEGER OPTIONS(description='Aktuelle WUP_1 ID dieser Filiale.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_id, nb_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='VIS TP2  - Warenumschlagsplatz. Enthält Maerkte, Restaurants, Tankstellen, Laeger und Verteilzentren');