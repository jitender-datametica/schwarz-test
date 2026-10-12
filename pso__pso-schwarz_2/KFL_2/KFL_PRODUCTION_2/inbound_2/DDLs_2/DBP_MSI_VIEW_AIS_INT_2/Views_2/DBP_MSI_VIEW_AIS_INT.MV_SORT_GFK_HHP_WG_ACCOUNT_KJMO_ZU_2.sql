CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_GFK_HHP_WG_ACCOUNT_KJMO_ZU_2
(
MANDANT_ID,
GFK_ACCOUNT_ID,
GFK_WG_ID,
BEWART_ID,
KJMO,
WRG_ID,
UMSATZ_TSD_EUR,
UMSATZ_POTENZIAL_TSD_EUR,
UMSATZ_POTENZIAL_ANTEIL
)
AS
SELECT
 v01.mandant_id
,v01.gfk_account_id
,v01.gfk_wg_id
,v01.bewart_id
,v01.kjmo
,v01.wrg_id
,v01.umsatz_tsd_eur
,v01.umsatz_potenzial_tsd_eur
,v01.umsatz_potenzial_anteil
FROM dbp_data.gfk_hhp_wg_account_kjmo_zu_2 v01
JOIN dbp_data.monat_2 v02
ON v01.kjmo = v02.kjmo
WHERE v02.akt_mo BETWEEN -36 AND 0
AND (
    (v01.mandant_id IN (1,5,6,8) AND v01.wrg_id  = 'EUR') 
OR  (v01.mandant_id = 2 AND v01.wrg_id = 'CZK') 
OR  (v01.mandant_id = 3 AND v01.wrg_id = 'PLN') 
OR  (v01.mandant_id = 7 AND v01.wrg_id = 'RON')
);