CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_BRUTTO_WUP_1 (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	KJMO,
	GJ,
	UMS_BRUTTO,
	UMS_BRUTTO_KUM,
	UMS_BRUTTO_KVJ,
	UMS_BRUTTO_KVJ_KUM
) AS 
 
 -- FAKT-AGGREGAT Umsatz (brutto) pro Monat_1 - Markt
 -- Datenumfang: 2 GJ
 -- 2011KW37 Initial / nur Umsatz brutto (ohne Abschriften_1) aus Abschriften_1 Aggregat
 -- 2024-08-22 ssch0611 : Filialumgliederung + Review [P1760-DWH]
 
SELECT
  v01.mandant_id
, v01.nb_id
, wup.aktuell_wup_id AS wup_id
, v01.wrg_id
, v01.kjmo
, v01.gj
, v01.ums_brutto
, v01.ums_brutto_kum
, v01.ums_brutto_kvj
, v01.ums_brutto_kvj_kum
FROM dbp_msi_v_view.v_vis_monat_abschriften_wup_1 v01

INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

WHERE v01.abschriftgruppe_id = 100
;