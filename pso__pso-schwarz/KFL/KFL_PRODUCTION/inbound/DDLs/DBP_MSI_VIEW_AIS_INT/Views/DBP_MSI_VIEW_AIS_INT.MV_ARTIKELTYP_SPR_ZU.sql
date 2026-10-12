CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTIKELTYP_SPR_ZU
(
mandant_id
, artikeltyp_id
, artikeltyp_bez
, artikeltyp_bez_de
, artikeltyp_bez_cz
, artikeltyp_bez_sk
, artikeltyp_bez_hr
, artikeltyp_bez_pl
, artikeltyp_bez_ro
, artikeltyp_bez_bg
)
AS
   SELECT
   v01.mandant_id, v01.artikeltyp_id, Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.artikeltyp_bez END),'N/A') AS artikeltyp_bez                                                          -- Standard == DE
   , Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.artikeltyp_bez END),'N/A') AS artikeltyp_bez_de                                                     -- DE
   , Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_cz  -- CZ
   , Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_sk -- SK
   , Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_ro   -- RO
   , Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_bg  -- BG

   FROM dbp_view.v_artikeltyp_spr_zu v01
   GROUP BY 1,2;