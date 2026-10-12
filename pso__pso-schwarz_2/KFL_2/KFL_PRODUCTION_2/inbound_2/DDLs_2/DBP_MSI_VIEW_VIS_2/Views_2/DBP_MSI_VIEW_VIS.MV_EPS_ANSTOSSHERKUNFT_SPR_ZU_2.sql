CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_ANSTOSSHERKUNFT_SPR_ZU_2
AS
   SELECT DISTINCT
   anstossherkunft_kz
, Max(CASE WHEN spr_id =  22 THEN anstossherkunft_bez END)                                   AS anstossherkunft_bez_de
, anstossherkunft_bez_de                                                                     AS anstossherkunft_bez       -- DE
, Coalesce(Max(CASE WHEN spr_id = 124 THEN anstossherkunft_bez END), anstossherkunft_bez_de) AS anstossherkunft_bez_cz    -- CZ
, Coalesce(Max(CASE WHEN spr_id = 108 THEN anstossherkunft_bez END), anstossherkunft_bez_de) AS anstossherkunft_bez_sk    -- SK
, Coalesce(Max(CASE WHEN spr_id =  65 THEN anstossherkunft_bez END), anstossherkunft_bez_de) AS anstossherkunft_bez_hr    -- HR
, Coalesce(Max(CASE WHEN spr_id =  90 THEN anstossherkunft_bez END), anstossherkunft_bez_de) AS anstossherkunft_bez_pl    -- PL
, Coalesce(Max(CASE WHEN spr_id =  95 THEN anstossherkunft_bez END), anstossherkunft_bez_de) AS anstossherkunft_bez_ro    -- RO
, Coalesce(Max(CASE WHEN spr_id =  18 THEN anstossherkunft_bez END), anstossherkunft_bez_de) AS anstossherkunft_bez_bg    -- BG

FROM dbp_view.v_eps_anstossherkunft_spr_zu_2

GROUP BY anstossherkunft_kz;