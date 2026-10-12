create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_INVENTUR_WARENVERLUST_DET_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH.',
	INVENTUR_ID COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
	ART_ID COMMENT 'Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_VK_NETTO COMMENT 'Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.',
	BETRAG_VK_NETTO_PREISABSCHRIFT COMMENT 'Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.',
	BETRAG_VK_NETTO_TOTALABSCHRIFT COMMENT 'Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.',
	MENGE_INVENTUR_DIFF COMMENT 'saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum',
	BETRAG_VK_NETTO_INVENTUR_DIFF COMMENT 'saldierte Inventur_2-Differenz-Werte je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum',
	MENGE_INVENTUR_DIFF_DIEBSTAHL COMMENT 'Menge Diebstahl als Teilmenge der saldierten Inventur_2-Differenz-Mengen',
	BETRAG_VK_NETTO_INVENTUR_DIFF_DIEBSTAHL COMMENT 'Betrag Diebstahl als Teilmenge der Inventur_2-Differenz-Werten',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum'
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

FROM DBP_DATA.INVENTUR_WARENVERLUST_DET_2 ;
