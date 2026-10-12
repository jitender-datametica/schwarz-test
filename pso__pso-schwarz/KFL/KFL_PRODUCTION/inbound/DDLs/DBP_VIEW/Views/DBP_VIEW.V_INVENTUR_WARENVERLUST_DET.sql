create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_INVENTUR_WARENVERLUST_DET(
	MANDANT_ID COMMENT 'Mandant im DWH.',
	INVENTUR_ID COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
	ART_ID COMMENT 'Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_VK_NETTO COMMENT 'Umsatz der betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
	BETRAG_VK_NETTO_PREISABSCHRIFT COMMENT 'Wert der Preisabschriften für die betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
	BETRAG_VK_NETTO_TOTALABSCHRIFT COMMENT 'Wert der Totalabschriften für die betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
	MENGE_INVENTUR_DIFF COMMENT 'saldierte Inventur-Differenz-Mengen je Artikel und Betrieb im definierten Inventur-Zeitraum',
	BETRAG_VK_NETTO_INVENTUR_DIFF COMMENT 'saldierte Inventur-Differenz-Werte je Artikel und Betrieb im definierten Inventur-Zeitraum',
	MENGE_INVENTUR_DIFF_DIEBSTAHL COMMENT 'Menge Diebstahl als Teilmenge der saldierten Inventur-Differenz-Mengen',
	BETRAG_VK_NETTO_INVENTUR_DIFF_DIEBSTAHL COMMENT 'Betrag Diebstahl als Teilmenge der Inventur-Differenz-Werten',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum'
) as 
    SELECT 
        mandant_id,
        inventur_id,
        art_id,
        wrg_id,
        betrag_vk_netto,
        betrag_vk_netto_preisabschrift,
        betrag_vk_netto_totalabschrift,
        menge_inventur_diff,
        betrag_vk_netto_inventur_diff,
        menge_inventur_diff_diebstahl,
        betrag_vk_netto_inventur_diff_diebstahl,
        betrag_vk_netto_inventur_diff_plan

FROM DBP_DATA.INVENTUR_WARENVERLUST_DET ;
