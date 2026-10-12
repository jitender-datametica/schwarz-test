CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_bereich_spr_zu
AS
-- 01.12.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
-- 2021-03-29 ssch0611 : review, new base table (PROD only) - AP0077949 
SELECT
bereich_id,
Max(CASE WHEN spr_id =  22 THEN bereich_bez ELSE cast(bereich_id as char(80)) END)           AS bereich_bez_de,
bereich_bez_de                                                                AS bereich_bez   -- default DE
,
Coalesce(Max(CASE WHEN spr_id = 124 THEN bereich_bez END), bereich_bez_de)  AS bereich_bez_cz,
Coalesce(Max(CASE WHEN spr_id =  90 THEN bereich_bez END), bereich_bez_de)  AS bereich_bez_pl,
Coalesce(Max(CASE WHEN spr_id = 108 THEN bereich_bez END), bereich_bez_de)  AS bereich_bez_sk,
Coalesce(Max(CASE WHEN spr_id =  65 THEN bereich_bez END), bereich_bez_de)  AS bereich_bez_hr,
Coalesce(Max(CASE WHEN spr_id =  95 THEN bereich_bez END), bereich_bez_de)  AS bereich_bez_ro,
Coalesce(Max(CASE WHEN spr_id =  18 THEN bereich_bez END), bereich_bez_de)  AS bereich_bez_bg

FROM dbp_view.v_mdl_vis_bereich_spr_zu v01

GROUP BY bereich_id;