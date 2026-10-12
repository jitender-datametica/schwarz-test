CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_KUNDE_ABT(
    MANDANT_ID,
	NB_ID,
	WUP_ID,
	ABT_ID,
	DAT,
	ANZ_KUNDE_ABT,
	ANZ_KUNDE_ABT_WVJ,
	ANZ_KUNDE_ABT_KVJ,
    ANZ_KUNDE_SUG_ABT,
	ANZ_KUNDE_SUG_ABT_WVJ,
	ANZ_KUNDE_SUG_ABT_KVJ
)
AS
    -- FAKT Bons (Kunden) pro Abteilung/Tag
    -- including VJ/Transformations
    -- 2020-09-25 ssch0611 : init, removed prepack, replaces mv_wup_dat_abt_sum
    -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
    -- 2024-11-26 muellerpatri : Erweiterung um Bonanzahl_sug

SELECT
    sub0.mandant_id
    , sub0.nb_id
    , wup.aktuell_wup_id            AS wup_id
    , sub0.abt_id
    , sub0.dat
    , SUM(sub0.ist)                 AS anz_kunde_abt
    , SUM(sub0.wvj)                 AS anz_kunde_abt_wvj
    , SUM(sub0.kvj)                 AS anz_kunde_abt_kvj
    , SUM(sub0.sug_ist)             AS anz_kunde_sug_abt
    , SUM(sub0.sug_wvj)             AS anz_kunde_sug_abt_wvj
    , SUM(sub0.sug_kvj)             AS anz_kunde_sug_abt_kvj
FROM (
SELECT
abt1.mandant_id,
abt1.nb_id,
abt1.wup_id,
abt1.abt_id,
abt1.dat,
abt1.bonanzahl              AS ist,
0::INTEGER                  AS wvj,
0::INTEGER                  AS kvj,
abt1.bonanzahl_sug          AS sug_ist,
0::INTEGER                  AS sug_wvj,
0::INTEGER                  AS sug_kvj
FROM dbp_view.v_wup_dat_abt_sum abt1

UNION ALL
SELECT
abt2.mandant_id,
abt2.nb_id,
abt2.wup_id,
abt2.abt_id,
(abt2.dat + 364)            AS dat,
0::INTEGER                  AS ist,
abt2.bonanzahl              AS wvj,
0::INTEGER                  AS kvj,
0::INTEGER                  AS sug_ist,
abt2.bonanzahl_sug          AS sug_wvj,
0::INTEGER                  AS sug_kvj
FROM dbp_view.v_wup_dat_abt_sum abt2

UNION ALL
SELECT
abt3.mandant_id,
abt3.nb_id,
abt3.wup_id,
abt3.abt_id,
Add_Months(abt3.dat, 12)    AS dat,
0::INTEGER                  AS ist,
0::INTEGER                  AS wvj,
abt3.bonanzahl              AS kvj,
0::INTEGER                  AS sug_ist,
0::INTEGER                  AS sug_wvj,
abt3.bonanzahl_sug          AS sug_kvj
FROM dbp_view.v_wup_dat_abt_sum abt3
) sub0

INNER JOIN dbp_view.v_wup wup
ON sub0.mandant_id = wup.mandant_id AND sub0.wup_id = wup.wup_id

GROUP BY
    sub0.mandant_id
    , sub0.nb_id
    , wup.aktuell_wup_id
    , sub0.dat
    , sub0.abt_id
;