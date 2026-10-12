CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_B_PROCESS_PRUEFUNG_ZU_1(
	BUSINESS_PROCESS_ID,
	PRUEFUNG_ID
) AS
 
/*	AMX PROCESS PRUEFUNG ZU : Kurzcheck Business Prozess Zuordnung
	20160322 KKaiser, neu für AP0002158 Audimex
	20191008 twie: SPEC0059324 für dt. AMX Daten temporär eine_1 weitere Tabelle mit manuell befüllten Daten per Union anbinden
	20200211 twie: SPEC0067890 Tabellenname für dt. AMX Daten ersetzen
	20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1

	2024-01-23 INC7947217 : Neuer Filter Business Prozess
*/
 
SELECT 
  business_process_id
, pruefung_id 
FROM dbp_view.v_amx_b_process_pruefung_zu_1
WHERE amx_system_id = 1 /* System 1 = One Audimex */
AND business_process_id = 544687 /* Process 544687 = K_Kurzcheck */
 
UNION ALL /* Daten DE */
SELECT 
  business_process_id
, pruefung_id 
FROM dbp_view.v_amx_de_b_process_pruefung_zu_1
WHERE business_process_id = 544687 /* Process 544687 = K_Kurzcheck */
;