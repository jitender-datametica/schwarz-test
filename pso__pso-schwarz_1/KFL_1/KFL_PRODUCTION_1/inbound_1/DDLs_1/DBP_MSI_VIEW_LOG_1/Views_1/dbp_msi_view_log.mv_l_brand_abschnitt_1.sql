CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_brand_abschnitt_1 -- 10.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 mandant_id
,lagernummer_id
,brand_abschnitt_id
)
AS
SELECT
v01.mandant_id,
v01.lagernummer_id,
v01.brand_abschnitt_id
FROM dbp_view.v_brand_abschnitt_spr_zu_1 v01
GROUP BY  v01.mandant_id
         ,v01.lagernummer_id
         ,v01.brand_abschnitt_id

UNION
SELECT
v01.mandant_id,
v01.lagernummer_id,
'-1' AS brand_abschnitt_id
FROM dbp_view.v_brand_abschnitt_spr_zu_1 v01
GROUP BY  v01.mandant_id
         ,v01.lagernummer_id
         ,brand_abschnitt_id

UNION
SELECT
v01.mandant_id,
v01.lagernummer_id,
'  ' AS brand_abschnitt_id
FROM dbp_view.v_brand_abschnitt_spr_zu_1 v01
GROUP BY  v01.mandant_id
         ,v01.lagernummer_id
         ,brand_abschnitt_id;
