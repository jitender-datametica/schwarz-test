create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_CS_AC.V_BW_EJR_TURNOVER_WRITEOFF_PV_2(
	CLIENT_ID,
	""LAND_2 O08 ISO-CODE"",
	""WG I05 MIS WG ID"",
	""UWG I04 MIS UWG ID"",
	""ARTIKELFAMILIE GRUPPIERT I04 ARTIKELFAMILIENNUMMER"",
	""ARTIKELART (HIST) HI08 ID"",
	""WAEHRUNG X02 BEZEICHNUNG"",
	""MONAT_2 T05 ID"",
	""UMSATZ EJR AUFGEL."",
	""ABSCHRIFTEN_2 GESAMT AUFGEL."",
	""PREISVERAENDERUNG AUFGEL.""
) as
SELECT
  ""Client_id""
, ""Land_2 O08 ISO-Code""
, ""WG I05 MIS WG ID""
, ""UWG I04 MIS UWG ID""
, ""Artikelfamilie gruppiert I04 Artikelfamiliennummer""
, ""Artikelart (hist) HI08 ID""
, ""Waehrung X02 Bezeichnung""
, ""Monat_2 T05 ID""
, ""Umsatz EJR aufgel.""
, ""Abschriften_2 Gesamt aufgel.""
, ""Preisveraenderung aufgel.""
FROM p_lew_mart_cs.v_bw_ejr_turnover_writeoff_pv_2
;
