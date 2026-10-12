CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_LAGERPROZESSTYP_SPR_ZU 
-- 27.05.2021, AP0070892, SPEC0112147, knopd, create view

AS
SELECT
v01.lagerprozesstyp_id,
Max(CASE WHEN v01.spr_id =  22 THEN v01.lagerprozesstyp_bez END) AS lagerprozesstyp_bez,               -- standard == DE
Max(CASE WHEN v01.spr_id =  22 THEN v01.lagerprozesstyp_bez END) AS lagerprozesstyp_bez_de,                          -- DE
Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.lagerprozesstyp_bez END), lagerprozesstyp_bez_de) AS lagerprozesstyp_bez_cz,    -- CZ
Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.lagerprozesstyp_bez END), lagerprozesstyp_bez_de) AS lagerprozesstyp_bez_sk,    -- SK
Coalesce(Max(CASE WHEN v01.spr_id =  65 THEN v01.lagerprozesstyp_bez END), lagerprozesstyp_bez_de) AS lagerprozesstyp_bez_hr,    -- HR
Coalesce(Max(CASE WHEN v01.spr_id =  90 THEN v01.lagerprozesstyp_bez END), lagerprozesstyp_bez_de) AS lagerprozesstyp_bez_pl,    -- PL
Coalesce(Max(CASE WHEN v01.spr_id =  95 THEN v01.lagerprozesstyp_bez END), lagerprozesstyp_bez_de) AS lagerprozesstyp_bez_ro,    -- RO
Coalesce(Max(CASE WHEN v01.spr_id =  18 THEN v01.lagerprozesstyp_bez END), lagerprozesstyp_bez_de) AS lagerprozesstyp_bez_bg    -- BG
FROM dbp_view.v_lagerprozesstyp_spr_zu v01
GROUP BY 
        v01.lagerprozesstyp_id;