CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_KREISTYP_GRUPPE_SPR_ZU_2
(
mandant_id
, kreistyp_gruppe_id
, kreistyp_gruppe_bez
, kreistyp_gruppe_bez_de
, kreistyp_gruppe_bez_cz
, kreistyp_gruppe_bez_sk
, kreistyp_gruppe_bez_hr
, kreistyp_gruppe_bez_pl
, kreistyp_gruppe_bez_ro
, kreistyp_gruppe_bez_bg

)
AS
   SELECT
   v01.mandant_id, v01.kreistyp_gruppe_id, Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.kreistyp_gruppe_bez END),'N/A') AS kreistyp_gruppe_bez                                                             -- Standard == DE
   , Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.kreistyp_gruppe_bez END),'N/A') AS kreistyp_gruppe_bez_de                                                     -- DE
   , Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_cz  -- CZ
   , Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_sk -- SK
   , Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_ro   -- RO
   , Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.kreistyp_gruppe_bez END), kreistyp_gruppe_bez_de) AS kreistyp_gruppe_bez_bg  -- BG

   FROM dbp_view.v_kreistyp_gruppe_spr_zu_2 v01
   GROUP BY 1,2;