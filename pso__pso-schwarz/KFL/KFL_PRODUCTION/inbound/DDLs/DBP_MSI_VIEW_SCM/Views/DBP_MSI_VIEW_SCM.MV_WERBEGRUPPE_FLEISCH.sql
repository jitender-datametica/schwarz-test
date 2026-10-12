CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WERBEGRUPPE_FLEISCH
AS
-- 2020-12-10 | nwag2310 | initial creation
SELECT
v01.marktmerkmal_wert as werbegruppe_fleisch,
Max(CASE WHEN spr_id =  22 THEN marktmerkmal_wert_bez          END) AS werbegruppe_fleisch_bez       -- standard == DE
,
Max(CASE WHEN spr_id =  22 THEN marktmerkmal_wert_bez  END) AS werbegruppe_fleisch_bez_de         -- DE
,
Coalesce(Max(CASE WHEN spr_id = 124 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_cz    -- CZ
,
Coalesce(Max(CASE WHEN spr_id = 108 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_sk    -- SK
,
Coalesce(Max(CASE WHEN spr_id =  65 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_hr    -- HR
,
Coalesce(Max(CASE WHEN spr_id =  90 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_pl    -- PL
,
Coalesce(Max(CASE WHEN spr_id =  95 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_ro    -- RO
,
Coalesce(Max(CASE WHEN spr_id =  18 THEN marktmerkmal_wert_bez END), werbegruppe_fleisch_bez_de) AS werbegruppe_fleisch_bez_bg    -- BG

FROM dbp_view.v_marktmerkmal_wert_spr_zu v01
where v01.marktmerkmal_id='0051'
GROUP BY  v01.marktmerkmal_wert;


