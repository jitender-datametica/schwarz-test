CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTIKELTYP_SPR_ZU_1
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_1 / ssch1303 01.02.2022
(
 mandant_id
,artikeltyp_id
,artikeltyp_bez
,artikeltyp_bez_de
,artikeltyp_bez_cz
,artikeltyp_bez_sk
,artikeltyp_bez_hr
,artikeltyp_bez_pl
,artikeltyp_bez_ro
,artikeltyp_bez_bg
)
AS
SELECT
 v01.mandant_id
,v01.artikeltyp_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.artikeltyp_bez END), 'N/A') AS artikeltyp_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.artikeltyp_bez END), 'N/A') AS artikeltyp_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_bg
FROM dbp_view.v_artikeltyp_spr_zu_1 v01
WHERE v01.mandant_id <> 1
GROUP BY
 v01.mandant_id
,v01.artikeltyp_id
,v01.artikeltyp_bez;