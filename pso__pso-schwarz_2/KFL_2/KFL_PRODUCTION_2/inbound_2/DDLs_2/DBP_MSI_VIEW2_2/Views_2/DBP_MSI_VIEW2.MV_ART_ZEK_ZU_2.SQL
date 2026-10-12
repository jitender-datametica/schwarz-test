CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_ZEK_ZU_2
(
 ART_ID
,MANDANT_ID
,ZEK_ID
)
AS
SELECT
-- AP0239494/SPEC0286865 Ersetzen der Logik durch DDL mv_art_2, um FE nicht anzutasten / ssch1303 13.01.2025
-- v01.art_id
--,v01.mandant_id
--,v01.zek_id

--FROM dbp_msi_v_view.v_art_zek_zu_2 v01
--WHERE v01.mandant_id = 1
    DISTINCT art_id
   ,mandant_id
   ,zek_id
   FROM DBP_VIEW.V_ART_2
   WHERE mandant_id = 1
   AND dat_bis = '9999-12-31';