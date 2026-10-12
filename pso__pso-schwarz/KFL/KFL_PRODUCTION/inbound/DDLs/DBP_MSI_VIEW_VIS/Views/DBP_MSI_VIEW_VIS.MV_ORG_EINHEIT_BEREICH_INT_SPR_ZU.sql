CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ORG_EINHEIT_BEREICH_INT_SPR_ZU
AS
   -- LOOKUP/Sprache : Filiale/Bereiche fuer Nettoleistung
   -- 2018.0912 ssch0611 : Intitial - Internationale Version
SELECT
hr_objekt_bereich_id
,hr_objekt_bereich_bez
,hr_objekt_bereich_bez_cz
,hr_objekt_bereich_bez_sk
,hr_objekt_bereich_bez_hr
,hr_objekt_bereich_bez_pl
,hr_objekt_bereich_bez_ro
,hr_objekt_bereich_bez_bg
,hr_objekt_bereich_bez_de
FROM
(
   SELECT DISTINCT
   hr_objekt_bereich_id
   , MAX(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE TRIM(hr_objekt_bereich_id) END) AS hr_objekt_bereich_bez_de -- default value
 ,hr_objekt_bereich_bez_de                                                                       AS hr_objekt_bereich_bez       -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN hr_objekt_bereich_bez END), 
 hr_objekt_bereich_bez_de) AS hr_objekt_bereich_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN hr_objekt_bereich_bez END), 
 hr_objekt_bereich_bez_de) AS hr_objekt_bereich_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN hr_objekt_bereich_bez END), 
 hr_objekt_bereich_bez_de) AS hr_objekt_bereich_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN hr_objekt_bereich_bez END), 
 hr_objekt_bereich_bez_de) AS hr_objekt_bereich_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN hr_objekt_bereich_bez END), 
 hr_objekt_bereich_bez_de) AS hr_objekt_bereich_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN hr_objekt_bereich_bez END), 
 hr_objekt_bereich_bez_de) AS hr_objekt_bereich_bez_bg    -- BG
   FROM dbp_view.v_org_einheit_bereich_spr_zu  oeb

   GROUP BY hr_objekt_bereich_id
)
   ;