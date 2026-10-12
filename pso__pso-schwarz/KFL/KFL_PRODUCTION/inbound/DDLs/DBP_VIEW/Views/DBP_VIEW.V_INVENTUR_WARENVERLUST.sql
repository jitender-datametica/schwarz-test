create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_INVENTUR_WARENVERLUST(
	MANDANT_ID COMMENT 'Mandant im DWH.',
	INVENTUR_ID COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
	WUP_ID COMMENT 'Der \""WUP\"" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter WUP ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	INVENTURART_ID COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
	DAT_INVENTUR_VON COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.',
	DAT_INVENTUR_BIS COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.',
	DAT_INVENTUR_BUCHUNG_VON COMMENT 'Start des betrachteten Inventurzeitraums nach Verbuchung der Inventur in SAP.',
	DAT_INVENTUR_BUCHUNG_BIS COMMENT 'Ende des betrachteten Inventurzeitraums nach Verbuchung der Inventur in SAP.',
	GJ COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
	ART_ID COMMENT 'Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
	WG_ID COMMENT 'ID der Warengruppe',
	OWG_ID COMMENT 'ID der Oberwarengruppe',
	HWG_ID COMMENT 'ID der Hauptwarengruppe',
	ABT_ID COMMENT 'Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.',
	LOESCH_FG COMMENT 'Löschkennzeichen, das nachträglich durch VT Orga in den Ländern gesetzt werden kann, falls Zeitraum oder Inventurart aus der Betrachtung herausgenommen werden soll.'
) as 
    SELECT 
        mandant_id,
        inventur_id,
        wup_id,
        nb_id,
        inventurart_id,
        dat_inventur_von,
        dat_inventur_bis,
        dat_inventur_buchung_von,
        dat_inventur_buchung_bis,
        gj,
        art_id,
        wg_id,
        owg_id,
        hwg_id,
        abt_id,
        loesch_fg

FROM DBP_DATA.INVENTUR_WARENVERLUST ;
