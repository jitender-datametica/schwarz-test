create or replace view IDQ_PRODUCTION.DWH.IDQ_ADDINFO_ZSM_ART_MIG(
	ID,
	TEST_OBJECT_ID,
	SOURCE_SYSTEM_PRIMARY_KEY,
	SOURCE_SYSTEM_ID,
	COUNTRY_ID,
	BRANCH_ID,
	IS_RELEVANT,
	ARTIKELNUMMER,
	ARTIKELBEZEICHNUNG,
	"ALTE ARTIKELNUMMER",
	ARTIKELART,
	WARENBEREICH,
	WARENGRUPPE,
	BERECHTIGUNGSGRUPPE,
	STATUS,
	ERSTELLUNGSDATUM,
	AENDERUNGSDATUM_AM_STATUS
) as
SELECT ID
      ,TEST_OBJECT_ID
      ,SOURCE_SYSTEM_PRIMARY_KEY
      ,SOURCE_SYSTEM_ID
      ,COUNTRY_ID
      ,BRANCH_ID
      ,IS_RELEVANT
      ,Artikelnummer
      ,Artikelbezeichnung
      ,"Alte Artikelnummer"
      ,Artikelart
      ,Warenbereich
      ,Warengruppe
      ,Berechtigungsgruppe
      ,Status
      ,DATE(Erstellungsdatum) AS Erstellungsdatum
      ,DATE(Aenderungsdatum_am_Status) as Aenderungsdatum_am_Status
  FROM IDQ_RESULTS.IDQ_ADDINFO_ZSM_ART_MIG
;