create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_UDF_PROGNOSE_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH.',
	WUP_ID COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	ART_ID COMMENT 'Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
	DIAGNOSE_ID COMMENT 'Diagnoseidentifikator (Regelwerk für die Prognose).',
	DAT_PROGNOSELAUF COMMENT 'Datum des Prognoselaufs (ENTRY_DATE).',
	DAT COMMENT 'Datum im Format JJJJ-MM_1-TT.',
	PROGNOSE_HORIZONT COMMENT 'Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von QUANTITY_01 - bis QUANTITY_80 waren gefüllt).',
	MENGE_PROGNOSE_AF COMMENT 'Aktionsfreier Bedarf in Basismengeneinheit.',
	MENGE_PROGNOSE_SA COMMENT 'Werbebedarf in Basismengeneinheit.',
	MENGE_PROGNOSE_GESTEUERT COMMENT 'Manuell gesteuerte Prognose in Basismengeneinheit.',
	PROGNOSE_TRENNUNG_CD COMMENT 'Eindeutige Kennzeichnung der übergeordneten Trennung der Prognosen auf Markt/Artikel_1/Tag_1-Ebene. Sie dient der Unterscheidung zwischen ungesteuerten und gesteuerten Prognosen, die aus PMR-Daten ermittelt und während der Beladung angereichert werden. Mögliche Werte sind AF (Aktionsfrei), SA (Sonderaktion) oder BBY (Bonusbuy/K-Card). Dies ist relevant, da zukünftig die Prognosetrennung nicht mehr über Angebots-IDs in SAP erfolgt, sondern über diese Attribut-Logik im DWH abgebildet wird.',
	PROGNOSE_FEINGLIEDERUNG_ID COMMENT 'Eindeutige Kennzeichnung der weiteren, feineren Gliederung der Prognosen auf Markt/Artikel_1/Tag_1-Ebene, basierend auf der Logik der prognose_trennung_cd. Sie präzisiert die Prognose-Trennung und wird aus PMR-Daten ermittelt und während der Beladung angereichert. Mögliche Werte:\n-1= nicht definiert\n1= Nur Prospekt\n2= Prospekt + K-Card\n3= KDN-only\n4= KDP-only\n5= BBY KMO\n6= Prospekt + BBY KMO'
) as 
    SELECT 
        mandant_id,
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

FROM DBP_DATA.UDF_PROGNOSE_1 ;
