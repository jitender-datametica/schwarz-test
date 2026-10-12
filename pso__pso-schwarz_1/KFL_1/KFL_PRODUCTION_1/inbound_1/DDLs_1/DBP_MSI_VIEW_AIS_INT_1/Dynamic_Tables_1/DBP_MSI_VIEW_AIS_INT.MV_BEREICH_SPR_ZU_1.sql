CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_BEREICH_SPR_ZU_1
(
ber_id
, ber_bez
, ber_bez_de
, ber_bez_cz
, ber_bez_sk
, ber_bez_hr
, ber_bez_pl
, ber_bez_ro
, ber_bez_bg
, mandant_id
, arthiertyp_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS

   SELECT
   v01.wg_hierarchie_id AS ber_id 
   , COALESCE(MAX(CASE WHEN v02.spr_id =  22  THEN v02.wg_hierarchie_bez END),'N/A') AS ber_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id =  22  THEN v02.wg_hierarchie_bez END),'N/A') AS ber_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_bg  -- BG
   , v01.mandant_id
   , v01.arthiertyp_id
   FROM dbp_view.v_wg_hierarchie_zu_per_1 v01
   INNER JOIN dbp_view.v_wg_hierarchie_spr_zu_1 v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.wg_hierarchie_ebene_id = v01.wg_hierarchie_ebene_id
   AND v02.wg_hierarchie_id = v01.wg_hierarchie_id
   AND v02.arthiertyp_id = v01.arthiertyp_id

   WHERE v01.arthiertyp_id = 10
   AND v01.wg_hierarchie_ebene_id = 1
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis
   GROUP BY
   v01.wg_hierarchie_id
   , v01.mandant_id
   , v01.arthiertyp_id;