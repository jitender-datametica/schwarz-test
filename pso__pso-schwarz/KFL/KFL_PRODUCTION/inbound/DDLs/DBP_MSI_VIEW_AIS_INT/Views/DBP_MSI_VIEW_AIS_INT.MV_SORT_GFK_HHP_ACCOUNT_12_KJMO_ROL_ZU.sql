CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_GFK_HHP_ACCOUNT_12_KJMO_ROL_ZU
(
MANDANT_ID,
GFK_ACCOUNT_ID,
GFK_WG_ID,
BEWART_ID,
EIGENMARKE_FRISCHE_FG,
KJMO_BIS,
WRG_ID,
KJMO_VON,
UMSATZ_TSD_EUR,
ANZ_EINKAUF_TSD,
DURCHSCHNITT_EINKAUF,
ANZ_ARTIKEL_EINKAUF,
DURCHSCHNITT_PREIS_ARTIKEL,
ANZ_KAEUFER_TSD,
EINKAUF_FREQUENZ
) 
AS
SELECT
 mandant_id
,gfk_account_id
,gfk_wg_id
,bewart_id
,eigenmarke_frische_kz AS eigenmarke_frische_fg
,kjmo_bis
,wrg_id
,kjmo_von
,umsatz_tsd_eur
,anz_einkauf_tsd
,durchschnitt_einkauf
,anz_artikel_einkauf
,durchschnitt_preis_artikel
,anz_kaeufer_tsd
,einkauf_frequenz
FROM dbp_data.gfk_hhp_wg_account_12_kjmo_rol_zu v01
JOIN dbp_data.monat v02
ON v01.kjmo_bis = v02.kjmo
WHERE akt_mo BETWEEN -36 AND 0
AND (
    (mandant_id IN (1,5,6,8) AND wrg_id  = 'EUR') 
OR (mandant_id = 2 AND wrg_id = 'CZK') 
OR (mandant_id = 3 AND wrg_id = 'PLN') 
OR (mandant_id = 7 AND wrg_id = 'RON')
);
