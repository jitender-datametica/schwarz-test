CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_IMS_SYSTEMSTATUS_SPR_ZU

(systemstatus_id
, mandant_id
, systemstatus_bez_kurz
,systemstatus_bez_kurz_cz
,systemstatus_bez_kurz_sk
,systemstatus_bez_kurz_hr
,systemstatus_bez_kurz_pl
,systemstatus_bez_kurz_ro
,systemstatus_bez_kurz_en
,systemstatus_bez_kurz_bg
, systemstatus_bez
,systemstatus_bez_cz
,systemstatus_bez_sk
,systemstatus_bez_hr
,systemstatus_bez_pl
,systemstatus_bez_ro
,systemstatus_bez_en
,systemstatus_bez_bg
)
AS
   SELECT
   v01.systemstatus_id, v01.mandant_id, MAX(CASE WHEN spr_id =  22 THEN systemstatus_bez_kurz ELSE NULL END) AS systemstatus_bez_kurz                 -- standard == DE
   , MAX(CASE WHEN spr_id = 124 THEN systemstatus_bez_kurz ELSE NULL END) AS systemstatus_bez_kurz_cz    -- CZ
   , MAX(CASE WHEN spr_id = 108 THEN systemstatus_bez_kurz ELSE NULL END) AS systemstatus_bez_kurz_sk    -- SK
   , MAX(CASE WHEN spr_id = 65 THEN systemstatus_bez_kurz ELSE NULL END) AS systemstatus_bez_kurz_hr    -- HR
   , MAX(CASE WHEN spr_id = 90 THEN systemstatus_bez_kurz ELSE NULL END) AS systemstatus_bez_kurz_pl    -- PL
   , MAX(CASE WHEN spr_id = 95 THEN systemstatus_bez_kurz ELSE NULL END) AS systemstatus_bez_kurz_ro    -- RO
   , MAX(CASE WHEN spr_id = 24 THEN systemstatus_bez_kurz ELSE NULL END) AS systemstatus_bez_kurz_en    -- EN
   , MAX(CASE WHEN spr_id = 18 THEN systemstatus_bez_kurz ELSE NULL END) systemstatus_bez_kurz_bg    -- BG
   , MAX(CASE WHEN spr_id =  22 THEN systemstatus_bez ELSE NULL END) AS systemstatus_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id = 124 THEN systemstatus_bez ELSE NULL END) AS systemstatus_bez_cz    -- CZ
   , MAX(CASE WHEN spr_id = 108 THEN systemstatus_bez ELSE NULL END) AS systemstatus_bez_sk    -- SK
   , MAX(CASE WHEN spr_id = 65 THEN systemstatus_bez ELSE NULL END) AS systemstatus_bez_hr    -- HR
   , MAX(CASE WHEN spr_id = 90 THEN systemstatus_bez ELSE NULL END) AS systemstatus_bez_pl    -- PL
   , MAX(CASE WHEN spr_id = 95 THEN systemstatus_bez ELSE NULL END) AS systemstatus_bez_ro    -- RO
   , MAX(CASE WHEN spr_id = 24 THEN systemstatus_bez ELSE NULL END) AS systemstatus_bez_en    -- EN
   , MAX(CASE WHEN spr_id = 18 THEN systemstatus_bez ELSE NULL END) AS systemstatus_bez_bg    -- BG

   FROM dbp_view.v_ims_systemstatus_spr_zu v01
   GROUP BY
   systemstatus_id
   , mandant_id;