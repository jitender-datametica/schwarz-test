CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_HL_1
(
mandant_id
,hl_id
,hl_name
,hl_name_cz
,hl_name_sk
,hl_name_hr
,hl_name_pl
,hl_name_ro
,hl_name_bg
)
AS
-- 04.06.2019 twie: SPEC0056220 Umstellung auf Mehrsprachig, Logik aus VIS übernommen mit Namen aus der ma_spr_zu_1

   SELECT
   mandant_id, ma_id AS hl_id
   , MAX(CASE WHEN spr_id = 22 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END)    AS hl_name
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)       AS hl_name_cz
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)       AS hl_name_sk
   , COALESCE(MAX(CASE WHEN spr_id =   65 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)       AS hl_name_hr
   , COALESCE(MAX(CASE WHEN spr_id =   90 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)       AS hl_name_pl
   , COALESCE(MAX(CASE WHEN spr_id =   95 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)       AS hl_name_ro
   , COALESCE(MAX(CASE WHEN spr_id =   18 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), hl_name)       AS hl_name_bg

   FROM dbp_view.v_ma_spr_zu_1 msz

   WHERE (mandant_id, ma_id) IN
   (
   SELECT mandant_id, hl_id
   FROM dbp_view.v_wup_1
   UNION ALL
   SELECT mandant_id, (1000 + mandant_id * 100 + vs_id * 10) * -1::INTEGER
   FROM dbp_view.v_vs_1
   )
   GROUP BY
   mandant_id
   ,ma_id;