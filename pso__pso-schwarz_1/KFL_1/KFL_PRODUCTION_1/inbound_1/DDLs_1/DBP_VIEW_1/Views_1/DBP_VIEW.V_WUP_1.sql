CREATE OR REPLACE VIEW DBP_VIEW.V_WUP_1 (
   wup_id                                   COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,vw_id                                    COMMENT 'ID des Vertriebsweges. Einkaufs-Sicht auf die wup_1 Objekte (Restaurants und Backshops z.Bsp. haben keinen Vertriebsweg)'
  ,vs_id                                    COMMENT 'ID der Vertriebsschiene. Vertriebs-Sicht auf die wup_1 Objekte'
  ,land_id                                  COMMENT 'Land_1, in dem sich der Markt befindet (PL, CZ, DE,..)'
  ,region_id                                COMMENT 'Bundesland, in dem sich der Markt befindet'
  ,dat_von                                  COMMENT 'Eröffnungsdatum. Muss nicht der 1. Abverkaufstag sein! Format YYYY-MM_1-DD'
  ,wup_typ_id                               COMMENT 'entspricht der Kennzeichnung der Art_1 des Umschlagplatzes (0: normaler Markt; 1: Lager; 2: Verteilzentrum : -1 System. Neu könnten hier auch noch Mitbewerbermärkte geführt werden.'
  ,wup_name_v                               COMMENT 'Marktbezeichnung für den Vertrieb (aus Hyperion gepflegt)'
  ,wup_name_e                               COMMENT 'Marktbezeichnung für den Einkauf (aus SAP gepflegt)'
  ,wup_standort                             COMMENT 'Ortsbezeichnung'
  ,wup_plz                                  COMMENT 'Postleitzahl'
  ,wup_str                                  COMMENT 'Strasse'
  ,vf_id                                    COMMENT 'Vertriebsform (Kaufland, Handelshof,...)'
  ,vkl_id                                   COMMENT 'Verkaufsleiter - kommt aus der Hyperion - Schnittstelle'
  ,hl_id                                    COMMENT 'Hausleiter'
  ,dat_bis                                  COMMENT 'Schließungsdatum Format ''YYYY-MM_1-DD'''
  ,lead_mwst                                COMMENT 'Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'
  ,uebernahme_von                           COMMENT 'von welchem Mitbewerber wurde der Markt übernommen'
  ,breakevenumsatz                          COMMENT 'Kennzahl, kommt aus Hyperion'
  ,systemrentabilitaet                      COMMENT 'Kennzahl, kommt aus Hyperion'
  ,verkaufsflaeche                          COMMENT 'Verkaufsfläche des Marktes'
  ,betriebsflaeche                          COMMENT 'Betriebsfläche des Marktes'
  ,fleischsystem                            COMMENT 'Kennzeichnung, ob Fleischtheke vorhanden. Wird z.Zt nicht benutzt'
  ,preiskategorie_food                      COMMENT 'Preiskategorie Food für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'
  ,preiskategorie_nonfood                   COMMENT 'Preiskategorie Nonfood für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'
  ,sortkategorie_food                       COMMENT 'Sortimentskategorie Food für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe'
  ,sortkategorie_nonfood                    COMMENT 'Preiskategorie Nonfood für den Markt (wird in TP1 benutzt) In TP2 erfolgt die Zuordnung auf Ebene Markt/Warengruppe. Ist z.Zt. immer mit Null gefüllt'
  ,sondermarkt                              COMMENT 'wird z.Zt. nicht benutzt'
  ,ref_wup_id                               COMMENT 'wird z.Zt. nicht benutzt'
  ,wm_id                                    COMMENT 'Warenmanager ID'
  ,kassentyp                                COMMENT 'im Markt benutztes Kassensystem (aus ods_bon_transaction.kassensystem_name)'
  ,dat_qbm_umstellung                       COMMENT 'Datum seit wann QBM (oder die aktuelle QBM-Version) im Markt aktiv ist'
  ,getraenkemarkt_fg                        COMMENT 'Getränkemarkt Flag'
  ,kundenfaktor                             COMMENT 'Korrekturfaktor zur Ermittlung der Anzahl der Kunden, bei Märkten mit Getränkemarkt angewendet'
  ,vz_wup_id                                COMMENT 'Beim wup_1 vom Typ "Lager" ist hier das Verteilzentrum eingetragen'
  ,qbm_id                                   COMMENT 'Kennzeichnung, ob der Markt über ein QBM-System verfügt (Reklamationsabwicklung)'
  ,wup_id_alt                               COMMENT 'Bei Wechsel der Marktnummer wird hier die alte Marktnummer hinterlegt'
  ,verkaufsorganisation_id                  COMMENT 'Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z. B. KL = Kaufland.'
  ,buchungskreis_id                         COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland WH Oranienburg GmbH'
  ,dat_eroeffnung                           COMMENT '"Echtes" Eröffnungsdatum des Marktes. Kann von dat_von abweichen.'
  ,bewertungskreis_id                       COMMENT 'der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt'
  ,wup_stadt                                COMMENT 'Ort aus der Adresse des Marktes'
  ,haupt_wup_id                             COMMENT 'Hier ist der uebergeordnete wup_1 gespeichert, falls mehrere wup_ids logisch zusammengehoeren (z.Bsp. Restaurant zu Markt)'
  ,kreistyp_gruppe_id                       COMMENT 'Region_1 / Gruppierung Kreistypen'
  ,dat_umstellung_waage                     COMMENT 'Datum, ab dem die Waagendaten sich im DWH befinden. Default ist der 31.12.9999'
  ,dat_von_alt                              COMMENT 'Nur bei Umzugsfilialen gefüllt: Das dat_von der Vorgänger-Filiale'
  ,dat_eroeffnung_alt                       COMMENT 'Nur bei Umzugsfilialen gefüllt: Das Eröffnungsdatum der Vorgänger-Filiale'
  ,umzugsfiliale_fg                         COMMENT 'Ist = 1 bei geschlossenen Filialen, für die eine_1 Nachfolger-Filiale existiert. Sonst = 0'
  ,wup_aenderung_grund_id                   COMMENT 'Numerischer Code fuer den Grund der WUP_1 ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup_1 ID.
Moegliche Auspraegungen:
0 = keine Aenderung
1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)
2 = Umzug (seit Einfuehrung der Filialumgliederungen)
3 = Umgliederung
4 = Abriss / Neubau'
  ,gf_id                                    COMMENT 'Geschäftsführer ID, numerisch. Wird hierzur Performancesteigerung denormalisiert abgelegt, um den Join zur VKL_1-Tabelle zu ersparen'
  ,umsatz_ea_eur                            COMMENT 'Umsatz laut Expansionsauftrag pro Jahr in Euro - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht'
  ,umsatz_ea_land                           COMMENT 'Umsatz laut Expansionsauftrag pro Jahr in Landeswährung - Wert wird manuell gepflegt, da keinne SST zur Expansionsdatenbank besteht. Umrechnung über Kurstabelle vom Anwender nicht erwünscht.'
  ,breitengrad                              COMMENT 'Breitengrad aus dem GIS-System (Latitude)'
  ,laengengrad                              COMMENT 'Längengrad aus dem GIS-System (Longitude)'
  ,gis_quali_id                             COMMENT 'Numerische ID des GIS Qualitätskennzeichens. '
  ,gln_id                                   COMMENT 'Global Location_1 Number - international  eindeutige Kennzeichnung der Lokation. Quelle ist KNA1_1 (Retail) mit den Feldern bbbnr(Basisnummer), bbsnr(Individueller Nummernteil) und bubkz(Prüfziffer)'
  ,fipo_pruef_objekt_id                     COMMENT 'eindeutige ID eines Prüfobjekts aus dem Quellfeld pob_id'
  ,adresse_id                               COMMENT 'Adressnummer aus dem Quellfeld adrnr. Referenz zur SAP Tabelle adrc_1 (im DWH nicht vorhanden)'
  ,dat_dayforce_ab                          COMMENT 'Datum, ab dem die Personaldaten aus'
  ,mandant_id_ursprung                      COMMENT 'ursprüngliche Mandant_1 ID DWH bezüglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumänien verwaltet, deshalb wird in diesem Feld die Mandant_1 ID von Rumänien gespeichert'
  ,eigentum_miete_kz                        COMMENT 'Kennzeichen, ob es sich bei der Filiale um Eigentum (=E) oder Mietobjekt (=M) handelt (kann auch null sein, wenn nicht definiert)'
  ,dat_letzte_modernisierung_von            COMMENT 'Datum Start letzte Modernisierungsmaßnahme (Format JJJJ-MM_1-TT)'
  ,dat_letzte_modernisierung_bis            COMMENT 'Datum Ende letzte Modernisierungsmaßnahme (Format JJJJ-MM_1-TT)'
  ,dat_letzter_facelift                     COMMENT 'Datum Start letzter Facelift (Format JJJJ-MM_1-TT)'
  ,dat_wiedereroeffnung                     COMMENT 'Datum der Wiedereröffnung bei Abriss/Neubau, bei denen die Marktnummer gleich bleibt (Datum wird manuell gepflegt, da keine Quelle)'
  ,einwohner_anzahl                         COMMENT 'Einwohner je Markt. Manuelle Befüllung'
  ,umsatz_erwartung_eur                     COMMENT 'Umsatz Erwartung je Markt. Manuelle Befüllung'
  ,dat_letzter__facelift_von                COMMENT 'Datum des letzten Facelifts des Marktes. Manuelle Befüllung'
  ,filialtyp_id                             COMMENT 'Filialtypisierung für Sortimentskonzept. (VT Orga INT). Wird jaehrlich manuell aktualisiert.'
  ,etagen_anz                               COMMENT 'Anzahl der Etagen, Aktuell liegt diese Information nur für Filialen vor (nb_id = 0). Der Standardwert gilt nur für Filialen. (manuell gepflegt)'
  ,orig_wup_id                              COMMENT 'Originale / urspruengliche WUP_1 ID dieser Filiale.'
  ,aktuell_wup_id                           COMMENT 'Aktuelle WUP_1 ID dieser Filiale.'
)
COMMENT = 'VIS TP2  - Warenumschlagsplatz. Enthält Maerkte, Restaurants, Tankstellen, Laeger und Verteilzentren'
 AS 
    SELECT 
        wup_id,
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

FROM DBP_DATA.WUP_1 ;