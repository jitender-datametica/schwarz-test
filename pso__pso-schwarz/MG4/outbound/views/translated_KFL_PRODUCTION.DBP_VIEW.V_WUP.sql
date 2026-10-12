CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup (wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), mandant_id
OPTIONS(description='Mandant im DWH'), vw_id
OPTIONS(description='ID des Vertriebsweges. Einkaufs-Sicht auf die wup Objekte (Restaurants und Backshops z.Bsp. haben keinen Vertriebsweg)'),
vs_id OPTIONS(description='ID der Vertriebsschiene. Vertriebs-Sicht auf die wup Objekte'), land_id
OPTIONS(description='Land, in dem sich der Markt befindet (PL, CZ, DE,..)'), region_id
OPTIONS(description='Bundesland, in dem sich der Markt befindet'), dat_von
OPTIONS(description='Eröffnungsdatum. Muss nicht der 1. Abverkaufstag sein! Format YYYY-MM-DD'), wup_typ_id
OPTIONS(description='entspricht der Kennzeichnung der Art des Umschlagplatzes (0: normaler Markt; 1: Lager; 2: Verteilzentrum : -1 System. Neu könnten hier auch noch Mitbewerbermärkte geführt werden.'),
wup_name_v OPTIONS(description='Marktbezeichnung für den Vertrieb (aus Hyperion gepflegt)'), wup_name_e
OPTIONS(description='Marktbezeichnung für den Einkauf (aus SAP gepflegt)'), wup_standort
OPTIONS(description='Ortsbezeichnung'), wup_plz OPTIONS(description='Postleitzahl'), wup_str
OPTIONS(description='Strasse'), vf_id OPTIONS(description='Vertriebsform (Kaufland, Handelshof,...)'), vkl_id
OPTIONS(description='Verkaufsleiter - kommt aus der Hyperion - Schnittstelle'), hl_id OPTIONS(description='Hausleiter'),
dat_bis OPTIONS(description='Schließungsdatum Format\'YYYY-MM-DD\''), lead_mwst
OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'), uebernahme_von
OPTIONS(description='von welchem Mitbewerber wurde der Markt übernommen'), breakevenumsatz
OPTIONS(description='Kennzahl, kommt aus Hyperion'), systemrentabilitaet
OPTIONS(description='Kennzahl, kommt aus Hyperion'), verkaufsflaeche OPTIONS(description='Verkaufsfläche des Marktes'),
betriebsflaeche OPTIONS(description='Betriebsfläche des Marktes'), fleischsystem
OPTIONS(description='Kennzeichnung, ob Fleischtheke vorhanden. Wird z.Zt nicht benutzt'), preiskategorie_food
OPTIONS(description='Preiskategorie Food für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
preiskategorie_nonfood
OPTIONS(description='Preiskategorie Nonfood für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
sortkategorie_food
OPTIONS(description='Sortimentskategorie Food für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'),
sortkategorie_nonfood
OPTIONS(description='Preiskategorie Nonfood für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe. Ist z.Zt. immer mit Null gefüllt'),
sondermarkt OPTIONS(description='wird z.Zt. nicht benutzt'), ref_wup_id OPTIONS(description='wird z.Zt. nicht benutzt'),
wm_id OPTIONS(description='Warenmanager ID'), kassentyp
OPTIONS(description='im Markt benutztes Kassensystem (aus ods_bon_transaction.kassensystem_name)'), dat_qbm_umstellung
OPTIONS(description='Datum seit wann QBM (oder die aktuelle QBM-Version) im Markt aktiv ist'), getraenkemarkt_fg
OPTIONS(description='Getränkemarkt Flag'), kundenfaktor
OPTIONS(description='Korrekturfaktor zur Ermittlung der Anzahl der Kunden, bei Märkten mit Getränkemarkt angewendet'),
vz_wup_id OPTIONS(description='Beim wup vom Typ\"Lager\" ist hier das Verteilzentrum eingetragen'), qbm_id
OPTIONS(description='Kennzeichnung, ob der Markt über ein QBM-System verfügt (Reklamationsabwicklung)'), wup_id_alt
OPTIONS(description='Bei Wechsel der Marktnummer wird hier die alte Marktnummer hinterlegt'), verkaufsorganisation_id
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'),
buchungskreis_id
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland WH Oranienburg GmbH'),
dat_eroeffnung OPTIONS(description='\"Echtes\" Eröffnungsdatum des Marktes. Kann von dat_von abweichen.'),
bewertungskreis_id
OPTIONS(description='der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt'),
wup_stadt OPTIONS(description='Ort aus der Adresse des Marktes'), haupt_wup_id
OPTIONS(description='Hier ist der uebergeordnete wup gespeichert, falls mehrere wup_ids logisch zusammengehoeren (z.Bsp. Restaurant zu Markt)'),
kreistyp_gruppe_id OPTIONS(description='Region / Gruppierung Kreistypen'), dat_umstellung_waage
OPTIONS(description='Datum, ab dem die Waagendaten sich im DWH befinden. Default ist der 31.12.9999'), dat_von_alt
OPTIONS(description='Nur bei Umzugsfilialen gefüllt: Das dat_von der Vorgänger-Filiale'), dat_eroeffnung_alt
OPTIONS(description='Nur bei Umzugsfilialen gefüllt: Das Eröffnungsdatum der Vorgänger-Filiale'), umzugsfiliale_fg
OPTIONS(description='Ist = 1 bei geschlossenen Filialen, für die eine Nachfolger-Filiale existiert. Sonst = 0'),
wup_aenderung_grund_id
OPTIONS(description='Numerischer Code fuer den Grund der WUP ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup ID.\nMoegliche Auspraegungen:\n0 = keine Aenderung\n1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)\n2 = Umzug (seit Einfuehrung der Filialumgliederungen)\n3 = Umgliederung\n4 = Abriss / Neubau'),
gf_id
OPTIONS(description='Geschäftsführer ID, numerisch. Wird hierzur Performancesteigerung denormalisiert abgelegt, um den CROSS JOIN zur VKL-Tabelle zu ersparen'),
umsatz_ea_eur
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Euro - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht'),
umsatz_ea_land
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Landeswährung - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht. Umrechnung über Kurstabelle vom Anwender nicht erwünscht.'),
breitengrad OPTIONS(description='Breitengrad aus dem GIS-System (Latitude)'), laengengrad
OPTIONS(description='Längengrad aus dem GIS-System (Longitude)'), gis_quali_id
OPTIONS(description='Numerische ID des GIS Qualitätskennzeichens. '), gln_id
OPTIONS(description='Global Location Number - international  eindeutige Kennzeichnung der Lokation. Quelle ist KNA1 (Retail) mit den Feldern bbbnr(Basisnummer), bbsnr(Individueller Nummernteil) und bubkz(Prüfziffer)'),
fipo_pruef_objekt_id OPTIONS(description='eindeutige ID eines Prüfobjekts aus dem Quellfeld pob_id'), adresse_id
OPTIONS(description='Adressnummer aus dem Quellfeld adrnr. Referenz zur SAP Tabelle adrc (im DWH nicht vorhanden)'),
dat_dayforce_ab OPTIONS(description='Datum, ab dem die Personaldaten aus'), mandant_id_ursprung
OPTIONS(description='ursprüngliche Mandant ID DWH bezüglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumänien verwaltet, deshalb wird in diesem Feld die Mandant ID von Rumänien gespeichert'),
eigentum_miete_kz
OPTIONS(description='Kennzeichen, ob es sich bei der Filiale um Eigentum (=E) oder Mietobjekt (=M) handelt (kann auch null sein, wenn nicht definiert)'),
dat_letzte_modernisierung_von OPTIONS(description='Datum Start letzte Modernisierungsmaßnahme (Format JJJJ-MM-TT)'),
dat_letzte_modernisierung_bis OPTIONS(description='Datum Ende letzte Modernisierungsmaßnahme (Format JJJJ-MM-TT)'),
dat_letzter_facelift OPTIONS(description='Datum Start letzter Facelift (Format JJJJ-MM-TT)'), dat_wiedereroeffnung
OPTIONS(description='Datum der Wiedereröffnung bei Abriss/Neubau, bei denen die Marktnummer gleich bleibt (Datum wird manuell gepflegt, da keine Quelle)'),
einwohner_anzahl OPTIONS(description='Einwohner je Markt. Manuelle Befüllung'), umsatz_erwartung_eur
OPTIONS(description='Umsatz Erwartung je Markt. Manuelle Befüllung'), dat_letzter__facelift_von
OPTIONS(description='Datum des letzten Facelifts des Marktes. Manuelle Befüllung'), filialtyp_id
OPTIONS(description='Filialtypisierung für Sortimentskonzept. (VT Orga INTEGER ). Wird jaehrlich manuell aktualisiert.'),
etagen_anz
OPTIONS(description='Anzahl der Etagen, Aktuell liegt diese Information nur für Filialen vor (nb_id = 0). Der Standardwert gilt nur für Filialen. (manuell gepflegt)'),
orig_wup_id OPTIONS(description='Originale / urspruengliche WUP ID dieser Filiale.'), aktuell_wup_id
OPTIONS(description='Aktuelle WUP ID dieser Filiale.')) AS SELECT wup_id,
 nb_id,
 mandant_id,
 vw_id,
 vs_id,
 land_id,
 region_id,
 dat_von,
 wup_typ_id,
 wup_name_v,
 wup_name_e,
 wup_standort,
 wup_plz,
 wup_str,
 vf_id,
 vkl_id,
 hl_id,
 dat_bis,
 lead_mwst,
 uebernahme_von,
 breakevenumsatz,
 systemrentabilitaet,
 verkaufsflaeche,
 betriebsflaeche,
 fleischsystem,
 preiskategorie_food,
 preiskategorie_nonfood,
 sortkategorie_food,
 sortkategorie_nonfood,
 sondermarkt,
 ref_wup_id,
 wm_id,
 kassentyp,
 dat_qbm_umstellung,
 getraenkemarkt_fg,
 kundenfaktor,
 vz_wup_id,
 qbm_id,
 wup_id_alt,
 verkaufsorganisation_id,
 buchungskreis_id,
 dat_eroeffnung,
 bewertungskreis_id,
 wup_stadt,
 haupt_wup_id,
 kreistyp_gruppe_id,
 dat_umstellung_waage,
 dat_von_alt,
 dat_eroeffnung_alt,
 umzugsfiliale_fg,
 wup_aenderung_grund_id,
 gf_id,
 umsatz_ea_eur,
 umsatz_ea_land,
 breitengrad,
 laengengrad,
 gis_quali_id,
 gln_id,
 fipo_pruef_objekt_id,
 adresse_id,
 dat_dayforce_ab,
 mandant_id_ursprung,
 eigentum_miete_kz,
 dat_letzte_modernisierung_von,
 dat_letzte_modernisierung_bis,
 dat_letzter_facelift,
 dat_wiedereroeffnung,
 einwohner_anzahl,
 umsatz_erwartung_eur,
 dat_letzter__facelift_von,
 filialtyp_id,
 etagen_anz,
 orig_wup_id,
 aktuell_wup_id
FROM kfl_production_dbp_data.wup;