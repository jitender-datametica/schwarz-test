create or replace view DBP_MSI_VIEW_RPW_MATERIALIZED.MV_SPANNE_WB_MA(
	RCV_ID,
	NB_ID,
	DAT,
	MANDANT_ID,
	SYSTEM_ID,
	ART_ID,
	BELASTUNGSART_ID,
	BELASTUNGSART_VD_ID,
	WRG_ID,
	BEZUGSWEG_ID,
	OWG_ID,
	ABSCH_MENGE,
	AUFSCH_MENGE,
	EK_NETTO,
	VK_NETTO,
	VK_BRUTTO
) as
-- 20.07.2020 dsim: SPEC0064436 Abschriften view has been created
-- 20.04.2021 sanadze: AP0047531 Erstellung der View auf Snowflake
-- 14.06.2021 richternic: verdichtet Belastungsart_id aufnehmen
-- 19.01.2022 prescherad: SPEC0140144 Umbau auf 1:n Logik für EK Preise
-- 07.02.2022 prescherad: SPEC0140144 Trennung von Abschriten auf Abschriften und Aufschriften
-- 21.12.2022 twie: SPEC0064436 Logik aus AIS_DE übernommen für Untercheidung KG / Gramm bei Absch_Menge und Aufsch_Menge
-- 11.01.2023 twie: SPEC0064436 Kennzahlen Absch_Menge, Aufsch_Menge und ek_netto sollen bei abschriftart_id < 100 keinen Wert ausgeben
--					dafür die Definition aus AIS_DE für Absch_Menge, Aufsch_Menge angepasst
-- 12.04.2023 twie: SPEC0064436 andere Vorzeichenlogik in RPW gewünscht, deshalb bei allen Kennzahlen das Vorzeichen gedreht (* -1)
-- 21.11.2023 prescherad: SPEC0211574, Anpassung EK Preisfindungslogik
-- 24.11.2023 prescherad: SPEC0211574, ek_netto durch ek_netto_bnk ersetzt und mit Abschriftenmenge gewichtet
-- 18.01.2024 prescherad: SPEC0211574, Vorzeichenlogik für Aufschriften positiv für Abschriften negativ
-- 24.04.2024 prescherad;