CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_PUK_TYP_SPR_ZU_1
AS
    -- SPR_1/LU : PUK Typ (Ebene/Ersteller)
    -- 2019.0730 INITIAL 
    -- 2020.0124 ssch0611 : refreshed
select 
puk_typ_id
,puk_typ_bez
,puk_typ_bez_cz
,puk_typ_bez_sk
,puk_typ_bez_hr
,puk_typ_bez_pl
,puk_typ_bez_ro
,puk_typ_bez_bg
,puk_typ_bez_de
from
  (
    SELECT
     puk_typ_id 
     , Max(CASE WHEN spr_id =  22 THEN puk_typ_bez ELSE Trim(puk_typ_id) END) AS puk_typ_bez_de
 ,puk_typ_bez_de                                                             AS puk_typ_bez       -- DE
   , Coalesce(Max(CASE WHEN spr_id = 124 THEN puk_typ_bez END), 
 puk_typ_bez_de) AS puk_typ_bez_cz    -- CZ
   , Coalesce(Max(CASE WHEN spr_id = 108 THEN puk_typ_bez END), 
 puk_typ_bez_de) AS puk_typ_bez_sk    -- SK
   , Coalesce(Max(CASE WHEN spr_id =  65 THEN puk_typ_bez END), 
 puk_typ_bez_de) AS puk_typ_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN spr_id =  90 THEN puk_typ_bez END), 
 puk_typ_bez_de) AS puk_typ_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN spr_id =  95 THEN puk_typ_bez END), 
 puk_typ_bez_de) AS puk_typ_bez_ro    -- RO
   , Coalesce(Max(CASE WHEN spr_id =  18 THEN puk_typ_bez END), 
 puk_typ_bez_de) AS puk_typ_bez_bg    -- BG
   --, Max(CASE WHEN spr_id =  22 THEN puk_typ_bez ELSE Trim(puk_typ_id) END) AS puk_typ_bez_de
   FROM dbp_data.vis_puk_typ_spr_zu_1

   GROUP BY puk_typ_id
   );