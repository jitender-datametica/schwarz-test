CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_GFK_HHP_WG_NEBENAUSGABE_KJMO_ZU
(
MANDANT_ID,
GFK_ACCOUNT_ID,
GFK_WG_ID,
KJMO,
WRG_ID,
NEBENAUSGABEN_ANTEIL,
NEBENAUSGABEN_TSD_EUR,
NEBENAUSGABEN_INDEX
)
AS
SELECT
 v01.mandant_id
,v01.gfk_account_id
,v01.gfk_wg_id
,v01.kjmo
,v01.wrg_id
,v01.nebenausgaben_anteil
,v01.nebenausgaben_tsd_eur
,v01.nebenausgaben_index
FROM dbp_data.gfk_hhp_wg_account_na_kjmo_zu v01
JOIN dbp_data.monat v02
ON v01.kjmo = v02.kjmo
WHERE v02.akt_mo BETWEEN -36 AND 0
AND (
    (v01.mandant_id IN (1,5,6,8) AND v01.wrg_id  = 'EUR') 
OR  (v01.mandant_id = 2 AND v01.wrg_id = 'CZK') 
OR  (v01.mandant_id = 3 AND v01.wrg_id = 'PLN') 
OR  (v01.mandant_id = 7 AND v01.wrg_id = 'RON') 
);