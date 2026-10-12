CREATE OR REPLACE VIEW kfl_production_dbp_view.v_udf_prognose (mandant_id OPTIONS(description='Mandant im DWH.'), wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), art_id
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
diagnose_id OPTIONS(description='Diagnoseidentifikator (Regelwerk für die Prognose).'), dat_prognoselauf
OPTIONS(description='Datum des Prognoselaufs (ENTRY_DATE).'), dat OPTIONS(description='Datum im Format JJJJ-MM-TT.'),
prognose_horizont
OPTIONS(description='Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von QUANTITY_01 - bis QUANTITY_80 waren gefüllt).'),
menge_prognose_af OPTIONS(description='Aktionsfreier Bedarf in Basismengeneinheit.'), menge_prognose_sa
OPTIONS(description='Werbebedarf in Basismengeneinheit.'), menge_prognose_gesteuert
OPTIONS(description='Manuell gesteuerte Prognose in Basismengeneinheit.'), prognose_trennung_cd
OPTIONS(description='Eindeutige Kennzeichnung der übergeordneten Trennung der Prognosen auf Markt/Artikel/Tag-Ebene. Sie dient der Unterscheidung zwischen ungesteuerten und gesteuerten Prognosen, die aus PMR-Daten ermittelt und während der Beladung angereichert werden. Mögliche Werte sind AF (Aktionsfrei), SA (Sonderaktion) oder BBY (Bonusbuy/K-Card). Dies ist relevant, da zukünftig die Prognosetrennung nicht mehr über Angebots-IDs in SAP erfolgt, sondern über diese Attribut-Logik im DWH abgebildet wird.'),
prognose_feingliederung_id
OPTIONS(description='Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel/Tag-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:\n-1= nicht definiert\n1= Nur Prospekt\n2= Prospekt + K-Card\n3= KDN-only\n4= KDP-only\n5= BBY KMO\n6= Prospekt + BBY KMO'))
AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 diagnose_id,
 dat_prognoselauf,
 dat,
 prognose_horizont,
 menge_prognose_af,
 menge_prognose_sa,
 menge_prognose_gesteuert,
 prognose_trennung_cd,
 prognose_feingliederung_id
FROM kfl_production_dbp_data.udf_prognose;