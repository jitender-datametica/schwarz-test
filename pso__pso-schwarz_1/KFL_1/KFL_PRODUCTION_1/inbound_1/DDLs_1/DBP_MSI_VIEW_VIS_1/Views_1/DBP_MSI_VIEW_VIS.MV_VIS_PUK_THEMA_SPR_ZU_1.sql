CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_PUK_THEMA_SPR_ZU_1
AS
    -- SPR_1/LU : PUK Kennzahl/Thema
    -- 2020.0124 ssch0611 : INITIAL

SELECT
thema_id,
thema_bez,
thema_bez_cz,
thema_bez_sk,
thema_bez_hr,
thema_bez_pl,
thema_bez_ro,
thema_bez_bg,
thema_bez_de
FROM
(   SELECT
     thema_id,
      Max(CASE WHEN spr_id =  22 THEN thema_bez ELSE Trim(thema_id) END)     AS thema_bez_de,
 thema_bez_de                                                           AS thema_bez       -- DE
   , Coalesce(Max(CASE WHEN spr_id = 124 THEN thema_bez END), 
 thema_bez_de) AS thema_bez_cz    -- CZ
   , Coalesce(Max(CASE WHEN spr_id = 108 THEN thema_bez END), 
 thema_bez_de) AS thema_bez_sk    -- SK
   , Coalesce(Max(CASE WHEN spr_id =  65 THEN thema_bez END), 
 thema_bez_de) AS thema_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN spr_id =  90 THEN thema_bez END), 
 thema_bez_de) AS thema_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN spr_id =  95 THEN thema_bez END), 
 thema_bez_de) AS thema_bez_ro    -- RO
   , Coalesce(Max(CASE WHEN spr_id =  18 THEN thema_bez END), 
 thema_bez_de) AS thema_bez_bg    -- BG
   FROM dbp_data.vis_puk_thema_spr_zu_1

   GROUP BY thema_id) ;