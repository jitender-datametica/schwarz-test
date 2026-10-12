create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_KOSTENPROGNOSE_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID eines Gewerks , z.Bsp 3 = Baukosten',
	WARENGRUPPE_CD COMMENT 'Code der Warengruppe',
	DAT_VERSION COMMENT 'Datum der Version der Kostenprognose',
	VERSION_NR COMMENT 'Versionsnummer der Kostenprognose',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_KOSTENPROGNOSE COMMENT 'Betrag der Kostenprognose in Landeswährung',
	BETRAG_ZEK COMMENT 'Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)',
	BETRAG_ZEA COMMENT 'Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'
) COMMENT='Enthält Kostenprognosen für die Warengruppen pro Gewerk im jeweiligen Projekt.'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        gewerk_id,
        warengruppe_cd,
        dat_version,
        version_nr,
        wrg_id,
        betrag_kostenprognose,
        betrag_zek,
        betrag_zea

FROM DBP_DATA.ZB_PROJEKT_KOSTENPROGNOSE_1 ;
