create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ART_SPR_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH',
	ART_ID COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	SPR_ID COMMENT 'ID der Sprache',
	ART_BEZ COMMENT 'Artikelbezeichnung aus SAP Retail.',
	INT_ART_BEZ COMMENT 'Artikelbezeichnung aus ZSM, Diese können von SAP Retail Bezeichnungen abweichen.(ZSM:Zentrale Stammdaten Management, das verteilt die Bezeichnungen an SAP Retail, das diese überschreiben kann.)'
) as 
    SELECT 
        mandant_id,
        art_id,
        spr_id,
        art_bez,
        int_art_bez
FROM DBP_DATA.ART_SPR_ZU ;
