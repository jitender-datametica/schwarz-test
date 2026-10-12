CREATE OR REPLACE VIEW kfl_production_dbp_view.v_udf_prognose_2 (mandant_id OPTIONS(description='Mandant_2 im DWH.'), wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), art_id
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
diagnose_id OPTIONS(description='Diagnoseidentifikator (Regelwerk für die Prognose).'), dat_prognoselauf
OPTIONS(description='Datum des Prognoselaufs (ENTRY_DATE).'), dat OPTIONS(description='Datum im Format JJJJ-MM_2-TT.'),
prognose_horizont
OPTIONS(description='Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von QUANTITY_01 - bis QUANTITY_80 waren gefüllt).'),
menge_prognose_af OPTIONS(description='Aktionsfreier Bedarf in Basismengeneinheit.'), menge_prognose_sa
OPTIONS(description='Werbebedarf in Basismengeneinheit.'), menge_prognose_gesteuert
OPTIONS(description='Manuell gesteuerte Prognose in Basismengeneinheit.'), prognose_trennung_cd
OPTIONS(description='Eindeutige Kennzeichnung der übergeordneten Trennung der Prognosen auf Markt/Artikel_2/Tag_2-Ebene. Sie dient der Unterscheidung zwischen ungesteuerten und gesteuerten Prognosen, die aus PMR-Daten ermittelt und während der Beladung angereichert werden. Mögliche Werte sind AF (Aktionsfrei), SA (Sonderaktion) oder BBY (Bonusbuy/K-Card). Dies ist relevant, da zukünftig die Prognosetrennung nicht mehr über Angebots-IDs in SAP erfolgt, sondern über diese Attribut-Logik im DWH abgebildet wird.'),
prognose_feingliederung_id
OPTIONS(description='Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel_2/Tag_2-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:-1= nicht definiert1= Nur Prospekt2= Prospekt + K-Card3= KDN-only4= KDP-only5= BBY KMO6= Prospekt + BBY KMO'))
OPTIONS(DESCRIPTION = `SCM - Prognosewerte aus SAP UDF - Transparente Tabelle ZUDF_TS_DWH. Die Tabelle UDF_PROGNOSE_2 enthält die durch das SAP-Quellsystem UDF berechneten Abverkaufsprognosen aller prognoserelevanten Artikel_2-Markt-Tag_2-Kombinationen. Die Prognoserelevanz definiert sich dabei über bestimmte Stammdaten-Konstellationen (wie z.B. Dispomerkmal und Postenkennzeichen). Die Prognosen werden mit jedem Prognoselauf (dat_prognoselauf) neu berechnet und stehen für einen Gültigkeitstag (dat) dadurch mehrfach zur Verfügung – hierbei wird stets der Wert für den aktuellsten Gültigkeitstag (dat) für die Ermittlung der Autodispo-Bestellmengen verwendet. Die Prognosen liegen sowohl für den aktionsfreien Bedarf (menge_prognose_af) als auch für den Werbebedarf (menge_prognose_sa) sowie inklusive manueller Prognosesteuerungen (menge_prognose_gesteuert) vor.`)
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
FROM kfl_production_dbp_data.udf_prognose_2;