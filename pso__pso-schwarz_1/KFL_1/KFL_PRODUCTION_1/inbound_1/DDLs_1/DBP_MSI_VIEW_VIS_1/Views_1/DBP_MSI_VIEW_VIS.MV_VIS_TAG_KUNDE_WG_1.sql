CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_KUNDE_WG_1(
    MANDANT_ID,
	NB_ID,
	WUP_ID,
	WG_ID,
	DAT,
	ANZ_KUNDE_WG,
	ANZ_KUNDE_WG_WVJ,
	ANZ_KUNDE_WG_KVJ,
    ANZ_KUNDE_SUG_WG,
	ANZ_KUNDE_SUG_WG_WVJ,
	ANZ_KUNDE_SUG_WG_KVJ
)
AS
    -- FAKT BONS (KUNDEN) PRO WG/TAG_1
    -- INCLUDING VJ/TRANSFORMATIONS
    -- 2020-11-18 SNIK1809 : INIT, REMOVED PREPACK, REPLACES MV_WUP_DAT_WG_SUM
    -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
    -- 2024-11-26 muellerpatri : Erweiterung um Bonanzahl_sug

SELECT
    SUB0.MANDANT_ID
    , SUB0.NB_ID
    , wup.aktuell_wup_id        AS wup_id
    , SUB0.WG_ID
    , SUB0.DAT
    , SUM(SUB0.IST)             AS ANZ_KUNDE_WG
    , SUM(SUB0.WVJ)             AS ANZ_KUNDE_WG_WVJ
    , SUM(SUB0.KVJ)             AS ANZ_KUNDE_WG_KVJ
    , SUM(sub0.sug_ist)         AS ANZ_KUNDE_SUG_WG
    , SUM(sub0.sug_wvj)         AS ANZ_KUNDE_SUG_WG_WVJ
    , SUM(sub0.sug_kvj)         AS ANZ_KUNDE_SUG_WG_KVJ
FROM (SELECT
WG1.MANDANT_ID,
WG1.NB_ID,
WG1.WUP_ID,
WG1.WG_ID,
WG1.DAT,
WG1.BONANZAHL               AS IST,
0::INTEGER                  AS WVJ,
0::INTEGER                  AS KVJ,
WG1.BONANZAHL_SUG           AS SUG_IST,
0::INTEGER                  AS SUG_WVJ,
0::INTEGER                  AS SUG_KVJ
FROM DBP_VIEW.V_WUP_DAT_WG_SUM_1 WG1

UNION ALL
SELECT
WG2.MANDANT_ID,
WG2.NB_ID,
WG2.WUP_ID,
WG2.WG_ID,
(WG2.DAT + 364)             AS DAT,
0::INTEGER                  AS IST,
WG2.BONANZAHL               AS WVJ,
0::INTEGER                  AS KVJ,
0::INTEGER                  AS SUG_IST,
WG2.BONANZAHL_SUG           AS SUG_WVJ,
0::INTEGER                  AS SUG_KVJ
FROM DBP_VIEW.V_WUP_DAT_WG_SUM_1 WG2

UNION ALL
SELECT
WG3.MANDANT_ID,
WG3.NB_ID,
WG3.WUP_ID,
WG3.WG_ID,
ADD_MONTHS(WG3.DAT, 12)     AS DAT,
0::INTEGER                  AS IST,
0::INTEGER                  AS WVJ,
WG3.BONANZAHL               AS KVJ,
0::INTEGER                  AS SUG_IST,
0::INTEGER                  AS SUG_WVJ,
WG3.BONANZAHL_SUG          AS SUG_KVJ
FROM DBP_VIEW.V_WUP_DAT_WG_SUM_1 WG3
) SUB0

INNER JOIN dbp_view.v_wup_1 wup_1
ON sub0.mandant_id = wup.mandant_id AND sub0.wup_id = wup.wup_id

GROUP BY 
    SUB0.MANDANT_ID
    , SUB0.NB_ID
    , wup.AKTUELL_WUP_ID
    , SUB0.DAT
    , SUB0.WG_ID
;