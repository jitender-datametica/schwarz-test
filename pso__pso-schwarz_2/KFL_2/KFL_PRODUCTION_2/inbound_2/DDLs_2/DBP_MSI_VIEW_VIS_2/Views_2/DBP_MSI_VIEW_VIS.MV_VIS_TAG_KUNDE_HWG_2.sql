create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_TAG_KUNDE_HWG_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	HWG_ID,
	DAT,
	ANZ_KUNDE_HWG,
	ANZ_KUNDE_HWG_WVJ,
	ANZ_KUNDE_HWG_KVJ,
	ANZ_KUNDE_SUG_HWG,
	ANZ_KUNDE_SUG_HWG_WVJ,
	ANZ_KUNDE_SUG_HWG_KVJ
) as
    
    
    
    
    
    
SELECT
    sub0.mandant_id
    , sub0.nb_id
    , wup.aktuell_wup_id        AS wup_id
    , sub0.hwg_id
    , sub0.dat
    , SUM(sub0.ist)             AS anz_kunde_hwg
    , SUM(sub0.wvj)             AS anz_kunde_hwg_wvj
    , SUM(sub0.kvj)             AS anz_kunde_hwg_kvj
    , SUM(sub0.sug_ist)         AS anz_kunde_sug_hwg
    , SUM(sub0.sug_wvj)         AS anz_kunde_sug_hwg_wvj
    , SUM(sub0.sug_kvj)         AS anz_kunde_sug_hwg_kvj
FROM (SELECT
hwg1.mandant_id,
hwg1.nb_id,
hwg1.wup_id,
hwg1.hwg_id,
hwg1.dat,
hwg1.bonanzahl              AS ist,
0::INTEGER                  AS wvj,
0::INTEGER                  AS kvj,
hwg1.bonanzahl_sug          AS sug_ist,
0::INTEGER                  AS sug_wvj,
0::INTEGER                  AS sug_kvj
FROM dbp_view.v_wup_dat_hwg_sum_2 hwg1

UNION ALL
SELECT
hwg2.mandant_id,
hwg2.nb_id,
hwg2.wup_id,
hwg2.hwg_id,
(hwg2.dat + 364)            AS dat,
0::INTEGER                  AS ist,
hwg2.bonanzahl              AS wvj,
0::INTEGER                  AS kvj,
0::INTEGER                  AS sug_ist,
hwg2.bonanzahl_sug          AS sug_wvj,
0::INTEGER                  AS sug_kvj
FROM dbp_view.v_wup_dat_hwg_sum_2 hwg2

UNION ALL
SELECT
hwg3.mandant_id,
hwg3.nb_id,
hwg3.wup_id,
hwg3.hwg_id,
Add_Months(hwg3.dat, 12)    AS dat,
0::INTEGER                  AS ist,
0::INTEGER                  AS wvj,
hwg3.bonanzahl              AS kvj,
0::INTEGER                  AS sug_ist,
0::INTEGER                  AS sug_wvj,
hwg3.bonanzahl_sug          AS sug_kvj
FROM dbp_view.v_wup_dat_hwg_sum_2 hwg3
) sub0

INNER JOIN dbp_view.v_wup_2 wup_2
ON sub0.mandant_id = wup.mandant_id AND sub0.wup_id = wup.wup_id

GROUP BY
    sub0.mandant_id
    , sub0.nb_id
    , wup.aktuell_wup_id
    , sub0.dat
    , sub0.hwg_id
;
