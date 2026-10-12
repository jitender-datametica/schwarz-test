CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_dif_typ_spr_zu_1
AS
-- 2020-09-03, AP0068964, nwag2310, Ersterstellung
SELECT
 v01.dif_typ_id
,MAX(CASE WHEN spr_id =  22 THEN dif_typ_bez END) AS dif_typ_bez                 -- standard == DE
,MAX(CASE WHEN spr_id =  22 THEN dif_typ_bez END) AS dif_typ_bez_de                          -- DE
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN dif_typ_bez END), dif_typ_bez_de) AS dif_typ_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN dif_typ_bez END), dif_typ_bez_de) AS dif_typ_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN spr_id =  65 THEN dif_typ_bez END), dif_typ_bez_de) AS dif_typ_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN spr_id =  90 THEN dif_typ_bez END), dif_typ_bez_de) AS dif_typ_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN spr_id =  95 THEN dif_typ_bez END), dif_typ_bez_de) AS dif_typ_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN spr_id =  18 THEN dif_typ_bez END), dif_typ_bez_de) AS dif_typ_bez_bg    -- BG
FROM dbp_view.v_dif_typ_spr_zu_1 v01
GROUP BY
    v01.dif_typ_id;