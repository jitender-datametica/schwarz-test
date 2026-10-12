CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_vkl
AS
-- 2021-03-30  nwag2310  AP0084960 - redesign due to ma_spr_zu changes
SELECT
mandant_id,
ma_id         AS vkl_id,
Max(Trim(ma_vorname ||' ' || ma_name)) AS vkl_name
FROM (SELECT
mandant_id,
ma_id,
ma_name,
ma_vorname
FROM dbp_view.v_ma_spr_zu
WHERE (mandant_id, ma_id) IN (SELECT
mandant_id,
vkl_id
FROM dbp_view.v_wup
   WHERE nb_id IN (0, -1, 2, 7) AND vkl_id <> wup_id
)
UNION ALL -- Dummy VKL pro Region

SELECT
mandant_id,
(1000 + mandant_id * 100 + vs_id * 10) * -1::INTEGER,
'--',
''
FROM dbp_view.v_vs

 UNION ALL -- Dummy VKL pro ZF/Maritz 

SELECT
mandant_id,
vkl_id,
wup_standort,
''
FROM dbp_view.v_wup
WHERE nb_id = -1 AND vkl_id = wup_id AND wup_id > 0
) t0
WHERE t0.ma_id <> -1
GROUP BY t0.mandant_id, t0.ma_id
UNION ALL
SELECT
t1.mandant_id,
-1 as vkl_id,
'Alle VKL (DIF)' as vkl_name
FROM dbp_view.v_mandant t1;
