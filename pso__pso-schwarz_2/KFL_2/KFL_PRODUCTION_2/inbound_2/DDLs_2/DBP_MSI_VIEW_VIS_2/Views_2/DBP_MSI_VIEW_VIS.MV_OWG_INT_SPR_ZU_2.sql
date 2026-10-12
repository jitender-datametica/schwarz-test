CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_OWG_INT_SPR_ZU_2
AS

--original order
select arthiertyp_id, owg_id, owg_bez 
, owg_bez_cz
, owg_bez_sk
, owg_bez_hr
, owg_bez_pl
, owg_bez_ro
, owg_bez_bg
, owg_bez_de
FROM
--reordering to work w Snowflake aliasing
(
  SELECT DISTINCT
   owg.arthiertyp_id, owg.owg_id 
   , MAX(CASE WHEN spr_id = 22 THEN owg_bez ELSE TRIM(owg_id) END) AS owg_bez_de
, owg_bez_de                                                         AS owg_bez       -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN owg_bez END), 
 owg_bez_de) AS owg_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN owg_bez END), 
 owg_bez_de) AS owg_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN owg_bez END), 
 owg_bez_de) AS owg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN owg_bez END), 
 owg_bez_de) AS owg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN owg_bez END), 
 owg_bez_de) AS owg_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN owg_bez END), 
 owg_bez_de) AS owg_bez_bg    -- BG
   FROM dbp_view.v_owg_spr_zu_2  owg
   WHERE owg.arthiertyp_id = 2
   GROUP BY arthiertyp_id, owg_id
  );