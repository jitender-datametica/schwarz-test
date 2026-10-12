/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.v_bw_retail_ejr_writeoff_pv_cum_by
#----------------------------------------------------------------------------
# History:
#   1.0      15.11.2023      Ulrich Ross              Init
#                                                     User Story 532005                                                                              
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_bw_retail_ejr_writeoff_pv_cum_by
(
    CLIENT_ID
	, LAND
	, WGI
	, UWG
	, ARTIKELFAMILIE
	, ARTIKELART
	, WAEHRUNG
	, MONAT
	, UMSATZ_EJR_AUFGEL
	, ABSCHRIFTEN_GESAMT_AUFGEL
	, PREISVERAENDERUNG_AUFGEL
)
AS
SELECT	
    CLIENT_ID
	, "LAND O08 ISO-CODE"
	, "WG I05 MIS WG ID"
	, "UWG I04 MIS UWG ID"
	, "ARTIKELFAMILIE GRUPPIERT I04 ARTIKELFAMILIENNUMMER"
	, "ARTIKELART (HIST) HI08 ID"
	, "WAEHRUNG X02 BEZEICHNUNG"
	, "MONAT T05 ID"
	, "UMSATZ EJR AUFGEL."
	, "ABSCHRIFTEN GESAMT AUFGEL."
	, "PREISVERAENDERUNG AUFGEL."
FROM	p_lew_mart_cs.v_bw_retail_ejr_writeoff_pv_cum_by	        
;